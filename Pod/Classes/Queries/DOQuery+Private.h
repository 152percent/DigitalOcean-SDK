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

#import <DigitalOcean/DigitalOcean.h>

@interface DOQuery (Private)

/**
 *  Creates a new 'fetch' query -- a GET request
 *
 *  @param objectClass The objectClass associated with this query. This provides hinting for the query as to what kind of object is should expect from its result (required)
 *  @param attributes  A JSON representation of the attributes that will be used in the request body for this query
 *  @param endpoint    The endpoint (specified in DOEndpointConstants.h) to use for this query (required)
 *  @param params      The query parameter that will be inserted appropriately into the url -- The number of 'params' MUST match the number of parameters expected in 'endpoint' or an assertion will be thrown!
 *
 *  @example
 *
 *    [DOQuery fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:DODropletsEndpoint params:nil];
 *
 *  @return A new 'fetch' query
 */
+ (nonnull instancetype)fetchQueryForObjectClass:(nonnull Class<DOObject>)objectClass attributes:(nullable NSDictionary *)attributes endpoint:(nonnull NSString *)endpoint params:(nullable NSString *)params, ... NS_REQUIRES_NIL_TERMINATION;


/**
 *  Creates a new 'insert' query -- a POST request
 *
 *  @param objectClass The objectClass associated with this query. This provides hinting for the query as to what kind of object is should expect from its result (required)
 *  @param attributes  A JSON representation of the attributes that will be used in the request body for this query
 *  @param endpoint    The endpoint (specified in DOEndpointConstants.h) to use for this query (required)
 *  @param params      The query parameter that will be inserted appropriately into the url -- The number of 'params' MUST match the number of parameters expected in 'endpoint' or an assertion will be thrown!
 *
 *  @example
 *
 *    [DOQuery insertQueryForObjectClass:DOSSHKey.class attributes:@{ @"name": $NAME, @"public_key": $PUBLIC_KEY } endpoint:DOSSHKeyEndpoint params:$SSH_Key_ID, nil];
 *
 *  @return A new 'insert' query
 */
+ (nonnull instancetype)insertQueryForObjectClass:(nonnull Class<DOObject>)objectClass attributes:(nullable NSDictionary *)attributes endpoint:(nonnull NSString *)endpoint params:(nullable NSString *)params, ... NS_REQUIRES_NIL_TERMINATION;


/**
 *  Creates a new 'update' query -- a PUT request
 *
 *  @param objectClass The objectClass associated with this query. This provides hinting for the query as to what kind of object is should expect from its result (required)
 *  @param attributes  A JSON representation of the attributes that will be used in the request body for this query
 *  @param endpoint    The endpoint (specified in DOEndpointConstants.h) to use for this query (required)
 *  @param params      The query parameter that will be inserted appropriately into the url -- The number of 'params' MUST match the number of parameters expected in 'endpoint' or an assertion will be thrown!
 *
 *  @example
 *
 *    [DOQuery updateQueryForObjectClass:DOImage.class attributes:@{ @"name" : $NEW_NAME } endpoint:DOImageEndpoint params:$IMAGE_ID, nil];
 *
 *  @return A new 'update' query
 */
+ (nonnull instancetype)updateQueryForObjectClass:(nonnull Class<DOObject>)objectClass attributes:(nullable NSDictionary *)attributes endpoint:(nonnull NSString *)endpoint params:(nullable NSString *)params, ... NS_REQUIRES_NIL_TERMINATION;


/**
 *  Creates a new 'update' query -- a POST request
 *
 *  @param objectClass The objectClass associated with this query. This provides hinting for the query as to what kind of object is should expect from its result (required)
 *  @param attributes  A JSON representation of the attributes that will be used in the request body for this query
 *  @param endpoint    The endpoint (specified in DOEndpointConstants.h) to use for this query (required)
 *  @param params      The query parameter that will be inserted appropriately into the url -- The number of 'params' MUST match the number of parameters expected in 'endpoint' or an assertion will be thrown!
 *
 *  @example
 *
 *    [DOQuery actionQueryForObjectClass:DODroplet.class attributes:@{ @"type" : @"reboot" } endpoint:DODropletEndpoint params:$DROPLET_ID, nil];
 *
 *  @return A new 'POST' query
 */
+ (nonnull instancetype)actionQueryForObjectClass:(nonnull Class<DOObject>)objectClass attributes:(nullable NSDictionary *)attributes endpoint:(nonnull NSString *)endpoint params:(nullable NSString *)params, ... NS_REQUIRES_NIL_TERMINATION;


/**
 *  Creates a new 'delete' query -- a DELETE request
 *
 *  @param endpoint    The endpoint (specified in DOEndpointConstants.h) to use for this query (required)
 *  @param params      The query parameter that will be inserted appropriately into the url -- The number of 'params' MUST match the number of parameters expected in 'endpoint' or an assertion will be thrown!
 *
 *  @example
 *
 *    [DOQuery deleteQueryForEndpoint:DODropletEndpoint params:$DROPLET_ID, nil];
 *
 *  @return A new 'update' query
 */
+ (nonnull instancetype)deleteQueryForEndpoint:(nonnull NSString *)endpoint params:(nullable NSString *)params, ... NS_REQUIRES_NIL_TERMINATION;


@end