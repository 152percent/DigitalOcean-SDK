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
 *  Defines the type of image to fetch
 */
typedef NS_OPTIONS(NSUInteger, DOImageFetchType) {
  /**
   *  Private images are either backups or snapshots
   */
  DOImageFetchTypePrivate = 0,
  /**
   *  Distribution images are generally Ubuntu, Debian, Fedora, etc...
   */
  DOImageFetchTypeDistribution = 1,
  /**
   *  Application images are generally LAMP, WordPress, Ruby on Rails, etc...
   */
  DOImageFetchTypeApplication = 2,
};



/**
 *  A convenience class for creating 'fetch' queries
 */
@interface DOQuery (Fetches)


/**
 *  Fetches all accounts
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchAccount;


/**
 *  Fetches all regions
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchRegions;


/**
 *  Fetches all sizes
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchSizes;


/**
 *  Fetches all scheduled upgrades
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchScheduledUpgrades;


/**
 *  Fetches all neighbors
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchNeighbors;


/**
 *  Fetches all neighbors for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchNeighborsForDropletWithID:(NSUInteger)dropletID;


/**
 *  Fetches all available kernels for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchKernelsForDropletWithID:(NSUInteger)dropletID;


/**
 *  Fetches all actions
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchActions;


/**
 *  Fetches all actions for a droplet
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchActionsForDropletWithID:(NSUInteger)dropletID;


/**
 *  Fetches all actions for an image
 *
 *  @param imageID The ID of the image
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchActionsForImageWithID:(NSUInteger)imageID;


/**
 *  Fetches the action with the specified ID
 *
 *  @param actionID The ID of the action
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchActionWithID:(NSUInteger)actionID;


/**
 *  Fetches all droplets
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchDroplets;


/**
 *  Fetches the drolet with the specified ID
 *
 *  @param dropletID The ID of the droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchDropletWithID:(NSUInteger)dropletID;


/**
 *  Fetches all images. (note: By default 'itemsPerPage=100' for this query)
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchImages;


/**
 *  Fetches all images of the specified type. (note: By default 'itemsPerPage=100' for this query)
 *
 *  @param type The type of images to return
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchImagesOfType:(DOImageFetchType)type;


/**
 *  Fetches the image with the specified ID
 *
 *  @param imageID The ID of the image
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchImageWithID:(NSUInteger)imageID;


/**
 *  Fetches all domains
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchDomains;


/**
 *  Fetches the domain with the specified name
 *
 *  @param name The name of the domain
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchDomainNamed:(nonnull NSString *)name;


/**
 *  Fetches all records for a domain
 *
 *  @param name       The name of the domain
 *  @param recordID   The ID of the record
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchRecordsForDomainNamed:(nonnull NSString *)name;


/**
 *  Fetches the record with the specified ID in the given domain
 *
 *  @param name       The name of the domain
 *  @param recordID   The ID of the record
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchRecordForDomainNamed:(nonnull NSString *)name recordID:(NSUInteger)recordID;


/**
 *  Fetches all SSH Keys
 *‚
 *  @return A configured query
 */
+ (nonnull instancetype)fetchSSHKeys;


/**
 *  Fetches the SSH Key with the specified ID
 *
 *  @param SSHKeyID The ID of the SSH Key
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchSSHKeyWithID:(NSUInteger)SSHKeyID;


/**
 *  Fetches the SSH Key with the specified fingerprint
 *
 *  @param fingerprint The fingerprint of the SSH Key
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchSSHKeyWithFingerprint:(nonnull NSString *)fingerprint;


/**
 *  Returns all Floating IPs associated
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchFloatingIPs;


/**
 *  Returns the FloatingIP with the specified ID
 *
 *  @param floatingIPID The floating IP identifier
 *
 *  @return A configured query
 */
+ (nonnull instancetype)fetchFloatingIP:(nonnull NSString *)IPAddress;


@end