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
#import "SPXDefines.h"
#import "NSString+DOAdditions.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface DOPropertyDescriptor : NSObject

@property (nonatomic, copy) NSString *selector;
@property (nonatomic, copy) NSArray *getters;
@property (nonatomic) char *encodingType;

@end


@interface DOObject ()
- (void)updateAttributes:(NSDictionary *)attributes;
@end

@implementation DOObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super init];
  SPXAssertTrueOrReturnNil(aDecoder);
  SPXDecode(attributes);
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  SPXEncode(attributes);
}

+ (BOOL)supportsSecureCoding
{
  return YES;
}

+ (NSString *)singularRepresentation
{
  return [NSStringFromClass(self) do_singularRepresentationForClassWithPrefix:@"DO"];
}

+ (NSString *)pluralRepresentation
{
  return [NSStringFromClass(self) do_pluralRepresentationForClassWithPrefix:@"DO"];
}

#pragma mark - Dynamic Properties

NSString* DOSelectorForProperty(DOObject *self, SEL _cmd)
{
  NSArray *descriptors = [self.class propertyDescriptors];
  
  for (DOPropertyDescriptor *descriptor in descriptors) {
    if ([descriptor.getters containsObject:NSStringFromSelector(_cmd)]) {
      return descriptor.selector;
    }
  }
  
  return nil;
}

id DOValueFromAttributes(DOObject *self, SEL _cmd, NSString *selector)
{
  NSString *key = [self.class attributeNameForKey:selector];
  id value = self.attributes[key];
  return [self boxedValue:value forKey:NSStringFromSelector(_cmd)];
}

char* DOTypeForProperty(DOObject *self, SEL _cmd)
{
  objc_property_t property = class_getProperty(self.class, NSStringFromSelector(_cmd).UTF8String);
  return property_copyAttributeValue(property, "T");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
  NSString *property = DOSelectorForProperty(self, selector);
  char *type = DOTypeForProperty(self, NSSelectorFromString(property));
  
  if ([[NSString stringWithUTF8String:type] hasPrefix:@"@"]) {
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
  }

  char *encodingType = strcat(type, "@:");
  return [NSMethodSignature signatureWithObjCTypes:encodingType];
}


- (void)forwardInvocation:(NSInvocation *)invocation
{
  NSString *key = DOSelectorForProperty(self, [invocation selector]);
  id obj = DOValueFromAttributes(self, invocation.selector, key);
  
  if ([obj isKindOfClass:[NSNull class]]) {
    return;
  }
  
  char *type = DOTypeForProperty(self, NSSelectorFromString(key));
  
  switch (type[0]) {
    case 'b':
    case 'i':
    case 'q':
    {
      NSInteger i = [obj integerValue];
      [invocation setReturnValue:(void *)&i];
    }
      break;
    case 'B':
    case 'I':
    case 'Q':
    {
      NSUInteger i = [obj unsignedIntegerValue];
      [invocation setReturnValue:(void *)&i];
    }
      break;
    case 'd':
    {
      double d = [obj doubleValue];
      [invocation setReturnValue:(void *)&d];
    }
      break;
    case 'f':
    {
      float f = [obj floatValue];
      [invocation setReturnValue:(void *)&f];
    }
      break;
    default:
      [invocation setReturnValue:(void *)&obj];
      break;
  }
}

#pragma mark - KVO Keys and Attributes

- (id)valueForUndefinedKey:(NSString *)key
{
  NSString *selector = DOSelectorForProperty(self, NSSelectorFromString(key));
  
  if ([self.attributes.allKeys containsObject:selector]) {
    return self.attributes[selector];
  }
  
  if ([self.attributes.allKeys containsObject:key]) {
    return self.attributes[key];
  }
  
  return [super valueForUndefinedKey:key];
}

+ (NSString *)attributeNameForKey:(NSString *)key
{
  if ([key isEqualToString:@"identifier"]) {
    return @"id";
  }
  
  return [key do_JSONKeyRepresentation];
}

- (id)boxedValue:(id)value forKey:(NSString *)key
{
  return value;
}

- (void)updateAttributes:(NSDictionary *)attributes
{
  @synchronized(self.attributes) {
    _attributes = attributes;
  }
}

- (NSDictionary *)JSONRepresentation
{
  return self.attributes.copy;
}

#pragma mark - Property Inspection

+ (NSArray *)propertyDescriptors
{
  NSMutableArray *descriptors = [NSMutableArray new];
  
  unsigned int outCount, i;
  objc_property_t *propertiesPointer = class_copyPropertyList([self class], &outCount);
  
  for( i = 0; i < outCount; i++) {
    objc_property_t property = propertiesPointer[i];
    char *dynamic = property_copyAttributeValue(property, "D");
    
    if (dynamic) {
      DOPropertyDescriptor *descriptor = [DOPropertyDescriptor new];
      
      char *getter = property_copyAttributeValue(property, "G");
      char *type = property_copyAttributeValue(property, "T");
      NSMutableArray *getters = [NSMutableArray new];
      
      if (getter) {
        // this handles custom getters like: getter=isLocked
        NSString *g = [NSString stringWithUTF8String:getter];
        [getters addObject:g];
      }
      
      NSString *selector = [NSString stringWithUTF8String:property_getName(property)];
      [getters addObject:selector];
      
      descriptor.getters = getters;
      descriptor.selector = selector;
      descriptor.encodingType = type;
      
      [descriptors addObject:descriptor];
    }
  }
  
  return descriptors.copy;
}

#pragma mark - Debugging

- (NSString *)debugDescription
{
  return SPXDescription(SPXKeyPath(JSONRepresentation));
}

@end

@implementation DOPropertyDescriptor

- (NSString *)type
{
  return [NSString stringWithUTF8String:self.encodingType];
}

- (NSString *)description
{
  return SPXDescription(SPXKeyPath(selector), SPXKeyPath(getters), SPXKeyPath(type));
}

@end