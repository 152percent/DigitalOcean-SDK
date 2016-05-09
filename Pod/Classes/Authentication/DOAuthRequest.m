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

#import "DOAuthRequest.h"
#import "SPXDefines.h"
#import "DOInternal.h"

NSString *const DOAuthenticateUserRequestURI = @"https://cloud.digitalocean.com/v1/oauth/authorize?response_type=code&scope=read+write&client_id=%@&redirect_uri=%@";
NSString *const DOAuthorizeTokenRequestURI = @"https://cloud.digitalocean.com/v1/oauth/token?grant_type=authorization_code&redirect_uri=%@&code=%@&client_id=%@&client_secret=%@";
NSString *const DORefreshTokenRequestURI = @"https://cloud.digitalocean.com/v1/oauth/token?grant_type=refresh_token&client_id=%@&client_secret=%@&refresh_token=%@";
NSString *const DORevokeTokenRequestURI = @"https://cloud.digitalocean.com/v1/oauth/revoke?token=%@";

NSUInteger const DOAuthenticationErrorCodeDenied = 2001;

@interface DOAuthRequest ()
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *redirectURI;
@end

@implementation DOAuthRequest

- (instancetype)init
{
  SPXAssertTrueOrPerformAction(NO, NSLog(@"You must not call init directly on this object! Use one of the specified designated initializers"));
  return [self initWithClientID:@"" clientSecret:@"" redirectURI:@""];
}

- (instancetype)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret redirectURI:(NSString *)redirectURI
{
  self = [super init];

  SPXAssertTrueOrReturnNil(self);
  SPXAssertTrueOrReturnNil(clientID);
  SPXAssertTrueOrReturnNil(clientSecret);
  SPXAssertTrueOrReturnNil(redirectURI);
  
  _clientID = clientID;
  _clientSecret = clientSecret;
  _redirectURI = redirectURI;
  
  return self;
}

- (void)authorizeToken:(NSString *)token completion:(void (^)(DOUser * user, NSError *error))completion
{
  SPXAssertTrueOrReturn(completion);
  
  if (!token.length) {
    SPXLog(@"You must provide a valid auth token");
    return;
  }
  
  NSString *path = [NSString stringWithFormat:DOAuthorizeTokenRequestURI, self.redirectURI, token, self.clientID, self.clientSecret];
  NSURL *url = [NSURL URLWithString:path];
  [self performRequest:[NSMutableURLRequest requestWithURL:url] authToken:nil completion:completion];
}

- (void)refreshSessionWithToken:(NSString *)refreshToken completion:(void (^)(DOUser * user, NSError *error))completion
{
  SPXAssertTrueOrReturn(completion);
  
  if (!refreshToken.length) {
    SPXLog(@"You must provide a valid refresh token");
    return;
  }
  
  NSString *path = [NSString stringWithFormat:DORefreshTokenRequestURI, self.clientID, self.clientSecret, refreshToken];
  NSURL *url = [NSURL URLWithString:path];
  [self performRequest:[NSMutableURLRequest requestWithURL:url] authToken:nil completion:completion];
}

- (void)revokeToken:(NSString *)authToken completion:(void (^)(NSError *))completion
{
  SPXAssertTrueOrReturn(authToken);
  
  NSString *path = [NSString stringWithFormat:DORevokeTokenRequestURI, authToken];
  NSURL *url = [NSURL URLWithString:path];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"POST";
  
  if (authToken) { // this is only used for revoking a token
    request.allHTTPHeaderFields = @
    {
      @"Content-Type" : @"application/json",
      @"Authorization" : [@"Bearer " stringByAppendingString:authToken],
    };
  }
  
  NSError *error = nil;
  NSDictionary *body = @{ @"token" : authToken };
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
  
  if (error) {
    SPXLog(@"%@", error);
    return;
  }

  [self performRequest:request authToken:authToken completion:^(DOUser * user, NSError *error) {
    !completion ?: completion(error);
  }];
}

- (void)performRequest:(NSMutableURLRequest *)request authToken:(NSString *)authToken completion:(void (^)(DOUser * user, NSError *error))completion
{
  request.HTTPMethod = @"POST";
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      completion(nil, error);
      return;
    }
    
    NSError *innerError = nil;
    NSDictionary *params = [NSJSONSerialization JSONObjectWithData:data options:0 error:&innerError];
    
    if (innerError) {
      completion(nil, innerError);
      return;
    }
    
    if (params[@"error"]) {
      SPXLog(@"%@", params[@"error_description"]);
      innerError = [NSError errorWithDomain:DOReverseDomain(@"auth") code:-1 userInfo:@{ NSLocalizedDescriptionKey : params[@"error_description"] }];
      completion(nil, innerError);
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completion([[DOUser alloc] initWithAttributes:params], error);
    });
  }];
  
  [task resume];
}

@end