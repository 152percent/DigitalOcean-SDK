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
#import "DODroplet.h"
#import "DORegion.h"


/**
 *  Represents a Floating IP object
 */
@interface DOFloatingIP : DOObject


/**
 *  Returns the identifier for this object
 */
@property (nonatomic, readonly) NSUInteger identifier;


/**
 *  Returns the IP address associated with this object
 */
@property (nonatomic, readonly, nonnull) NSString *IPAddress;


/**
 *  Returns the Droplet associated with this IP. May return nil.
 */
@property (nonatomic, readonly, nullable) DODroplet *droplet;


/**
 *  Returns the Region associated with this IP
 */
@property (nonatomic, readonly, nonnull) DORegion *region;


@end