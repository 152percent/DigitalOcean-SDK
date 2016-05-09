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

#import "DOQuery+Actions.h"
#import "DOEndpointConstants.h"
#import "DOAction.h"
#import "SPXDefines.h"
#import "DOInternal.h"
#import "DOQuery+Private.h"

@implementation DOQuery (Actions)

+ (instancetype)softPowerOffDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"shutdown" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)hardPowerOffDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"power_off" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)softRebootDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"reboot" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)hardRebootDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"power_cycle" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)powerOnDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"power_on" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)upgradeDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"upgrade" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)resizeDropletWithID:(NSUInteger)dropletID toSizeSlug:(NSString *)sizeSlug increaseDiskPermanently:(BOOL)disk
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(sizeSlug.length);
  SPXAssertTrueOrReturnNil(disk);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"resize", @"size" : sizeSlug, @"disk" : @(disk) } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)rebuildDropletWithID:(NSUInteger)dropletID withImageWithID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"rebuild", @"image" : @(imageID) } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)resetPasswordForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"password_reset" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)renameDropletWithID:(NSUInteger)dropletID name:(NSString *)name
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"rename", @"name" : name } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)updateKernelForDropletWithID:(NSUInteger)dropletID kernelID:(NSUInteger)kernelID
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(kernelID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"change_kernel", @"kernel" : @(kernelID) } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)enableBackupsForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"enable_backups" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)disableBackupsForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"disable_backups" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)restoreBackupForDropletWithID:(NSUInteger)dropletID imageID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"restore", @"image" : @(imageID) } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)enableIPV6ForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"enable_ipv6" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)enablePrivateNetworkingForDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"enable_private_networking" } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)createSnapshotForDropletWithID:(NSUInteger)dropletID name:(NSString *)name
{
  SPXAssertTrueOrReturnNil(dropletID);
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"snapshot", @"name" : name } endpoint:DODropletActionsEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)convertBackupToSnapshotForImageWithID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"convert" } endpoint:DOImageActionsEndpoint params:DONumberAsString(imageID), nil];
}

+ (instancetype)transferImageWithID:(NSUInteger)imageID toRegionSlug:(NSString *)regionSlug
{
  SPXAssertTrueOrReturnNil(imageID);
  SPXAssertTrueOrReturnNil(regionSlug.length);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"transfer", @"region" : regionSlug } endpoint:DOImageActionsEndpoint params:DONumberAsString(imageID), nil];
}

+ (instancetype)assignFloatingIP:(NSString *)IPAddress toDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil([DOValidators validateIPAddress:IPAddress]);
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"assign", @"droplet_id" : @(dropletID) } endpoint:DOFloatingIPActionsEndpoint params:IPAddress, nil];
}

+ (instancetype)unAssignFloatingIP:(NSString *)IPAddress
{
  SPXAssertTrueOrReturnNil([DOValidators validateIPAddress:IPAddress]);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"type" : @"unassign" } endpoint:DOFloatingIPActionsEndpoint params:IPAddress, nil];
}

+ (instancetype)reserveFloatingIPForRegionSlug:(NSString *)regionSlug
{
  SPXAssertTrueOrReturnNil(regionSlug.length);
  return [self.class actionQueryForObjectClass:DOAction.class attributes:@{ @"region" : regionSlug } endpoint:DOFloatingIPActionsEndpoint params:nil];
}

@end