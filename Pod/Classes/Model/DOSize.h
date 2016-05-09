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
 *  Represents an 'size' object
 */
@interface DOSize : DOObject


/**
 *  Returns the slug for this configuration
 */
@property (nonatomic, readonly, nonnull) NSString *slug;


/**
 *  Returns the memory size (in Megabytes) for this configuration
 */
@property (nonatomic, readonly, getter=memoryInMegabytes) double memory;


/**
 *  Returns the number of virtual CPU cores available for this configuration
 */
@property (nonatomic, readonly) NSUInteger vcpus;


/**
 *  Returns the disk size (in Gigabytes) for this configuration
 */
@property (nonatomic, readonly, getter=diskInGigabytes) double disk;


/**
 *  Returns the network transfer size (in Terabytes) for this configuration
 */
@property (nonatomic, readonly, getter=transferInTerabytes) double transfer;


/**
 *  Returns the price (per month) for this configuration
 */
@property (nonatomic, readonly) float priceMonthly;


/**
 *  Returns the price (per hour) for this configuration
 */
@property (nonatomic, readonly) float priceHourly;


/**
 *  Returns whether or not this configuration is available
 */
@property (nonatomic, readonly) BOOL available;


@end