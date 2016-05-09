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

#import "DOObject.h"
#import "DONetwork.h"

@class DODroplet;
extern NSDictionary* __nonnull DODropletAttributes(NSString * __nonnull hostname);


/**
 *  Defines the various states for a droplet
 */
typedef NS_ENUM(NSInteger, DODropletStatus) {
  /**
   *  The droplet is active and ready
   */
  DODropletStatusActive,
  /**
   *  The droplet is being initialized and not yet ready
   */
  DODropletStatusNew,
  /**
   *  The droplet has been archived and is no longer available
   */
  DODropletStatusArchived,
  /**
   *  The droplet has been destroyed and is no longer available
   */
  DODropletStatusDestroyed,
  /**
   *  The droplet has been switched off
   */
  DODropletStatusOff,
};



/**
 *  Represents an 'droplet' object
 */
@interface DODroplet : DOObject


/**
 *  Returns the identifier for this droplet
 */
@property (nonatomic, readonly) NSUInteger identifier;


/**
 *  Returns the creation date for this droplet
 */
@property (nonatomic, readonly, nonnull) NSDate *createdAt;


/**
 *  Returns the memory in megabytes for this droplet
 */
@property (nonatomic, readonly, getter=memoryInMegabytes) double memory;


/**
 *  Returns the the number of virtual CPUs for this droplet
 */
@property (nonatomic, readonly) NSUInteger vcpus;


/**
 *  Returns the disk size in gigabytes for this droplet
 */
@property (nonatomic, readonly, getter=diskInGigabytes) double disk;


/**
 *  Returns YES if this droplet is locked (cannot be changed), NO otherwise -- If its locked it means its in the middle of a task that cannot be interrupted
 */
@property (nonatomic, readonly, getter=isLocked) BOOL locked;


/**
 *  Returns the human-readable name for this droplet
 */
@property (nonatomic, readonly, nonnull) NSString *name;


/**
 *  Returns the status for this droplet
 */
@property (nonatomic, readonly) DODropletStatus status;


/**
 *  Returns the size_slug for this droplet
 */
@property (nonatomic, readonly, nonnull) NSString *sizeSlug;


/**
 *  Returns the IPv4 networks associated with this droplet
 */
@property (nonatomic, readonly, nonnull) NSArray <DONetwork*> *IPv4Networks;


/**
 *  Returns the IPv6 networks associated with this droplet
 */
@property (nonatomic, readonly, nonnull) NSArray <DONetwork*> *IPv6Networks;


@end


/**
 *  A configuration object for configuring a new Droplet
 */
@interface DODropletConfiguration : NSObject


/**
 *  The hostname/name for this droplet. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -). (required)
 *
 *  @note The name, if set to a domain name managed in the DigitalOcean DNS management system, will configure a PTR record for the Droplet.
 */
@property (nonatomic, strong, nonnull) NSString *hostname;


/**
 *  The region slug for this droplet. (required)
 */
@property (nonatomic, strong, nonnull) NSString *regionSlug;


/**
 *  The size slug for this droplet. (required)
 */
@property (nonatomic, strong, nonnull) NSString *sizeSlug;


/**
 *  The imageID for this droplet. (required)
 */
@property (nonatomic, assign) NSInteger imageID;


/**
 *  An array containing the IDs or fingerprints of the SSH keys that you wish to embed in the Droplet's root account upon creation. (optional)
 */
@property (nonatomic, strong, nullable) NSArray *sshKeys;


/**
 *  A string of the desired User Data for the Droplet. User Data is currently only available in regions with metadata listed in their features.
 */
@property (nonatomic, strong, nullable) NSString *userData;


/**
 *  If YES, backups will be enabled on this droplet. (default to NO)
 */
@property (nonatomic, assign) BOOL enableBackups;


/**
 *  If YES, IPv6 will be enabled. (defaults to YES)
 */
@property (nonatomic, assign) BOOL enableIPv6;


/**
 *  If YES, this droplet will be accessible from other droplets in the same region. (defaults to NO)
 */
@property (nonatomic, assign) BOOL enablePrivateNetworking;


@end