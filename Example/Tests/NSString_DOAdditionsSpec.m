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
#import "NSString+DOAdditions.h"


SPEC_BEGIN(NSString_DOAdditionsSpec)

describe(@"NSString_DOAdditions", ^{
  
  context(@"Singular Representations", ^{
    
    it(@"should pass or fail as expected", ^{
      NSDictionary *values = @
      {
        @"DODroplet" : @"droplet",
        @"DOImage" : @"image",
        @"Droplet" : @"droplet",
        @"Image" : @"image",
        @"DODomainRecord" : @"domain_record",
        @"DomainRecords" : @"domain_records",
        @"SSHKey" : @"ssh_key",
        @"IPAddress" : @"ip_address",
      };
      
      for (NSString *value in values.allKeys) {
        [[[value do_singularRepresentationForClassWithPrefix:@"DO"] should] equal:values[value]];
      }
    });
    
  });
  
  context(@"Plural Representations", ^{
    
    it(@"should pass or fail as expected", ^{
      NSDictionary *values = @
      {
        @"DODroplet" : @"droplets",
        @"DOImage" : @"images",
        @"Droplet" : @"droplets",
        @"Image" : @"images",
        @"DODomainRecord" : @"domain_records",
        @"DomainRecord" : @"domain_records",
        @"SSHKey" : @"ssh_keys",
        @"IPAddress" : @"ip_addresss"
      };
      
      for (NSString *value in values.allKeys) {
        [[[value do_pluralRepresentationForClassWithPrefix:@"DO"] should] equal:values[value]];
      }
    });
    
  });
  
  context(@"JSON Key Representations", ^{
    
    it(@"should pass or fail as expected", ^{
      NSDictionary *values = @
      {
        @"IpAddress" : @"ip_address",
        @"IPAddress" : @"ip_address",
        @"droplet" : @"droplet",
        @"domainRecord" : @"domain_record",
      };
      
      for (NSString *value in values.allKeys) {
        [[[value do_JSONKeyRepresentation] should] equal:values[value]];
      }
    });
    
  });
  
  context(@"Query Paramters", ^{
    
    it(@"should pass or fail as expected", ^{
      NSDictionary *values = @
      {
        @"value" : @{ },
        @"key=value" : @{ @"key" : @"value" },
        @"key1=value1&key2=value2" : @{ @"key1" : @"value1", @"key2" : @"value2" },
        @"key%201=%C2%A3200" : @{ @"key 1" : @"£200" },
      };
      
      for (NSString *value in values.allKeys) {
        NSDictionary *expectedParams = values[value];
        NSDictionary *params = [value do_queryParameters];
        BOOL result = [params isEqualToDictionary:expectedParams];
        [[theValue(result) should] beYes];
      }
    });
    
  });

});

SPEC_END