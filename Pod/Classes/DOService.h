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

#import "DOObject.h"
#import "DOQuery.h"
#import "DOMetaData.h"
#import "DODefines.h"

@class DOServiceConfiguration;
@protocol DOServiceRequestHandler;


/**
 *  Specifies the logging level for the service
 */
typedef NS_ENUM(NSInteger, DOServiceLoggingLevel) {
  /**
   *  Logging includes failed responses only
   */
  DOServiceLoggingLevelErrorsOnly,
  /**
   *  Logging includes all requests and responses
   */
  DOServiceLoggingLevelVerbose,
  /**
   *  Logging includes all requests and failed responses, as well as the associated cURL command (useful for debugging)
   */
  DOServiceLoggingLevelDebug,
  /**
   *  No console logging will be applied
   */
  DOServiceLoggingLevelNone,
};


/**
 *  Defines the most common error codes returned and what they mean
 */
typedef NS_ENUM(NSInteger, DOErrorCode) {
  /**
   *  The current user is NOT authenticated.
   */
  DOErrorCodeUnauthenticated = 401,
  /**
   *  The specified resource was not found. (e.g. a Droplet, Image, etc...)
   */
  DOErrorCodeResourceNotFound = 404,
  /**
   *  The rate limit for this user was exceeded -- check -[meta rateLimitReset] to determine when the user can make another request
   */
  DOErrorCodeRateLimitExceeded = 429,
  /**
   *  The user attempted an action that couldn't be completed -- the error objects description will have appropriate feedback for the user
   *
   *  @example
   *
   *    "The droplet is already off."
   *    "Droplet is not on a server versioned for this migration."
   *    "Droplet is currently on. Please power it off to run this event."
   *    "Backups have already been disabled on this Droplet."
   *    "Droplet is currently on. Please power it off to run this event."
   *    "The droplet is already set to this size."
   */
  DOErrorCodeFeedback = 422,
  /**
   *  The specified pageIndex was greater than the numberOfPages available. Check meta.numberOfPages to avoid this error
   */
  DOErrorCodeInternalPageIndexExceededLimit = 10001,
};


/**
 *  A Digital Ocean service is responsible for handling all queries against the API service
 */
@interface DOService : NSObject


/**
 *  You can provide a delegate to handle all network requests yourself. If you choose not to set a delegate, all queries will use a default NSURLSession configuration automatically. (optional)
 */
@property (nonatomic, weak, nullable) id <DOServiceRequestHandler> delegate;


/**
 *  Gets/sets the logging level for this service
 */
@property (nonatomic, assign) DOServiceLoggingLevel loggingLevel;


/**
 *  Convenience method for creating a new DOService instance
 *
 *  @param token    The authentication token to use for all queries
 *  @param delegate The delegate that will handle all networking requests
 *
 *  @return A new DOService instance
 */
+ (nonnull instancetype)serviceWithToken:(nonnull NSString *)token delegate:(nullable id <DOServiceRequestHandler>)delegate DO_CONVENIENCE_INITIALIZER;


/**
 *  Initializes a new DOService instance
 *
 *  @param token    The authentication token to use for all queries
 *  @param delegate The delegate that will handle all networking requests
 *
 *  @return A new DOService instance
 */
- (nonnull instancetype)initWithToken:(nonnull NSString *)token delegate:(nullable id <DOServiceRequestHandler>)delegate DO_DESIGNATED_INITIALIZER;


/**
 *  Performs the specified query against the service
 *
 *  @param query      The query to perform
 *  @param completion The completion block to execute when the results or error are returned
 */
- (void)performQuery:(nonnull DOQuery *)query completion:(nonnull void (^)(id __nullable result, DOMetaData * __nonnull meta, NSError * __nullable error))completion;


@end


/**
 *  Defines a DOService request handler for handling network requests on behalf of the framework
 */
@protocol DOServiceRequestHandler <NSObject>


/**
 *  This method is called when a DOService instance needs to perform a network request
 *
 *  @param service    The service that wants to perform this request
 *  @param request    The request to be performed
 *  @param completion The completion block to call when you have completed the request. You MUST call this completion block after the request is complete
 */
- (void)service:(nonnull DOService *)service performRequest:(nonnull NSURLRequest *)request completion:(nonnull void (^)(NSData * __nullable data, NSURLResponse *__nullable response, NSError * __nullable error))completion;


@end