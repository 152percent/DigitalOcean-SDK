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
 *  A convenience class for creating 'update' queries
 */
@interface DOQuery (Updates)


/**
 *  Updates the record for the domain
 *
 *  @param name       The name of the domain
 *  @param recordID   The ID of the record to update
 *  @param attributes The attributes for this record
 *
 *  @return A configured query
 */
+ (nonnull instancetype)updateRecordForDomainNamed:(nonnull NSString *)name recordID:(NSUInteger)recordID attributes:(nonnull NSDictionary *)attributes;


/**
 *  Updates the name of an image
 *
 *  @param imageID The ID of the image to update
 *  @param name    The new name for this image
 *
 *  @return A configured query
 */
+ (nonnull instancetype)updateImageWithID:(NSUInteger)imageID withName:(nonnull NSString *)name;


/**
 *  Updates the name for an SSH Key
 *
 *  @param SSHKeyID The ID of the key
 *  @param name     The new name for this SSH Key
 *
 *  @return A configured query
 */
+ (nonnull instancetype)updateSSHKeyWithID:(NSUInteger)SSHKeyID withName:(nonnull NSString *)name;


/**
 *  Updates the name for an SSH Key
 *
 *  @param fingerprint  The fingerprint of the key
 *  @param name         The new name for this SSH Key
 *
 *  @return A configured query
 */
+ (nonnull instancetype)updateSSHKeyWithFingerprint:(nonnull NSString *)fingerprint withName:(nonnull NSString *)name;


@end