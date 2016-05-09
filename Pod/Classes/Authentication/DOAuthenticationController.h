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

@import Foundation;
#import "DOAuthRequest.h"

@protocol DOAuthenticationControllerDelegate;

/**
 *  Provides a ViewController for presenting Digital Ocean authentication (in a web-view) to a user in your application.
 */
#if TARGET_OS_IPHONE
@import UIKit;
@interface DOAuthenticationController : UIViewController
#else
@import AppKit;
@interface DOAuthenticationController : NSViewController
#endif


/**
 *  The delegate for this controller
 */
@property (nonatomic, weak, nullable) id <DOAuthenticationControllerDelegate> delegate;


/**
 *  Initializes a new instance of this controller
 *
 *  @param delegate     The delegate that will respond to events from this controller
 *  @param clientID     The client ID of your application
 *  @param clientSecret The client secret of your application
 *  @param redirectURI  The redirect URI you registered when you setup your application -- https://cloud.digitalocean.com/settings/applications
 *
 *  @return A new instance
 */
- (nonnull instancetype)initWithDelegate:(nullable id <DOAuthenticationControllerDelegate>)delegate clientID:(nonnull NSString *)clientID clientSecret:(nonnull NSString *)clientSecret redirectURI:(nonnull NSString *)redirectURI DO_DESIGNATED_INITIALIZER;

@end


/**
 *  Defines a delegate for an Authentication controller
 */
@protocol DOAuthenticationControllerDelegate <NSObject>

/**
 *  This method is called when authentication completes successfully
 *
 *  @param controller   The controller that performed authentication
 *  @param authToken    The authToken for the authenticated user -- you should persist this in your applications keychain for usage with a DOService instance
 *  @param refreshToken The refreshToken for the authenticated user -- you should persist this in case the authToken expires, you can use this with DOAuthRequest to get a new authToken without the user requiring another sign in
 */
- (void)authenticationController:(nonnull DOAuthenticationController *)controller didAuthenticateWithUser:(nonnull DOUser *)user;


/**
 *  This method is called when authentication fails
 *
 *  @param controller The controller that performed authentication
 *  @param error      The error describing the failure
 */
- (void)authenticationController:(nonnull DOAuthenticationController *)controller didFailWithError:(nonnull NSError *)error;

@end