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
 *  Represents an 'action' object
 */
@interface DOAction : DOObject


/**
 *  Returns the identifier for this action
 */
@property (nonatomic, readonly) NSUInteger identifier;


/**
 *  Returns the status for this action
 */
@property (nonatomic, readonly, nonnull) NSString *status;


/**
 *  Returns the type for this action
 */
@property (nonatomic, readonly, nonnull) NSString *type;


/**
 *  Returns the start date for this action
 */
@property (nonatomic, readonly, nonnull) NSDate *startedAt;


/**
 *  Returns the completed date for this action
 */
@property (nonatomic, readonly, nullable) NSDate *completedAt;


/**
 *  Returns the ID of the resource this action was applied to
 */
@property (nonatomic, readonly) NSUInteger resourceId;


/**
 *  Returns the type of resource this action was applied to
 */
@property (nonatomic, readonly, nonnull) NSString *resourceType;


/**
 *  Returns the region for this action
 */
@property (nonatomic, readonly, nonnull) NSString *region;


/**
 *  Returns the region_slug for this action
 */
@property (nonatomic, readonly, nonnull) NSString *regionSlug;


@end