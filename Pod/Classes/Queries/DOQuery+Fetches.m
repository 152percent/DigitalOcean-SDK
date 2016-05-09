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

#import "DOQuery+Fetches.h"
#import "DOEndpointConstants.h"
#import "DOAccount.h"
#import "DODroplet.h"
#import "DOImage.h"
#import "DODomain.h"
#import "DODomainRecord.h"
#import "DOSSHKey.h"
#import "DOSize.h"
#import "DORegion.h"
#import "DOAction.h"
#import "DOKernel.h"
#import "SPXDefines.h"
#import "DOInternal.h"
#import "DOQuery+Private.h"
#import "DOFloatingIP.h"

@interface DOInternalObject : DOObject @end
@implementation DOInternalObject @end

@implementation DOQuery (Fetches)

+ (instancetype)fetchAccount
{
  return [self.class fetchQueryForObjectClass:DOAccount.class attributes:nil endpoint:DOAccountEndpoint params:nil];
}

+ (instancetype)fetchRegions
{
  return [self.class fetchQueryForObjectClass:DORegion.class attributes:nil endpoint:DORegionsEndpoint params:nil];
}

+ (instancetype)fetchSizes
{
  return [self.class fetchQueryForObjectClass:DOSize.class attributes:nil endpoint:DOSizesEndpoint params:nil];
}

+ (instancetype)fetchScheduledUpgrades
{
  return [self.class fetchQueryForObjectClass:DOInternalObject.class attributes:nil endpoint:DOUpgradesEndpoint params:nil];
}

+ (instancetype)fetchNeighbors
{
  return [self.class fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:DONeighborsEndpoint params:nil];
}

+ (instancetype)fetchNeighborsForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:DODropletNeighborsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)fetchKernelsForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class fetchQueryForObjectClass:DOKernel.class attributes:nil endpoint:DODropletKernelsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)fetchActions
{
  return [self.class fetchQueryForObjectClass:DOAction.class attributes:nil endpoint:DOActionsEndpoint params:nil];
}

+ (instancetype)fetchActionsForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class fetchQueryForObjectClass:DOAction.class attributes:nil endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)fetchActionsForImageWithID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class fetchQueryForObjectClass:DOAction.class attributes:nil endpoint:DOImageActionsEndpoint params:DONumberAsString(imageID), nil];
}

+ (instancetype)fetchActionWithID:(NSUInteger)actionID
{
  SPXAssertTrueOrReturnNil(actionID);
  return [self.class fetchQueryForObjectClass:DOAction.class attributes:nil endpoint:DOActionEndpoint params:DONumberAsString(actionID), nil];
}


+ (instancetype)fetchDroplets
{
  return [self.class fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:DODropletsEndpoint params:nil];
}

+ (instancetype)fetchDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class fetchQueryForObjectClass:DODroplet.class attributes:nil endpoint:DODropletEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)fetchImages
{
  DOQuery *query = [self.class fetchQueryForObjectClass:DOImage.class attributes:nil endpoint:DOImagesEndpoint params:nil];
  query.itemsPerPage = 100;
  return query;
}

+ (instancetype)fetchImagesOfType:(DOImageFetchType)type
{
  NSMutableDictionary *attributes = [NSMutableDictionary new];
  
  switch (type) {
    case DOImageFetchTypePrivate:
      attributes[@"private"] = @"true";
      break;
    case DOImageFetchTypeDistribution:
      attributes[@"type"] = @"distribution";
      break;
    case DOImageFetchTypeApplication:
      attributes[@"type"] = @"application";
      break;
  }
  
  DOQuery *query = [self.class fetchQueryForObjectClass:DOImage.class attributes:attributes endpoint:DOImagesEndpoint params:nil];
  query.itemsPerPage = 100;
  return query;
}

+ (instancetype)fetchImageWithID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class fetchQueryForObjectClass:DOImage.class attributes:nil endpoint:DOImageEndpoint params:DONumberAsString(imageID), nil];
}


+ (instancetype)fetchDomains
{
  return [self.class fetchQueryForObjectClass:DODomain.class attributes:nil endpoint:DODomainsEndpoint params:nil];
}

+ (instancetype)fetchDomainNamed:(NSString *)name
{
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class fetchQueryForObjectClass:DODomain.class attributes:nil endpoint:DODomainEndpoint params:name, nil];
}


+ (instancetype)fetchRecordsForDomainNamed:(NSString *)name
{
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class fetchQueryForObjectClass:DODomainRecord.class attributes:nil endpoint:DORecordsEndpoint params:name, nil];
}

+ (instancetype)fetchRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(recordID);
  return [self.class fetchQueryForObjectClass:DODomainRecord.class attributes:nil endpoint:DORecordEndpoint params:name, DONumberAsString(recordID), nil];
}

+ (instancetype)fetchSSHKeys
{
  return [self.class fetchQueryForObjectClass:DOSSHKey.class attributes:nil endpoint:DOSSHKeysEndpoint params:nil];
}

+ (instancetype)fetchFloatingIPs
{
  return [self.class fetchQueryForObjectClass:DOFloatingIP.class attributes:nil endpoint:DOFloatingIPsEndpoint params:nil];
}

+ (instancetype)fetchSSHKeyWithID:(NSUInteger)SSHKeyID
{
  SPXAssertTrueOrReturnNil(SSHKeyID);
  return [self.class fetchQueryForObjectClass:DOSSHKey.class attributes:nil endpoint:DOSSHKeyEndpoint params:DONumberAsString(SSHKeyID), nil];
}

+ (instancetype)fetchSSHKeyWithFingerprint:(NSString *)fingerprint
{
  SPXAssertTrueOrReturnNil(fingerprint.length);
  return [self.class fetchQueryForObjectClass:DOSSHKey.class attributes:nil endpoint:DOSSHKeyEndpoint params:fingerprint, nil];
}

+ (instancetype)fetchFloatingIP:(NSString *)IPAddress
{
  SPXAssertTrueOrReturnNil(IPAddress);
  return [self.class fetchQueryForObjectClass:DOFloatingIP.class attributes:nil endpoint:DOFloatingIPEndpoint params:IPAddress, nil];
}

@end