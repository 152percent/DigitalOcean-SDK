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

#import "DOFloatingIP.h"

@implementation DOFloatingIP

@dynamic IPAddress;
@dynamic identifier;

- (void)updateAttributes:(NSDictionary *)attributes
{
  [super updateAttributes:attributes];
  
  NSDictionary *dropletAttributes = attributes[@"droplet"];
  
  if (dropletAttributes && dropletAttributes != (NSDictionary *)[NSNull null]) {
    DODroplet *droplet = [DODroplet new];
    [droplet updateAttributes:dropletAttributes];
    [self setValue:droplet forKey:@"droplet"];
  }
  
  NSDictionary *regionAttributes = attributes[@"region"];
  
  if (regionAttributes && regionAttributes != (NSDictionary *)[NSNull null]) {
    DORegion *region = [DORegion new];
    [region updateAttributes:regionAttributes];
    [self setValue:region forKey:@"region"];
  }
}

+ (NSString *)singularRepresentation
{
  return @"floating_ip";
}

+ (NSString *)pluralRepresentation
{
  return @"floating_ips";
}

+ (NSString *)attributeNameForKey:(NSString *)key
{
  if ([key isEqualToString:@"IPAddress"]) {
    return @"ip";
  }
  
  return [super attributeNameForKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
  if ([key isEqualToString:@"id"]) {
    return @(self.identifier);
  }
  
  return [super valueForUndefinedKey:key];
}

- (NSUInteger)identifier
{
  return self.IPAddress.hash;
}

@end