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
#import "DigitalOcean.h"
#import "DOInternal.h"
#import "DOQuery+Private.h"

SPEC_BEGIN(DOQuerySpec)

describe(@"DOQuery", ^{
  
  __block DOQuery *query = nil;
  
  context(@"Fetch Query", ^{
    
    it(@"should return a valid fetch query", ^{
      NSDictionary *attributes = @{ @"private" : @"true" };
      NSString *expectedPath = DOURL(@"image/12345?private=true").absoluteString;
      
      query = [DOQuery fetchQueryForObjectClass:DOImage.class attributes:attributes endpoint:@"image/:id" params:@"12345", nil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[query.HTTPBody should] beNil];
      [[query.path should] equal:expectedPath];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
    });
    
  });
  
  context(@"Update Query", ^{
    
    it(@"should return a valid update query", ^{
      NSDictionary *attributes = @{ @"name" : @"My Droplet" };
      NSString *expectedPath = DOURL(@"droplets/12345?name=My%20Droplet").absoluteString;
      
      query = [DOQuery updateQueryForObjectClass:DODroplet.class attributes:attributes endpoint:@"droplets/:id" params:@"12345", nil];
      [[query.HTTPMethod should] equal:@"PUT"];
      [[query.path should] equal:expectedPath];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
    });
    
  });
  
  context(@"Insert Query", ^{
    
    it(@"should return a valid insert query", ^{
      NSDictionary *attributes = @{ @"name" : @"My SSH Key", @"public_key" : @"foo" };
      NSString *expectedPath = DOURL(@"account/keys?name=My%20SSH%20Key&public_key=foo").absoluteString;
      
      query = [DOQuery insertQueryForObjectClass:DOSSHKey.class attributes:attributes endpoint:@"account/keys" params:nil];
      [[query.HTTPMethod should] equal:@"POST"];
      [[query.path should] equal:expectedPath];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
    });
    
  });
  
  context(@"Delete Query", ^{
    
    it(@"should return a valid delete query", ^{
      NSString *expectedPath = DOURL(@"droplets/12345").absoluteString;
      
      query = [DOQuery deleteQueryForEndpoint:@"droplets/:id" params:@"12345", nil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.HTTPBody should] beNil];
      [[query.path should] equal:expectedPath];
    });
    
  });
  
  context(@"Action Query", ^{
    
    it(@"should return a valid action query", ^{
      NSDictionary *attributes = @{ @"type" : @"reboot" };
      NSString *expectedPath = DOURL(@"droplets?type=reboot").absoluteString;
      
      query = [DOQuery insertQueryForObjectClass:DOAction.class attributes:attributes endpoint:@"droplets" params:nil];
      [[query.HTTPMethod should] equal:@"POST"];
      [[query.path should] equal:expectedPath];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
    });
    
  });
  
  context(@"Items per page", ^{
    
    it(@"should return 0", ^{
      DOQuery *query = [DOQuery fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:@"Droplets" params:nil];
      [[theValue(query.itemsPerPage) should] equal:theValue(0)];
    });
    
    it(@"should return 200", ^{
      DOQuery *query = [DOQuery fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:@"Droplets" params:nil];
      query.itemsPerPage = 200;
      [[theValue(query.itemsPerPage) should] equal:theValue(200)];
    });
    
  });

});

SPEC_END