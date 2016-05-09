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
#import "DODefines.h"


@class DODomainRecord;


/**
 *  Returns attributes for an A record to be passed into a DOQuery instance
 *
 *  @param name      The name for this record. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *  @param ipAddress The IPv4 address for this record
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeA(NSString * __nonnull name, NSString * __nonnull ipAddress);


/**
 *  Returns attributes for an AAAA record to be passed into a DOQuery instance
 *
 *  @param name        Teh name for this record. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *  @param ipv6Address The IPv6 address for this record
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeAAAA(NSString *__nonnull name, NSString *__nonnull ipv6Address);


/**
 *  Returns attributes for a CNAME record to be passed into a DOQuery instance
 *
 *  @param name     The name. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *  @param hostname The hostname. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -).
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeCNAME(NSString *__nonnull name, NSString *__nonnull hostname);


/**
 *  Returns attributes for an MX record to be passed into a DOQuery instance
 *
 *  @param hostname The hostname. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *  @param priority The priority
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeMX(NSString *__nonnull hostname, NSUInteger priority);


/**
 *  Returns attributes for a TXT record to be passed into a DOQuery instance
 *
 *  @param name The name
 *  @param text The TXT data.
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeTXT(NSString *__nonnull name, NSString *__nonnull text);


/**
 *  Returns attributes for an SRC record to be passed into a DOQuery instance
 *
 *  @param name     The name should follow the format '_srv._tcp.domain'. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -, _)
 *  @param hostname The hostname. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *  @param port     The port
 *  @param priority The priority
 *  @param weight   The weight
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeSRV(NSString *__nonnull name, NSString *__nonnull hostname, NSUInteger port, NSUInteger priority, NSUInteger weight);


/**
 *  Returns attributes for an NS record to be passed into a DOQuery instance
 *
 *  @param hostname The hostname. Only valid hostname characters are allowed (a-z, A-Z, 0-9, -)
 *
 *  @return Attributes representation of this record
 */
extern NSDictionary* __nonnull DODomainRecordTypeNS(NSString *__nonnull hostname);


/**
 *  Represents an 'domain_record' object
 */
@interface DODomainRecord : DOObject


/**
 *  Returns the identifier for this domain record
 */
@property (nonatomic, readonly) NSUInteger identifier;


/**
 *  Returns the type for this domain record (A, AAA, CNAME, MX, TXT, SRV or NS)
 */
@property (nonatomic, readonly, nonnull) NSString *type;


/**
 *  Returns the name for this domain record (this is the hostname when type == MX or NS)
 */
@property (nonatomic, readonly, nullable) NSString *name;


/**
 *  Returns the data for this domain record. This is usually the IP Address or text, however it will be the hostname for SRV records
 */
@property (nonatomic, readonly, nullable) NSString *data;


/**
 *  Returns the priority for this domain record (only applicable when type == SRV)
 */
@property (nonatomic, readonly) NSUInteger priority;


/**
 *  Returns the port for this domain record (only applicable when type == SRV)
 */
@property (nonatomic, readonly) NSUInteger port;


/**
 *  Returns the weight for this domain record (only applicable when type == SRV)
 */
@property (nonatomic, readonly) NSUInteger weight;


@end