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

#import "DOQuery+Inserts.h"
#import "DOEndpointConstants.h"
#import "DODroplet.h"
#import "DODomain.h"
#import "DODomainRecord.h"
#import "DOSSHKey.h"
#import "DOValidators.h"
#import "SPXDefines.h"
#import "DOQuery+Private.h"

@interface DODropletConfiguration (Private)
@property (nonatomic, readonly, nonnull) NSDictionary *attributes;
@end

@implementation DOQuery (Inserts)

+ (instancetype)insertDropletWithConfiguration:(void (^)(DODropletConfiguration *configuration))configurationBlock
{
  SPXAssertTrueOrReturnNil(configurationBlock);
  
  DODropletConfiguration *configuration = [DODropletConfiguration new];
  configurationBlock(configuration);
  
  // The following parameters are required!
  SPXAssertTrueOrReturnNil([DOValidators validateHostname:configuration.hostname options:DOHostnameOptionsNone]);
  SPXAssertTrueOrReturnNil(configuration.regionSlug.length);
  SPXAssertTrueOrReturnNil(configuration.sizeSlug.length);
  SPXAssertTrueOrReturnNil(configuration.imageID);
  
  return [self.class insertQueryForObjectClass:DODroplet.class attributes:configuration.attributes endpoint:DODropletsEndpoint params:nil];
}

+ (instancetype)insertDomainNamed:(NSString *)name ipAddress:(NSString *)ipAddress
{
  SPXAssertTrueOrReturnNil([DOValidators validateHostname:name options:DOHostnameOptionsNone]);
  SPXAssertTrueOrReturnNil([DOValidators validateIPAddress:ipAddress]);
  return [self.class insertQueryForObjectClass:DODomain.class attributes:@{ @"name" : name, @"ip_address" : ipAddress } endpoint:DODomainsEndpoint params:nil];
}

+ (instancetype)insertRecordForDomainNamed:(NSString *)name attributes:(NSDictionary *)attributes
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(attributes);
  return [self.class insertQueryForObjectClass:DODomainRecord.class attributes:attributes endpoint:DORecordsEndpoint params:name, nil];
}

+ (instancetype)insertSSHKeyNamed:(NSString *)name publicKey:(NSString *)publicKey
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil([DOValidators validateSSHKey:publicKey]);
  return [self.class insertQueryForObjectClass:DOSSHKey.class attributes:@{ @"name" : name, @"public_key" : publicKey } endpoint:DOSSHKeysEndpoint params:nil];
}

+ (instancetype)insertFloatingIPWithDropletID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class insertQueryForObjectClass:DOFloatingIP.class attributes:@{ @"droplet_id": @(dropletID) } endpoint:DOFloatingIPsEndpoint params:nil];
}

+ (instancetype)insertFloatingIPWithRegionSlug:(NSString *)regionSlug
{
  SPXAssertTrueOrReturnNil(regionSlug);
  return [self.class insertQueryForObjectClass:DOFloatingIP.class attributes:@{ @"region" : regionSlug } endpoint:DOFloatingIPsEndpoint params:nil];
}

@end