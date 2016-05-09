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

SPEC_BEGIN(DODeleteQuerySpec)

describe(@"DOQuery", ^{
  
  __block DOQuery *query = nil;
  
  context(@"Droplets", ^{
    
    it(@"should create a valid query for deleting a droplet", ^{
      query = [DOQuery deleteDropletWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"droplets/12345").absoluteString];
    });
    
  });
  
  context(@"Images", ^{
    
    it(@"should create a valid query for deleting an image", ^{
      query = [DOQuery deleteImageWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"images/12345").absoluteString];
    });
    
  });
  
  context(@"Domains", ^{
    
    it(@"should create a valid query for deleting a domain", ^{
      query = [DOQuery deleteDomainNamed:@"shaps.me"];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"domains/shaps.me").absoluteString];
    });
    
  });
  
  context(@"Domain Record", ^{
    
    it(@"should create a valid query for deleting a domain record", ^{
      query = [DOQuery deleteRecordForDomainNamed:@"shaps.me" recordID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"domains/shaps.me/records/12345").absoluteString];
    });
    
  });
  
  context(@"Droplets", ^{
    
    it(@"should create a valid query for deleting an SSH key by its ID", ^{
      query = [DOQuery deleteSSHKeyWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"account/keys/12345").absoluteString];
    });
    
  });
  
  context(@"Droplets", ^{
    
    it(@"should create a valid query for deleting an SSH key by its fingerpring", ^{
      query = [DOQuery deleteSSHKeyWithFingerprint:@"12345"];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"DELETE"];
      [[query.path should] equal:DOURL(@"account/keys/12345").absoluteString];
    });
    
  });

});

SPEC_END