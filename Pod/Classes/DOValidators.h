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
 *  Specifies options for parsing a hostname
 */
typedef NS_OPTIONS(NSInteger, DOHostnameOptions) {
  /**
   *  No additional options will be parsed
   */
  DOHostnameOptionsNone = 0,
  /**
   *  Specifies that the hostname must end with a dot '.' character. E.g. digitalocean.com.
   */
  DOHostnameOptionsMustEndInDot = 1 << 0,
  /**
   *  Specifies that the hostname can contain underscore '_' characters
   */
  DOHostnameOptionsAllowUnderscore = 1 << 1,
};


/**
 *  Provides various validation methods that are used throughout the SDK to validate entry. You can also use this in your app to provide front-end validation
 */
@interface DOValidators : NSObject


/**
 *  Validates an SSH Public Key. The key is expected to be a valid RSA or DSS key. The data portion of the key must be base64 encoded.
 *
 *  @param value An SSH Public Key
 *
 *  @return YES if the SSH key is valid, NO otherwise
 */
+ (BOOL)validateSSHKey:(nonnull NSString *)value;


/**
 *  Validates an IPv4 address
 *
 *  @param value The IPv4 address
 *
 *  @return YES if the IP Address is valid, NO otherwise
 */
+ (BOOL)validateIPAddress:(nonnull NSString *)value;


/**
 *  Validates an iPv6 address
 *
 *  @param value The IPv6 address
 *
 *  @return YES if the IP Adress is valid, NO otherwise
 */
+ (BOOL)validateIPv6Address:(nonnull NSString *)value;


/**
 *  Validates a hostname
 *
 *  @param value   The hostname
 *  @param options The options for validation -- generally you can pass 0 here, optionally you can enforce that the hostname must end in a '.'
 *
 *  @return YES if the hostname is valid, NO otherwise
 */
+ (BOOL)validateHostname:(nonnull NSString *)value options:(DOHostnameOptions)options;


/**
 *  Validates an SRV name. Names should follow the format, '_srv._tcp.domain'
 *
 *  @param value The SRV name
 *
 *  @return YES if the value is valid, NO otherwise
 */
+ (BOOL)validateSRVEntry:(nonnull NSString *)value;


/**
 *  Validates the port is between 0 and 65,535
 *
 *  @param port The port to validate
 *
 *  @return YES if the port is valid, NO otherwise
 */
+ (BOOL)validatePort:(NSUInteger)port;


@end