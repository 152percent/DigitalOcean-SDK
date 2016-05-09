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
#import "DOEndpointConstants.h"

SPEC_BEGIN(DOUpdateQueriesSpec)

describe(@"DOQuery", ^{
  
  __block DOQuery *query = nil;
  
  context(@"Domain Record", ^{
    
    it(@"should create a valid query to update a record for a domain", ^{
      query = [DOQuery updateRecordForDomainNamed:@"shaps.me" recordID:12345 attributes:DODomainRecordTypeA(@"@", @"10.0.0.1")];
      [[query.HTTPMethod should] equal:@"PUT"];
      [[theValue(query.objectClass) should] equal:theValue(DODomainRecord.class)];
      [[query.path should] equal:DOURL(@"domains/shaps.me/records/12345?name=@&type=A&data=10.0.0.1").absoluteString];
    });
    
  });
  
  context(@"Image", ^{

    it(@"should create a valid query to update an image name", ^{
      query = [DOQuery updateImageWithID:12345 withName:@"New Name"];
      [[query.HTTPMethod should] equal:@"PUT"];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
      [[query.path should] equal:DOURL(@"images/12345?name=New%20Name").absoluteString];
    });
    
  });
  
  context(@"SSH Key", ^{
    
    it(@"should create a valid query using the identifier", ^{
      query = [DOQuery updateSSHKeyWithID:12345 withName:@"New Name"];
      [[query.HTTPMethod should] equal:@"PUT"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(@"account/keys/12345?name=New%20Name").absoluteString];
    });
    
    it(@"should create a valid query using the fingerprint", ^{
      query = [DOQuery updateSSHKeyWithFingerprint:@"12345" withName:@"New Name"];
      [[query.HTTPMethod should] equal:@"PUT"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(@"account/keys/12345?name=New%20Name").absoluteString];
    });
    
  });

});

SPEC_END