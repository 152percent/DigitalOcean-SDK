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
 *  A convenience class for creating 'delete' queries
 */
@interface DOQuery (Deletes)


/**
 *  Deletes the specified droplet
 *
 *  @param dropletID The ID of the droplet to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteDropletWithID:(NSUInteger)dropletID;


/**
 *  Deletes the specified image
 *
 *  @param imageID The ID of the image to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteImageWithID:(NSUInteger)imageID;


/**
 *  Deletes the specified domain
 *
 *  @param name The name of the domain to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteDomainNamed:(nonnull NSString *)name;


/**
 *  Deletes the specified domain record
 *
 *  @param name     The name of the domain for this record
 *  @param recordID The ID of the record to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteRecordForDomainNamed:(nonnull NSString *)name recordID:(NSUInteger)recordID;


/**
 *  Deletes the specified SSH Key
 *
 *  @param SSHKeyID The ID of the SSH Key to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteSSHKeyWithID:(NSUInteger)SSHKeyID;

/**
 *  Deletes the specified SSH Key
 *
 *  @param fingerprint The fingerprint of the SSH Key to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteSSHKeyWithFingerprint:(nonnull NSString *)fingerprint;


/**
 *  Deletes the specified Floating IP
 *
 *  @param floatingIPID The ID of the Floating IP to delete
 *
 *  @return A configured query
 */
+ (nonnull instancetype)deleteFloatingIP:(nonnull NSString *)IPAddress;


@end