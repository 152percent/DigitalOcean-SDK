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

#import "DOQuery+Updates.h"
#import "DOEndpointConstants.h"
#import "DODomainRecord.h"
#import "DOImage.h"
#import "DOSSHKey.h"
#import "SPXDefines.h"
#import "DOInternal.h"
#import "DOQuery+Private.h"

@implementation DOQuery (Updates)

+ (instancetype)updateRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID attributes:(NSDictionary *)attributes
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(recordID);
  SPXAssertTrueOrReturnNil(attributes);
  return [self.class updateQueryForObjectClass:DODomainRecord.class attributes:attributes endpoint:DORecordEndpoint params:name, DONumberAsString(recordID), nil];
}

+ (instancetype)updateImageWithID:(NSUInteger)imageID withName:(NSString *)name
{
  SPXAssertTrueOrReturnNil(imageID);
  SPXAssertTrueOrReturnNil(name.length);
  return [self.class updateQueryForObjectClass:DOImage.class attributes:@{ @"name" : name } endpoint:DOImageEndpoint params:DONumberAsString(imageID), nil];
}

+ (instancetype)updateSSHKeyWithID:(NSUInteger)SSHKeyID withName:(NSString *)name
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(SSHKeyID);
  return [self.class updateQueryForObjectClass:DOSSHKey.class attributes:@{ @"name" : name } endpoint:DOSSHKeyEndpoint params:DONumberAsString(SSHKeyID), nil];
}

+ (instancetype)updateSSHKeyWithFingerprint:(NSString *)fingerprint withName:(NSString *)name
{
  SPXAssertTrueOrReturnNil(name.length);
  SPXAssertTrueOrReturnNil(fingerprint.length);
  return [self.class updateQueryForObjectClass:DOSSHKey.class attributes:@{ @"name" : name } endpoint:DOSSHKeyEndpoint params:fingerprint, nil];
}

@end