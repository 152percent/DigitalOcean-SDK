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


/**
 *  Represents a 'User' object
 */
@interface DOUser : NSObject <NSSecureCoding, NSCopying>


/**
 *  Returns the email associated with this user
 */
@property (nonatomic, readonly, nonnull) NSString *email;


/**
 *  Returns the unique server-side identifier associated with this user
 */
@property (nonatomic, readonly, nonnull) NSString *identifier;


/**
 *  Returns the current auth-token associated with this user
 */
@property (nonatomic, readonly, nonnull) NSString *authToken;


/**
 *  Returns the current refresh-token associated with this user
 */
@property (nonatomic, readonly, nonnull) NSString *refreshToken;


/**
 *  Initializes a new user with the specified attributes
 *
 *  @param attributes The attributes for this user
 */
- (nonnull instancetype)initWithAttributes:(nonnull NSDictionary *)attributes NS_DESIGNATED_INITIALIZER;


@end