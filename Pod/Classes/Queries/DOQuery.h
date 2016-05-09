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


extern NSUInteger const DOQueryMaxItemsPerPage;


/**
 *  A query object can be used with a DOService to fetch, insert, update, delete or perform an action against the Digital Ocean API. Although you can use any of the method below, it is recommended that you use the convenience methods provided through various categories.
 */
@interface DOQuery : NSObject <NSCopying, NSSecureCoding>


/**
 *  The objectClass associated with this query. This provides hinting for the query as to what kind of object is should expect from its result (readonly)
 */
@property (nonatomic, readonly, nonnull) Class <DOObject> objectClass;


/**
 *  The full URL path associated with this query -- including host, scheme, path and query parameters (readonly)
 */
@property (nonatomic, readonly, nonnull) NSString *path;


/**
 *  The HTTP method that will be used for this query -- this is inferred depending on the initializer you call (readonly)
 */
@property (nonatomic, readonly, nonnull) NSString *HTTPMethod;


/**
 *  The HTTP body for this query. This will only be used for POST and PUT requests. All other requests will insert the attributes as query parameters
 */
@property (nonatomic, readonly, nullable) NSDictionary *HTTPBody;


/**
 *  Gets/sets the number of items to return per page, enabling pagination (1 - 200). (default to 20)
 */
@property (nonatomic, assign) NSUInteger itemsPerPage;


/**
 *  Gets/sets the page index to fetch. If you use -[meta queryForPageURI:meta.nextPage] you shouldn't need to modify this. However this will allow you to modify the page to return.
 */
@property (nonatomic, assign) NSUInteger pageIndex;


/**
 *  Returns a fully configured NSURLRequest -- this is generally used by DOService
 */
@property (nonatomic, readonly, nonnull) NSURLRequest *URLRequest;


@end