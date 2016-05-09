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

#include <arpa/inet.h>

#import "DOValidators.h"
#import "DOInternal.h"
#import "SPXDefines.h"

static NSString * const SSHKeyRSAPrefix = @"AAAAB3NzaC1yc2EA";
static NSString * const SSHKeyDSSPrefix = @"AAAAB3NzaC1kc3MA";

static BOOL DOValidateWithRegex(NSString *string, NSString *pattern)
{
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
  SPXCAssertTrueOrPerformAction(regex, SPXCLog(@"%@", error); return NO);
  return [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)].count;
}

@implementation DOValidators

+ (BOOL)validateSSHKey:(NSString *)value
{
  NSArray *components = [value componentsSeparatedByString:@" "];
  if (components.count < 3) {
    return NO;
  }
  
  NSData *data = [[NSData alloc] initWithBase64EncodedString:components[1] options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  if (!data) {
    return NO;
  }
  
  NSRange range = [value rangeOfString:@" "];
  
  if (range.location == NSNotFound) {
    return NO;
  }
  
  NSString *key = [[value substringFromIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  BOOL hasValidPrefix = ([key hasPrefix:SSHKeyRSAPrefix] || [key hasPrefix:SSHKeyDSSPrefix]);
  
  return hasValidPrefix;
}

+ (BOOL)validateIPAddress:(NSString *)value
{
  if (![value isKindOfClass:[NSString class]]) {
    return NO;
  }
  
  struct in_addr pin;
  BOOL isValid = inet_pton(AF_INET, value.UTF8String, &pin);
  return isValid;
}

+ (BOOL)validateIPv6Address:(NSString *)value
{
  if (![value isKindOfClass:[NSString class]]) {
    return NO;
  }
  
  struct in6_addr pin;
  BOOL isValid = inet_pton(AF_INET6, value.UTF8String, &pin);
  return isValid;
}

+ (BOOL)validateHostname:(NSString *)value options:(DOHostnameOptions)options
{
  if (!value.length) {
    return NO;
  }
  
  if ([value isEqualToString:@"@"]) {
    return YES;
  }
  
  NSString *pattern = @"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$";
  
  if (_DOMaskHasValue(options, DOHostnameOptionsAllowUnderscore)) {
    pattern = @"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-\\_]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-\\_]*[A-Za-z0-9])$";
  }
  
  if (_DOMaskHasValue(options, DOHostnameOptionsMustEndInDot)) {
    if ([value hasSuffix:@"."]) {
      value = [value stringByReplacingCharactersInRange:NSMakeRange(value.length - 1, 1) withString:@""];
    } else {
      return NO;
    }
  } else {
    if ([value hasSuffix:@"."]) {
      value = [value stringByReplacingCharactersInRange:NSMakeRange(value.length - 1, 1) withString:@""];
    }
  }
  
  return DOValidateWithRegex(value, pattern);
}

+ (BOOL)validateSRVEntry:(NSString *)value
{
  NSMutableArray *components = [value componentsSeparatedByString:@"."].mutableCopy;
  
  if (components.count < 2) {
    return NO;
  }
  
  if (![components[0] hasPrefix:@"_"] || ![components[1] hasPrefix:@"_"]) {
    return NO;
  }
  
  [components removeObjectsInRange:NSMakeRange(0, 2)];
  
  if (!components.count) {
    return YES;
  }
  
  NSString *remainder = [components componentsJoinedByString:@"."];
  return [self validateHostname:remainder options:DOHostnameOptionsAllowUnderscore];
}

+ (BOOL)validatePort:(NSUInteger)port
{
  return (port <= 65535);
}

@end