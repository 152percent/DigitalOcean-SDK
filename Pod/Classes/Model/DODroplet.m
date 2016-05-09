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

#import "DODroplet.h"
#import "NSDate+DOAdditions.h"
#import "DOValidators.h"
#import "SPXDefines.h"

@implementation DODroplet

@dynamic name;
@dynamic identifier;
@dynamic createdAt;
@dynamic memory;
@dynamic vcpus;
@dynamic disk;
@dynamic locked;
@dynamic status;
@dynamic sizeSlug;

- (void)updateAttributes:(NSDictionary *)attributes
{
  [super updateAttributes:attributes];
  
  NSArray *ipv4Networks = attributes[@"networks"][@"v4"];
  NSArray *ipv6Networks = attributes[@"networks"][@"v6"];
  NSMutableArray *networks = [NSMutableArray new];
  
  for (NSDictionary *net in ipv4Networks) {
    DONetwork *network = [DONetwork new];
    [network updateAttributes:net];
    [network setValue:@"v4" forKey:@"identifier"];
    [networks addObject:network];
  }
  
  [self setValue:networks forKey:@"IPv4Networks"];
  
  networks = [NSMutableArray new];
  
  for (NSDictionary *net in ipv6Networks) {
    DONetwork *network = [DONetwork new];
    [network updateAttributes:net];
    [network setValue:@"v6" forKey:@"identifier"];
    [networks addObject:network];
  }
  
  [self setValue:networks forKey:@"IPv6Networks"];
}

- (id)boxedValue:(id)value forKey:(NSString *)key
{
  if ([key isEqualToString:NSStringFromSelector(@selector(createdAt))]) {
    return [NSDate do_dateFromISO8601String:value];
  }
  
  if ([key isEqualToString:NSStringFromSelector(@selector(status))]) {
    if ([value isEqualToString:@"active"]) {
      return @(DODropletStatusActive);
    } else if ([value isEqualToString:@"new"]) {
      return @(DODropletStatusNew);
    } else if ([value isEqualToString:@"archive"]) {
      return @(DODropletStatusArchived);
    } else if ([value isEqualToString:@"off"]) {
      return @(DODropletStatusOff);
    } else {
      return @(DODropletStatusDestroyed);
    }
  }
  
  return [super boxedValue:value forKey:key];
}

@end


@implementation DODropletConfiguration

- (instancetype)init
{
  self = [super init];
  SPXAssertTrueOrReturnNil(self);
  _enableIPv6 = YES;
  return self;
}

- (NSDictionary *)attributes
{
  NSMutableDictionary *attributes = [NSMutableDictionary new];
  
  SPXAssertTrueOrReturnNil([DOValidators validateHostname:self.hostname options:DOHostnameOptionsNone]);
  SPXAssertTrueOrReturnNil(self.imageID);
  SPXAssertTrueOrReturnNil(self.regionSlug);
  SPXAssertTrueOrReturnNil(self.sizeSlug);
  
  attributes[@"name"] = self.hostname;
  attributes[@"image"] = @(self.imageID);
  attributes[@"region"] = self.regionSlug;
  attributes[@"size"] = self.sizeSlug;
  
  NSMutableArray *keys = [NSMutableArray new];
  
  for (id key in self.sshKeys) {
    [keys addObject:[NSString stringWithFormat:@"%@", key]];
  }
  
  if (keys.count) {
    attributes[@"ssh_keys"] = keys;
  }
  
  attributes[@"backups"] = @(self.enableBackups);
  attributes[@"private_networking"] = @(self.enablePrivateNetworking);
  attributes[@"ipv6"] = @(self.enableIPv6);
  
  if (self.userData) {
    attributes[@"user_data"] = self.userData;
  }
  
  return attributes.copy;
}

- (NSString *)description
{
  return SPXDescription(SPXKeyPath(attributes));
}

@end