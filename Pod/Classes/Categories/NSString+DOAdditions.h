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
 *  Adds some convenience methods for converting between JSON and KVO strings
 */
@interface NSString (DOAdditions)


/**
 *  Returns the singular term of a class, removing the specified prefix
 *
 *  @param prefix The class prefix
 *
 *  @example
 *
 *    DODroplet       => droplet
 *    DODomainRecord  => domain_record
 *
 *  @return A singular term for a class
 */
- (nullable instancetype)do_singularRepresentationForClassWithPrefix:(nonnull NSString *)prefix;


/**
 *  Returns the plural term of a class, removing the specified prefix
 *
 *  @param prefix The class prefix
 *
 *  @example
 *  
 *    DODroplet       => droplets
 *    DODomainRecord  => domain_records
 *
 *  @return A plural term for a class
 */
- (nullable instancetype)do_pluralRepresentationForClassWithPrefix:(nonnull NSString *)prefix;


/**
 *  Returns the JSON key representation
 *
 *  @example
 *
 *    IpAddress => ip_address
 *    createdAt => created_at
 *
 *  @return A JSOK key representation
 */
- (nonnull instancetype)do_JSONKeyRepresentation;


/**
 *  Returns the query parameters for this string as an array of key/value pairs. (The string should match a pattern similar to 'domain.com?key=value')
 *
 *  @return An array of dictionaries
 */
- (nonnull NSDictionary *)do_queryParameters;


@end