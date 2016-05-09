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
 *  Represents an 'image' object
 */
@interface DOImage : DOObject


/**
 *  Returns the identifier for this image
 */
@property (nonatomic, readonly) NSUInteger identifier;


/**
 *  Returns the name for this image
 */
@property (nonatomic, readonly, nonnull) NSString *name;


/**
 *  Returns the original distribution of this image. E.g. Ubuntu, Debian, etc...
 */
@property (nonatomic, readonly, nonnull) NSString *distribution;


/**
 *  Returns the slug for this image
 */
@property (nonatomic, readonly, nonnull) NSString *slug;


/**
 *  Returns YES if this image is public, NO otherwise
 */
@property (nonatomic, readonly, getter=isPublic) BOOL public;


/**
 *  Returns the date this image was created
 */
@property (nonatomic, readonly, nonnull) NSDate *createdAt;


/**
 *  Returns the type for this image. E.g. "snapshot" or "backup".
 */
@property (nonatomic, readonly, nonnull) NSString *type;


/**
 *  Returns the minimum 'disk' required for this image. This can be used to filter size objects.
 */
@property (nonatomic, readonly) NSUInteger minDiskSize;


@end