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

@class DODropletConfiguration;


/**
 *  A convenience class for creating 'insert' queries
 */
@interface DOQuery (Inserts)


/**
 *  Inserts a new droplet
 *
 *  @param configurationBlock The configuration for this droplet
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertDropletWithConfiguration:(nonnull void (^)(DODropletConfiguration * __nonnull configuration))configurationBlock;


/**
 *  Inserts a new domain
 *
 *  @param name      The name for this domain
 *  @param ipAddress The IP Address for this domain
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertDomainNamed:(nonnull NSString *)name ipAddress:(nonnull NSString *)ipAddress;


/**
 *  Inserts a new domain record
 *
 *  @param name       The name of the domain for this record
 *  @param attributes The attributes for this record
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertRecordForDomainNamed:(nonnull NSString *)name attributes:(nonnull NSDictionary *)attributes;


/**
 *  Inserts a new SSH Key
 *
 *  @param name      The name for this key
 *  @param publicKey The public key
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertSSHKeyNamed:(nonnull NSString *)name publicKey:(nonnull NSString *)publicKey;


/**
 *  Inserts a new Floating IP (this will be automatically assigned to the specified droplet)
 *
 *  @param dropletID The droplet to assign this IP to
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertFloatingIPWithDropletID:(NSUInteger)dropletID;


/**
 *  Inserts a new Floating IP (this will reserve the IP for the specified region)
 *
 *  @param regionSlug The region for this IP
 *
 *  @return A configured query
 */
+ (nonnull instancetype)insertFloatingIPWithRegionSlug:(nonnull NSString *)regionSlug;


@end