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
 *  Defines a DOObject and its required methods -- this protocol is provided as a convenience -- we often don't know the final object type
 */
@protocol DOObject <NSObject>


/**
 *  Returns the singular string representation for this class
 */
+ (nonnull NSString *)singularRepresentation;


/**
 *  Returns the plural string representation for this class
 */
+ (nonnull NSString *)pluralRepresentation;


/**
 *  Updates the object with the specified attributes (this method should NOT be overriden)
 *
 *  @param attributes The JSON attributes to apply
 */
- (void)updateAttributes:(nonnull NSDictionary *)attributes;


/**
 *  A JSON representation of the object
 *
 *  @return A JSON representation
 */
- (nonnull NSDictionary *)JSONRepresentation;


/**
 *  Returns the attribute name to use for the specified key. You should override this when the property name can't be resolved automatically
 *
 *  @param key The property key
 *
 *  @return An attribute representation
 */
+ (nonnull NSString *)attributeNameForKey:(nonnull NSString *)key;


/**
 *  Returns a boxed value for the specified key. You should override this in your DOObject subclasses if your property key can't be resolved automatically from its JSON counterpart.
 *
 *  @param value The value to box
 *  @param key   The key be boxed
 *
 *  @example
 *
 *    We wouldn't be able to resolve these types automatically
 *    
 *    string => date
 *    string => url
 *
 *  @return A boxed value
 */
- (nonnull id)boxedValue:(nonnull id)value forKey:(nonnull NSString *)key;


@end


/**
 *  A DOObject is the base class for all DigitalOcean object types
 */
@interface DOObject : NSObject <DOObject, NSSecureCoding>

@property (nonatomic, strong, nonnull) NSDictionary *attributes;


// The following method has been redefined to add NS_REQUIRES_SUPER checks for better compiler warnings.
+ (nonnull NSString *)attributeNameForKey:(nonnull NSString *)key NS_REQUIRES_SUPER;


@end