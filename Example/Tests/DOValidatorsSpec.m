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

#import <Kiwi/Kiwi.h>
#import "DOValidators.h"

SPEC_BEGIN(DOValidatorsSpec)

describe(@"DOValidators", ^{

  context(@"SSH Key Validation", ^{
    
    NSString *key = @"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC680qx9VjT77l+OhPcb0CbRe3pw1jWa0UBLrcPM2T8Zxf+acIz7V3AowsCk5XHtsM1fKs0LH3bJqp9kTZoAwX3JOjGXE3JyXglRUcybS2ay059KP0ySorvXHfHUl1lwZvwGfeABqVtCKHrkJw4Q0etI8Xdf0F6WXyPlHyERWI1Iwzml1o1RtAkJ92OqkQKfps0VgxwYHxXcppf2IsqvDv9NMOVHp15G3/is3irP1JQj7BxXe6OvT3a2XWJZtaC55pJWhD787MgfOwuyGEe/Y8jD66OuycNA5yvCkKEZTcqvvuIFiFSHISoV2ahtUv7MQuB6rEoR6c2OZvljq6sBfc1 DO@DO-rMBP.local";
    
    it(@"should pass with a valid key", ^{
      [[theValue([DOValidators validateSSHKey:key]) should] beYes];
    });
    
    it(@"should fail with a key that is not base64 encoded", ^{
      NSString *invalidKey = [key stringByReplacingOccurrencesOfString:@"is3irP1JQj7BxXe6OvT3a2XWJZtaC55pJWhD787MgfOwuyGEe" withString:@""];
      [[theValue([DOValidators validateSSHKey:invalidKey]) should] beNo];
    });
    
    it(@"should fail with a key that has less than 3 components", ^{
      // the space at the front is important!
      NSString *invalidKey = [key stringByReplacingOccurrencesOfString:@" DO@DO-rMBP.local" withString:@""];
      [[theValue([DOValidators validateSSHKey:invalidKey]) should] beNo];
    });
    
  });
  
  context(@"IPAddress validation", ^{
    
    it(@"should pass or fail as expected for IPv4 addresses", ^{
      NSDictionary *addresses = @
      {
        @"10.0.0.0" : @YES,
        @"10.0.g.0" : @NO,
        @"256.0.0.0" : @NO,
        @"0.0.0.256" : @NO,
        @10 : @NO,
        @"fe80::de9b:9cff:feed:5bab" : @NO,
      };
      
      for (id value in addresses.allKeys) {
        [[theValue([DOValidators validateIPAddress:value]) should] equal:addresses[value]];
      }
    });
    
    it(@"should pass or fail as expected for IPv6 addresses", ^{
      NSDictionary *addresses = @
      {
        @"10.0.0.0" : @NO,
        @"10.0.g.0" : @NO,
        @"256.0.0.0" : @NO,
        @"0.0.0.256" : @NO,
        @10 : @NO,
        @"fe80::de9b:9cff:feed:5bab" : @YES,
        @"fe80::de9b:9cfffeed:5bab" : @NO,
      };
      
      for (id value in addresses.allKeys) {
        [[theValue([DOValidators validateIPv6Address:value]) should] equal:addresses[value]];
      }
    });
    
  });
  
  context(@"Hostname Validation", ^{
    
    it(@"should pass or fail as expected for a hostname without options", ^{
      NSDictionary *hostnames = @
      {
        @"shaps.me" : @YES,
        @"shaps-me" : @YES,
        @"shaps_site.me" : @NO,
        @"shaps.me." : @YES,
        @"shaps.me-" : @NO,
        @"-shaps.me" : @NO,
        @"shaps.me_site" : @NO
      };
      
      for (NSString *hostname in hostnames.allKeys) {
        [[theValue([DOValidators validateHostname:hostname options:DOHostnameOptionsNone]) should] equal:hostnames[hostname]];
      }
    });
    
    it(@"should pass or fail as expected for a hostname requiring a '.' at the end", ^{
      NSDictionary *hostnames = @
      {
        @"shaps.me" : @NO,
        @"shaps-me" : @NO,
        @"shaps_site.me" : @NO,
        @"shaps.me." : @YES,
        @"shaps_me." : @NO,
        @"shaps.me-" : @NO,
        @"-shaps.me" : @NO,
        @"shaps.me_site" : @NO,
        @"shaps.me_site" : @NO,
      };
      
      for (NSString *hostname in hostnames.allKeys) {
        [[theValue([DOValidators validateHostname:hostname options:DOHostnameOptionsMustEndInDot]) should] equal:hostnames[hostname]];
      }
    });
    
    it(@"should pass or fail as expected for a hostname allowing underscores", ^{
      NSDictionary *hostnames = @
      {
        @"shaps.me" : @YES,
        @"shaps-me" : @YES,
        @"shaps_site.me" : @YES,
        @"shaps.me." : @YES,
        @"shaps_site.me." : @YES,
        @"shaps.me-" : @NO,
        @"-shaps.me" : @NO,
        @"shaps.me_site" : @YES,
      };
      
      for (NSString *hostname in hostnames.allKeys) {
        [[theValue([DOValidators validateHostname:hostname options:DOHostnameOptionsAllowUnderscore]) should] equal:hostnames[hostname]];
      }
    });
    
    it(@"should pass or fail as expected for a hostname requiring a '.' at the end and allowing underscores", ^{
      NSDictionary *hostnames = @
      {
        @"shaps.me" : @NO,
        @"shaps-me" : @NO,
        @"shaps_site.me" : @NO,
        @"shaps.me." : @YES,
        @"shaps_site.me." : @YES,
        @"shaps.me-" : @NO,
        @"-shaps.me" : @NO,
        @"shaps.me_site" : @NO,
      };
      
      for (NSString *hostname in hostnames.allKeys) {
        [[theValue([DOValidators validateHostname:hostname options:DOHostnameOptionsAllowUnderscore | DOHostnameOptionsMustEndInDot]) should] equal:hostnames[hostname]];
      }
    });
    
    context(@"SRV Record Validation", ^{
      
      it(@"should pass or fail as expected for an SRV record", ^{
        NSDictionary *records = @
        {
          @"srv.tcp" : @NO,
          @"_srv.tcp" : @NO,
          @"srv._tcp" : @NO,
          @"_srv._tcp" : @YES,
          @"_srv._tcp.shaps.me" : @YES,
          @"_srv._tcp.shaps_me" : @YES,
          @"_srv.tcp.shaps.me" : @NO,
          @"srv._tcp.shaps.me" : @NO,
        };
        
        for (NSString *record in records.allKeys) {
          [[theValue([DOValidators validateSRVEntry:record]) should] equal:records[record]];
        }
      });
      
    });
    
    context(@"Port Validation", ^{
      
      it(@"should fail if the port is greater than 65,535", ^{
        [[theValue([DOValidators validatePort:65536]) should] beNo];
      });
      
      it(@"should pass if the port is lower than or equal to 65,535", ^{
        [[theValue([DOValidators validatePort:65535]) should] beYes];
        [[theValue([DOValidators validatePort:0]) should] beYes];
      });
      
    });
    
  });
  
});

SPEC_END