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
#import "DODefines.h"
#import "DOUser.h"


/**
 *  An error code representing a denied request -- generally due to credentials
 */
extern NSUInteger const DOAuthenticationErrorCodeDenied;


/**
 *  Provides an object oriented implementation for performing authentication requests
 */
@interface DOAuthRequest : NSObject


/**
 *  The clientID for this request
 */
@property (nonatomic, readonly, nonnull) NSString *clientID;


/**
 *  The client secret for this request
 */
@property (nonatomic, readonly, nonnull) NSString *clientSecret;


/**
 *  The redirect URI for this request
 */
@property (nonatomic, readonly, nonnull) NSString *redirectURI;


/**
 *  Initializes a new instance
 *
 *  @param clientID     The client ID to use for this request
 *  @param clientSecret The client secret to use for this request
 *  @param redirectURI  The redirect URI to use for this request
 *
 *  @return A new instance
 */
- (nonnull instancetype)initWithClientID:(nonnull NSString *)clientID clientSecret:(nonnull NSString *)clientSecret redirectURI:(nonnull NSString *)redirectURI DO_DESIGNATED_INITIALIZER;


/**
 *  You don't generally need to call this method yourself, its usually called automatically by DOAuthenticationController. If you want to provide native login though, you can use this method to authorize a login token during sign-in. See DOAuthenticationController for implementation details
 *
 *  @param token      The token to authorize
 *  @param completion The completion block to execute with a new authToken/refreshToken or error
 */
- (void)authorizeToken:(nonnull NSString *)token completion:(nonnull void (^)(DOUser * __nullable user, NSError * __nullable error))completion;


/**
 *  Refreshes a session with the specified refresh token
 *
 *  @param refreshToken The refresh token used to refresh this session
 *  @param completion   The completion block to execute with a new authToken/refreshToken or error
 */
- (void)refreshSessionWithToken:(nonnull NSString *)refreshToken completion:(nonnull void (^)(DOUser * __nullable user, NSError * __nullable error))completion;


/**
 *  Revokes the specified token -- this should generally be called when a user explicitly signs-out of their session from your application UI
 *
 *  @param authToken  The authToken to revoke
 *  @param completion The completion block to execute when this action completes, an error will be returned if this action was unsuccessful
 */
- (void)revokeToken:(nonnull NSString *)authToken completion:(nonnull void (^)(NSError * __nullable error))completion;


@end