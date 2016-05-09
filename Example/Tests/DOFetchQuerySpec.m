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
#import "DOEndpointConstants.h"
#import "DOInternal.h"


SPEC_BEGIN(DOFetchQuerySpec)

describe(@"DOQuery", ^{
  
  __block DOQuery *query = nil;
  
  context(@"Account", ^{
    
    it(@"should create a valid query to fetch all accounts", ^{
      query = [DOQuery fetchAccount];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOAccount.class)];
      [[query.path should] equal:DOURL(DOAccountEndpoint).absoluteString];
    });
    
  });
  
  context(@"Regions", ^{
    
    it(@"should create a valid query to fetch all regions", ^{
      query = [DOQuery fetchRegions];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DORegion.class)];
      [[query.path should] equal:DOURL(DORegionsEndpoint).absoluteString];
    });
    
  });
  
  context(@"Sizes", ^{
    
    it(@"should create a valid query to fetch all sizes", ^{
      query = [DOQuery fetchSizes];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOSize.class)];
      [[query.path should] equal:DOURL(DOSizesEndpoint).absoluteString];
    });
    
  });
  
  context(@"Scheduled Upgrades", ^{
    
    it(@"should create a valid query to fetch all scheduled upgrades", ^{
      query = [DOQuery fetchScheduledUpgrades];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[query.path should] equal:DOURL(DOUpgradesEndpoint).absoluteString];
    });
    
  });
  
  context(@"Neighbors", ^{
    
    it(@"should create a valid query to fetch all neighbors", ^{
      query = [DOQuery fetchNeighbors];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
      [[query.path should] equal:DOURL(DONeighborsEndpoint).absoluteString];
    });
    
    it(@"should create a valid query to fetch all neighbors for a droplet", ^{
      query = [DOQuery fetchNeighborsForDropletWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/neighbors").absoluteString];
    });
    
  });
  
  context(@"Kernels", ^{
    
    it(@"should create a valid query to fetch all kernels for a droplet", ^{
      query = [DOQuery fetchKernelsForDropletWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOKernel.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/kernels").absoluteString];
    });
    
  });
  
  context(@"Actions", ^{
    
    it(@"should create a valid query to fetch all actions", ^{
      query = [DOQuery fetchActions];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(DOActionsEndpoint).absoluteString];
    });
    
    it(@"should create a valid query to fetch all actions for a droplet", ^{
      query = [DOQuery fetchActionsForDropletWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions").absoluteString];
    });
    
    it(@"should create a valid query to fetch all actions for an image", ^{
      query = [DOQuery fetchActionsForImageWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"images/12345/actions").absoluteString];
    });
    
    it(@"should create a valid query to fetch an action", ^{
      query = [DOQuery fetchActionWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"actions/12345").absoluteString];
    });
    
  });
  
  context(@"Droplets", ^{
    
    it(@"should create a valid query to fetch all droplets", ^{
      query = [DOQuery fetchDroplets];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
      [[query.path should] equal:DOURL(DODropletsEndpoint).absoluteString];
    });
    
    it(@"should create a valid query to fetch a droplet", ^{
      query = [DOQuery fetchDropletWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
      [[query.path should] equal:DOURL(@"droplets/12345").absoluteString];
    });
    
  });
  
  context(@"Images", ^{
    
    it(@"should create a valid query to fetch all images", ^{
      query = [DOQuery fetchImages];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
      [[query.path should] equal:DOURL(DOImagesEndpoint).absoluteString];
    });
    
    it(@"should create a valid query for private images", ^{
      query = [DOQuery fetchImagesOfType:DOImageFetchTypePrivate];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
      [[query.path should] equal:DOURL(@"images?private=true").absoluteString];
    });
    
    it(@"should create a valid query for application images", ^{
      query = [DOQuery fetchImagesOfType:DOImageFetchTypeApplication];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
      [[query.path should] equal:DOURL(@"images?type=application").absoluteString];
    });
    
    it(@"should create a valid query for distribution images", ^{
      query = [DOQuery fetchImagesOfType:DOImageFetchTypeDistribution];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOImage.class)];
      [[query.path should] equal:DOURL(@"images?type=distribution").absoluteString];
    });
    
  });
  
  context(@"Domains", ^{
    
    it(@"should create a valid query to fetch all domains", ^{
      query = [DOQuery fetchDomains];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODomain.class)];
      [[query.path should] equal:DOURL(DODomainsEndpoint).absoluteString];
    });
    
    it(@"should create a valid query to fetch a domain", ^{
      query = [DOQuery fetchDomainNamed:@"shaps.me"];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODomain.class)];
      [[query.path should] equal:DOURL(@"domains/shaps.me").absoluteString];
    });
    
  });
  
  context(@"Domain Records", ^{
    
    it(@"should create a valid query to fetch all records for a domain", ^{
      query = [DOQuery fetchRecordsForDomainNamed:@"shaps.me"];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODomainRecord.class)];
      [[query.path should] equal:DOURL(@"domains/shaps.me/records").absoluteString];
    });
    
    it(@"should create a valid query to fetch a record for a domain", ^{
      query = [DOQuery fetchRecordForDomainNamed:@"shaps.me" recordID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DODomainRecord.class)];
      [[query.path should] equal:DOURL(@"domains/shaps.me/records/12345").absoluteString];
    });
    
  });
  
  context(@"SSH Keys", ^{
    
    it(@"should create a valid query to fetch all SSH Keys", ^{
      query = [DOQuery fetchSSHKeys];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(DOSSHKeysEndpoint).absoluteString];
    });
    
    it(@"should create a valid query to fetch an SSH Key by its ID", ^{
      query = [DOQuery fetchSSHKeyWithID:12345];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(@"account/keys/12345").absoluteString];
    });

    it(@"should create a valid query to fetch an SSH Key by its fingerprint", ^{
      query = [DOQuery fetchSSHKeyWithFingerprint:@"12345"];
      
      [[query.HTTPBody should] beNil];
      [[query.HTTPMethod should] equal:@"GET"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(@"account/keys/12345").absoluteString];
    });
    
  });

});

SPEC_END