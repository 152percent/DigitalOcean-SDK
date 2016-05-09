/*
  Copyright © 09/05/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

#import "DOAuthenticationController.h"
#import "SPXDefines.h"
#import "NSString+DOAdditions.h"
#import "DOInternal.h"

extern NSString *const DOAuthenticateUserRequestURI;

#if TARGET_OS_IPHONE
@interface DOAuthenticationController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

#else
@import WebKit;

@interface DOAuthenticationController() <WebPolicyDelegate>
@property (nonatomic, strong) WebView *webView;

#endif

@property (nonatomic, strong) DOAuthRequest *authTask;
@end

@implementation DOAuthenticationController

- (id)initWithCoder:(NSCoder *)aDecoder
{
  SPXAssertTrueOrPerformAction(NO, NSLog(@"You must not call init directly on this object! Use one of the specified designated initializers"));
  return [self init];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  SPXAssertTrueOrPerformAction(NO, NSLog(@"You must not call init directly on this object! Use one of the specified designated initializers"));
  return [self init];
}

- (instancetype)initWithDelegate:(id<DOAuthenticationControllerDelegate>)delegate clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret redirectURI:(NSString *)redirectURI
{
#if TARGET_OS_MAC
  self = [super initWithNibName:nil bundle:nil];
#else
  self = [super init];
#endif
  
  SPXAssertTrueOrReturnNil(self);
  SPXAssertTrueOrReturnNil(delegate);
  
  _delegate = delegate;
  _authTask = [[DOAuthRequest alloc] initWithClientID:clientID clientSecret:clientSecret redirectURI:redirectURI];
  
  return self;
}

- (void)loadView
{
#if TARGET_OS_IPHONE
  self.webView = [UIWebView new];
  self.webView.delegate = self;
  self.webView.backgroundColor = [UIColor colorWithRed:0.114 green:0.455 blue:0.765 alpha:1.000];
#else
  self.webView = [WebView new];
  self.webView.policyDelegate = self;
  self.webView.drawsBackground = YES;
  self.webView.wantsLayer = YES;
  self.webView.layer.backgroundColor = [NSColor colorWithCalibratedRed:0.099 green:0.368 blue:0.713 alpha:1.000].CGColor;
#endif
  
  self.view = self.webView;
  
  [self authenticateUser];
}

#pragma mark - Authenticate User

- (void)authenticateUser
{
  NSString *path = [NSString stringWithFormat:DOAuthenticateUserRequestURI, self.authTask.clientID, self.authTask.redirectURI];
  NSURL *url = [NSURL URLWithString:path];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
#if TARGET_OS_IPHONE
  [self.webView loadRequest:request];
#else
  [self.webView.mainFrame loadRequest:request];
#endif
}

#if TARGET_OS_IPHONE

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  NSError *error = nil;
  return [self handleRequest:request error:&error];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [self failWithError:error];
}

#else

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
  NSError *error = nil;
  if ([self handleRequest:request error:&error]) {
    [listener use];
  } else {
    [listener ignore];
    
    if (error) {
      [self failWithError:error];
    }
  }
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
  [self failWithError:error];
}

#endif

- (BOOL)handleRequest:(NSURLRequest *)request error:(NSError * __autoreleasing *)error
{
  NSURL *url = [NSURL URLWithString:self.authTask.redirectURI];
  NSDictionary *params = [request.URL.absoluteString do_queryParameters];
  
  if (params[@"error"]) {
    *error = [NSError errorWithDomain:DOReverseDomain(@"auth") code:102 userInfo:@{ NSLocalizedDescriptionKey : @"The user denied access to their account" }];
    return NO;
  }
  
  if ([url.scheme isEqualToString:request.URL.scheme]) { // time to authorize
    __weak typeof(self) weakInstance = self;
    [self.authTask authorizeToken:params[@"code"] completion:^(DOUser * user, NSError *error) {
      if (error) {
        [weakInstance failWithError:error];
      } else {
        [weakInstance finishWithUser:user];
      }
    }];
    
    return NO;
  }
  
  return YES;
}

#pragma mark - Delegate notifications

- (void)finishWithUser:(DOUser *)user
{
  if ([self.delegate respondsToSelector:@selector(authenticationController:didAuthenticateWithUser:)]) {
    [self.delegate authenticationController:self didAuthenticateWithUser:user];
  }
}

- (void)failWithError:(NSError *)error
{
  // there are some internal errors we don't need to handle
  NSError *innerError = nil;
  
  if (error.code == 102 || error.code == 101) {
    if ([[error.userInfo[NSURLErrorFailingURLStringErrorKey] do_queryParameters][@"error"] isEqualToString:@"access_denied"]) {
      innerError = [NSError errorWithDomain:DOReverseDomain(@"auth") code:DOAuthenticationErrorCodeDenied userInfo:@{ NSLocalizedDescriptionKey : @"The user denied access to their account" }];
    } else {
      return;
    }
  }
  
  if ([self.delegate respondsToSelector:@selector(authenticationController:didFailWithError:)]) {
    [self.delegate authenticationController:self didFailWithError:innerError ?: error];
  }
}

@end