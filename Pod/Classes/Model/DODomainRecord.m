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

#import "DODomainRecord.h"
#import "SPXDefines.h"
#import "DOValidators.h"

NSDictionary* DODomainRecordTypeA(NSString *name, NSString *ipAddress)
{
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:name options:DOHostnameOptionsNone]);
  SPXCAssertTrueOrReturnNil([DOValidators validateIPAddress:ipAddress]);
  return @{ @"name": name, @"type": @"A", @"data": ipAddress };
}

NSDictionary* DODomainRecordTypeAAAA(NSString *name, NSString *ipv6Address)
{
  SPXCAssertTrueOrReturnNil([DOValidators validateIPv6Address:ipv6Address]);
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:name options:DOHostnameOptionsNone]);
  return @{ @"name": name, @"type": @"AAAA", @"data": ipv6Address };
}

NSDictionary* DODomainRecordTypeCNAME(NSString *name, NSString *hostname)
{
  if (![hostname hasSuffix:@"."]) {
    hostname = [hostname stringByAppendingString:@"."];
  }
  
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:hostname options:DOHostnameOptionsMustEndInDot]);
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:name options:DOHostnameOptionsAllowUnderscore]);
  return @{ @"name": name, @"type": @"CNAME", @"data": hostname };
}

NSDictionary* DODomainRecordTypeMX(NSString *hostname, NSUInteger priority)
{
  if (![hostname hasSuffix:@"."]) {
    hostname = [hostname stringByAppendingString:@"."];
  }
  
  SPXCAssertTrueOrReturnNil([DOValidators validatePort:priority]);
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:hostname options:DOHostnameOptionsMustEndInDot]);
                  
  return @{ @"type": @"MX", @"data": hostname, @"priority": @(priority) };
}

NSDictionary* DODomainRecordTypeTXT(NSString *name, NSString *text)
{
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:name options:DOHostnameOptionsNone]);
  SPXCAssertTrueOrReturnNil(text.length);
  return @{ @"type": @"TXT", @"name": name, @"data": text };
}

NSDictionary* DODomainRecordTypeSRV(NSString *name, NSString *hostname, NSUInteger port, NSUInteger priority, NSUInteger weight)
{
  if (![hostname hasSuffix:@"."]) {
    hostname = [hostname stringByAppendingString:@"."];
  }
  
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:hostname options:DOHostnameOptionsMustEndInDot]);
  SPXCAssertTrueOrReturnNil([DOValidators validateSRVEntry:name]);
  SPXCAssertTrueOrReturnNil([DOValidators validatePort:weight]);
  SPXCAssertTrueOrReturnNil([DOValidators validatePort:port]);
  SPXCAssertTrueOrReturnNil([DOValidators validatePort:priority]);
  
  return @{ @"type": @"SRV", @"name": name, @"data": hostname, @"priority": @(priority), @"port": @(port), @"weight": @(weight) };
}

NSDictionary* DODomainRecordTypeNS(NSString *hostname)
{
  if (![hostname hasSuffix:@"."]) {
    hostname = [hostname stringByAppendingString:@"."];
  }
  
  SPXCAssertTrueOrReturnNil([DOValidators validateHostname:hostname options:DOHostnameOptionsMustEndInDot]);
  return @{ @"type": @"NS", @"data": hostname };
}

@implementation DODomainRecord

@dynamic identifier;
@dynamic type;
@dynamic name;
@dynamic data;
@dynamic priority;
@dynamic port;
@dynamic weight;

@end