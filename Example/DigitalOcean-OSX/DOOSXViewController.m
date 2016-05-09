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

#import "DOOSXViewController.h"
#import "DigitalOcean.h"

static NSString *const DOClientID = @"CLIENT_ID_GOES_HERE";
static NSString *const DOClientSecret = @"CLIENT_SECRET_GOES_HERE";
static NSString *const DORedirectURI = @"http://";

@interface DOOSXViewController () <DOAuthenticationControllerDelegate>
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) IBOutlet NSTextView *textView;
@end

@implementation DOOSXViewController

@synthesize authToken = _authToken;

- (void)viewDidAppear
{
  [super viewDidAppear];
  
  if (!DOClientID.length || !DOClientSecret.length || !DORedirectURI.length || [DORedirectURI isEqualToString:@"http://"]) {
    self.textView.string = @"Before clicking `Login`, make sure you've entered your\n\nClient ID\nClient Secret\nRedirect URI\n\nat the top of DOOSXViewController.m";
  } else {
    self.textView.string = @"";
    [self performQueryWithToken:self.authToken];
  }
}

#pragma mark - Query

- (void)performQueryWithToken:(NSString *)token
{
  /**
   *  Lets create a query that will fetch all droplets for the authenticated user
   */
  DOQuery *query = [DOQuery fetchDroplets];
  
  /**
   *  Now we create a service that will authenticate our query for us. Its generally recommended you reuse these
   */
  DOService *service = [DOService serviceWithToken:token delegate:nil];
  
  /**
   *  For this demo, we'll also enable debug logging so we can see the cURL commands being sent
   */
  service.loggingLevel = DOServiceLoggingLevelDebug;
  
  /**
   *  Now we simple perform the query and check the result
   */
  [service performQuery:query completion:^(NSArray<DODroplet *>* _Nullable result, DOMetaData * _Nonnull meta, NSError * _Nullable error) {
    // Services don't dispatch back to main thread, so we need to do this now
    dispatch_async(dispatch_get_main_queue(), ^{
      
      if (error == nil) {
        NSArray *droplets = [result valueForKey:@"JSONRepresentation"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:droplets options:NSJSONWritingPrettyPrinted error:nil];
        
        self.textView.string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      } else {
        self.textView.string = [NSString stringWithFormat:@"%@", error];
        NSLog(@"%@", error);
      }
      
    });
  }];
}

#pragma mark - Authentication

/**
 *  If the authentication was successful, lets store the authToken for next launches
 */
- (void)authenticationController:(DOAuthenticationController *)controller didAuthenticateWithUser:(nonnull DOUser *)user
{
  self.authToken = user.authToken;

  [controller.view removeFromSuperview];
  [controller removeFromParentViewController];
  
  [self performQueryWithToken:self.authToken];
}

/**
 *  If the authentication failed, log the error
 */
- (void)authenticationController:(DOAuthenticationController *)controller didFailWithError:(NSError *)error
{
  NSLog(@"Authentication failed with error: %@", error);
}

/**
 *  Logout, and attempt to login again
 */
- (IBAction)logout:(id)sender
{
  self.authToken = nil;
  
  DOAuthenticationController *controller = [[DOAuthenticationController alloc] initWithDelegate:self clientID:DOClientID clientSecret:DOClientSecret redirectURI:DORedirectURI];
  controller.view.frame = self.view.bounds;
  controller.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
  
  [self addChildViewController:controller];
  [self.view addSubview:controller.view];
}

- (void)setAuthToken:(NSString *)authToken
{
  [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:@"auth"];
}

- (NSString *)authToken
{
  NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth"];
  return token.length ? token : @"";
}

@end