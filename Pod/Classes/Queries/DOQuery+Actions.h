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

#import "DOQuery.h"


/**
 *  A convenience class for creating 'action' queries
 */
@interface DOQuery (Actions)


/**
 *  Powers on a droplet, soft
 *
 *  @param dropletID The ID of the droplet to power off
 *
 *  @return A configured query
 */
+ (nonnull instancetype)softPowerOffDropletWithID:(NSUInteger)dropletID;


/**
 *  Powers on a droplet, hard
 *
 *  @param dropletID The ID of the droplet to power off
 *
 *  @return A configured query
 */
+ (nonnull instancetype)hardPowerOffDropletWithID:(NSUInteger)dropletID;


/**
 *  Reboots a droplet, soft
 *
 *  @param dropletID The ID of the droplet to reboot
 *
 *  @return A configured query
 */
+ (nonnull instancetype)softRebootDropletWithID:(NSUInteger)dropletID;


/**
 *  Reboots a droplet, hard
 *
 *  @param dropletID The ID of the droplet to reboot
 *
 *  @return A configured query
 */
+ (nonnull instancetype)hardRebootDropletWithID:(NSUInteger)dropletID;


/**
 *  Powers on a droplet
 *
 *  @param dropletID The ID of the droplet to power on
 *
 *  @return A configured query
 */
+ (nonnull instancetype)powerOnDropletWithID:(NSUInteger)dropletID;


/**
 *  Upgrades a droplet
 *
 *  @param dropletID The ID of the droplet to upgrade
 *
 *  @return A configured query
 */
+ (nonnull instancetype)upgradeDropletWithID:(NSUInteger)dropletID;


/**
 *  Resizes a droplet (droplet must be switched off)
 *
 *  @param dropletID The ID of the droplet to resize
 *  @param sizeSlug  The size_slug representing the desired size
 *  @param disk      If YES, your Droplet’s filesystem will be expanded. (This action is not reversible)
 *
 *  @return A configured query
 */
+ (nonnull instancetype)resizeDropletWithID:(NSUInteger)dropletID toSizeSlug:(nonnull NSString *)sizeSlug increaseDiskPermanently:(BOOL)disk;


/**
 *  Rebuilds a droplet
 *
 *  @param dropletID The ID of the droplet to rebuild
 *  @param imageID   The ID of the image to use
 *
 *  @return A configured query
 */
+ (nonnull instancetype)rebuildDropletWithID:(NSUInteger)dropletID withImageWithID:(NSUInteger)imageID;


/**
 *  Resets the password for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)resetPasswordForDropletWithID:(NSUInteger)dropletID;


/**
 *  Renames a droplet
 *
 *  @param dropletID The ID of the droplet to rename
 *  @param name      The new name for the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)renameDropletWithID:(NSUInteger)dropletID name:(nonnull NSString *)name;


/**
 *  Updates the kernel for a droplet. This will update your configuration. After running this query you should run a 'hardRebootDropletWithID:' query to make the new kernel active.
 *
 *  @param dropletID The ID of the droplet to resize
 *  @param kernelID  The ID of the kernel to use
 *
 *  @return A configured query
 */
+ (nonnull instancetype)updateKernelForDropletWithID:(NSUInteger)dropletID kernelID:(NSUInteger)kernelID;


/**
 *  Enables backups for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)enableBackupsForDropletWithID:(NSUInteger)dropletID;


/**
 *  Disables backups for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)disableBackupsForDropletWithID:(NSUInteger)dropletID;


/**
 *  Restores a backup for a droplet
 *
 *  @param dropletID The ID of the droplet to restore
 *  @param imageID   The ID of the image to use
 *
 *  @return A configured query
 */
+ (nonnull instancetype)restoreBackupForDropletWithID:(NSUInteger)dropletID imageID:(NSUInteger)imageID;


/**
 *  Enabled IPV6 for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)enableIPV6ForDropletWithID:(NSUInteger)dropletID;


/**
 *  Enables private networking for a droplet (droplet must be switched off)
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)enablePrivateNetworkingForDropletWithID:(NSUInteger)dropletID;


/**
 *  Creates a snapshot of a droplet (droplet must be switched off)
 *
 *  @param dropletID The ID of the droplet
 *  @param name      The name to use for this snapshot
 *
 *  @return A configured query
 */
+ (nonnull instancetype)createSnapshotForDropletWithID:(NSUInteger)dropletID name:(nonnull NSString *)name;


/**
 *  Converts a backup image to a snapshot
 *
 *  @param imageID The ID of the image to convert
 *
 *  @return A configured query
 */
+ (nonnull instancetype)convertBackupToSnapshotForImageWithID:(NSUInteger)imageID;


/**
 *  Transfers an image to another region
 *
 *  @param imageID    The ID of the image to transfer
 *  @param regionSlug The region_slug representing the region to transfer to
 *
 *  @return A configured query
 */
+ (nonnull instancetype)transferImageWithID:(NSUInteger)imageID toRegionSlug:(nonnull NSString *)regionSlug;


/**
 *  Assigns a floating IP to the Droplet with the specified ID
 *
 *  @param IPAddress The IP address of the floating IP
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)assignFloatingIP:(nonnull NSString *)IPAddress toDropletWithID:(NSUInteger)dropletID;


/**
 *  Un-assigns the specified floating IP
 *
 *  @param IPAddress The IP address of the floating IP
 *
 *  @return A configured query
 */
+ (nonnull instancetype)unAssignFloatingIP:(nonnull NSString *)IPAddress;


/**
 *  Reserves a floating IP for the Region with the specified ID
 *
 *  @param regionID The ID of the Region
 *
 *  @return A configured qeuery
 */
+ (nonnull instancetype)reserveFloatingIPForRegionSlug:(nonnull NSString *)regionSlug;


@end