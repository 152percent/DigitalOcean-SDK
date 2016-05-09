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


/**
 *  Returns a fully qualified Digital Ocean API URL with the specified path
 *
 *  @param path The path to append to the base URL
 *
 *  @example
 *
 *    https://api.digitalocean.com/v2/$PATH
 *
 *  @return An NSURL object
 */
extern NSURL* DOURL(NSString *path);


/**
 *  Returns a reverse domain path
 *
 *  @param path The path to append to the root path
 *
 *  @example
 *
 *    com.digitalocean.$PATH
 *
 *  @return A reverse domain path
 */
extern NSString* DOReverseDomain(NSString *path);


/**
 *  Returns a number as a string
 *
 *  @param number The number to convert
 *
 *  @return An NSString from a number
 */
extern NSString* DONumberAsString(NSUInteger number);


/**
 *  Returns YES if the specified parameter is an object value (not a scalar value), NO otherwise
 */
#define _DO_IS_OBJECT(x) ( strchr("@#", @encode(__typeof__(x))[0]) != NULL )


/**
 *  Returns YES if the enum mask has been defined, NO otherwise
 */
#define _DOMaskHasValue(options, value) (((options) & (value)) == (value))