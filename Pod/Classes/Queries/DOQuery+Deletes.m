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

#import "DOQuery+Deletes.h"
#import "DOEndpointConstants.h"
#import "DODroplet.h"
#import "DOImage.h"
#import "DODomainRecord.h"
#import "DODomain.h"
#import "DOSSHKey.h"
#import "SPXDefines.h"
#import "DOInternal.h"
#import "DOQuery+Private.h"

@implementation DOQuery (Deletes)

+ (instancetype)deleteDropletWithID:(NSUInteger)dropletID
{
  SPXAssertTrueOrReturnNil(dropletID);
  return [self.class deleteQueryForEndpoint:DODropletEndpoint params:DONumberAsString(dropletID), nil];
}

+ (instancetype)deleteImageWithID:(NSUInteger)imageID
{
  SPXAssertTrueOrReturnNil(imageID);
  return [self.class deleteQueryForEndpoint:DOImageEndpoint params:DONumberAsString(imageID), nil];
}

+ (instancetype)deleteDomainNamed:(NSString *)name
{
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class deleteQueryForEndpoint:DODomainEndpoint params:name, nil];
}

+ (instancetype)deleteRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(recordID);
  return [self.class deleteQueryForEndpoint:DORecordEndpoint params:name, DONumberAsString(recordID), nil];
}

+ (instancetype)deleteSSHKeyWithID:(NSUInteger)SSHKeyID
{
  SPXAssertTrueOrReturnNil(SSHKeyID);
  return [self.class deleteQueryForEndpoint:DOSSHKeyEndpoint params:DONumberAsString(SSHKeyID), nil];
}

+ (instancetype)deleteSSHKeyWithFingerprint:(NSString *)fingerprint
{
  SPXAssertTrueOrReturnNil(fingerprint.length);
  return [self.class deleteQueryForEndpoint:DOSSHKeyEndpoint params:fingerprint, nil];
}

+ (instancetype)deleteFloatingIP:(NSString *)IPAddress
{
  SPXAssertTrueOrReturnNil([DOValidators validateIPAddress:IPAddress]);
  return [self.class deleteQueryForEndpoint:DOFloatingIPEndpoint params:IPAddress, nil];
}

@end