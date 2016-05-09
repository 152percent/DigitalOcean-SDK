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

@import Foundation;


/**
 *  This endpoint returns to the users account /account
 */
static NSString *const DOAccountEndpoint = @"account";

/**
 *  This endpoint returns all actions /actions
 */
static NSString *const DOActionsEndpoint = @"actions";

/**
 *  This endpoint returns a specified action /actions/$ACTION_ID
 */
static NSString *const DOActionEndpoint = @"actions/:id";

/**
 *  This endpoint returns all domains /domains
 */
static NSString *const DODomainsEndpoint = @"domains";

/**
 *  This endpoint returns a specified domain /domains/$DOMAIN_NAME
 */
static NSString *const DODomainEndpoint = @"domains/:id";

/**
 *  This endpoint returns all droplets /droplets
 */
static NSString *const DODropletsEndpoint = @"droplets";

/**
 *  This endpoint returns all snapshots for a specific droplet /droplets/$DROPLET_ID/snapshots
 */
static NSString *const DODropletSnapshots = @"droplets/:id/snapshots";

/**
 *  This endpoint returns all backups for a specific droplet /droplets/$DROPLET_ID/backups
 */
static NSString *const DODropletBackups = @"droplets/:id/backups";

/**
 *  This endpoint returns all actions for a specific droplet /droplets/$DROPLET_ID/actions
 */
static NSString *const DODropletActionsEndpoint = @"droplets/:id/actions";

/**
 *  This endpoint returns all kernels available for this droplet
 */
static NSString *const DODropletKernelsEndpoint = @"droplets/:id/kernels";

/**
 *  This endpoint returns all neighbors for a specific droplet /droplets/$DROPLET_ID/neighbors
 */
static NSString *const DODropletNeighborsEndpoint = @"droplets/:id/neighbors";

/**
 *  This endpoint returns a specific droplet /droplets/$DROPLET_ID
 */
static NSString *const DODropletEndpoint = @"droplets/:id";

/**
 *  This endpoint returns all records for a specific domain /domains/$DOMAIN_NAME/records
 */
static NSString *const DORecordsEndpoint = @"domains/:id/records";

/**
 *  This endpoint returns a specific record for a specific domain /domains/$DOMAIN_NAME/records/$RECORD_ID
 */
static NSString *const DORecordEndpoint = @"domains/:id/records/:id";

/**
 *  This endpoint returns all neighbors /reports/droplet_neighbors
 */
static NSString *const DONeighborsEndpoint = @"reports/droplet_neighbors";

/**
 *  This endpoint returns all droplets that will be upgraded /droplet_upgrades
 */
static NSString *const DOUpgradesEndpoint = @"droplet_upgrades";

/**
 *  This endpoint returns all images /images
 */
static NSString *const DOImagesEndpoint = @"images";

/**
 *  This endpoint returns a specific image /images/$IMAGE_ID
 */
static NSString *const DOImageEndpoint = @"images/:id";

/**
 *  This endpoint returns all actions for a specific image /images/$IMAGE_ID/actions
 */
static NSString *const DOImageActionsEndpoint = @"images/:id/actions";

/**
 *  This endpoint returns all SSH Keys /account/keys
 */
static NSString *const DOSSHKeysEndpoint = @"account/keys";

/**
 *  This endpoint returns a specific SSH Key /account/keys/%SSH_KEY_ID or /account/keys/%FINGERPRINT
 */
static NSString *const DOSSHKeyEndpoint = @"account/keys/:id";

/**
 *  This endpoint returns all regions /regions
 */
static NSString *const DORegionsEndpoint = @"regions";

/**
 *  This endpoint returns all sizes /sizes
 */
static NSString *const DOSizesEndpoint = @"sizes";

/**
 *  This endpoint returns all floating IPs
 */
static NSString *const DOFloatingIPsEndpoint = @"floating_ips";


/**
 *  This endpoint returns a specific floating IP
 */
static NSString *const DOFloatingIPEndpoint = @"floating_ips/:id";

/**
 *  This endpoing returns all actions for a specific floating IP
 */
static NSString *const DOFloatingIPActionsEndpoint = @"floating_ips/:id/actions";