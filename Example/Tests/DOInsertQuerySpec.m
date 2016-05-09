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

#import <Kiwi/Kiwi.h>
#import "DigitalOcean.h"
#import "DOEndpointConstants.h"
#import "DOInternal.h"

@interface DODropletConfiguration (Private)
@property (nonatomic, strong) NSDictionary *attributes;
@end

SPEC_BEGIN(DOInsertQuerySpec)

describe(@"DOQuery", ^{
  
  __block DOQuery *query = nil;
  
  context(@"Droplet", ^{
    
    __block DODropletConfiguration *config = nil;
    
    NSString *hostname = @"shaps.me";
    NSUInteger imageID = 10322623;
    NSString *sizeSlug = @"512mb";
    NSString *regionSlug = @"lon1";
    BOOL enableBackups = YES;
    BOOL enableIPv6 = YES;
    BOOL enablePrivateNetworking = YES;
    NSArray *keys = @[ @"f7:18:b8:e2:44:6e:1a:07:9f:8d:d3:2e:1d:95:89:54" ];
    
    query = [DOQuery insertDropletWithConfiguration:^(DODropletConfiguration *configuration) {
      configuration.hostname = hostname;
      configuration.imageID = imageID;
      configuration.sizeSlug = sizeSlug;
      configuration.regionSlug = regionSlug;
      configuration.enableBackups = enableBackups;
      configuration.enableIPv6 = enableIPv6;
      configuration.enablePrivateNetworking = enablePrivateNetworking;
      configuration.sshKeys = keys;
      config = configuration;
    }];
    
    it(@"should create a valid configuration", ^{
      [[config.attributes[@"name"] should] equal:hostname];
      [[config.attributes[@"image"] should] equal:@(imageID)];
      [[config.attributes[@"size"] should] equal:sizeSlug];
      [[config.attributes[@"region"] should] equal:regionSlug];
      [[config.attributes[@"backups"] should] equal:@(enableBackups)];
      [[config.attributes[@"ipv6"] should] equal:@(enableIPv6)];
      [[config.attributes[@"private_networking"] should] equal:@(enablePrivateNetworking)];
      [[config.attributes[@"ssh_keys"] should] equal:keys];
      [[config.attributes[@"user_data"] should] beNil];
    });
    
    it(@"should create a valid query", ^{
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DODroplet.class)];
      [[query.path should] equal:DOURL(@"droplets?region=lon1&ipv6=1&size=512mb&private_networking=1&ssh_keys=f7:18:b8:e2:44:6e:1a:07:9f:8d:d3:2e:1d:95:89:54&image=10322623&backups=1&name=shaps.me").absoluteString];
    });
    
  });
  
  context(@"Domain", ^{
    
    it(@"should create a valid query to create a new domain", ^{
      query = [DOQuery insertDomainNamed:@"shaps.me" ipAddress:@"10.0.0.0"];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DODomain.class)];
      [[query.path should] equal:DOURL(@"domains?name=shaps.me&ip_address=10.0.0.0").absoluteString];
    });
    
  });
  
  context(@"Domain Record", ^{
    
    it(@"should create a valid query to create a new record for a domain", ^{
      query = [DOQuery insertRecordForDomainNamed:@"shaps.me" attributes:DODomainRecordTypeA(@"@", @"10.0.0.0")];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DODomainRecord.class)];
      [[query.path should] equal:DOURL(@"domains/shaps.me/records?name=@&type=A&data=10.0.0.0").absoluteString];
    });
    
  });
  
  context(@"SSH Keys", ^{
    
    it(@"should create a valid query to create a new SSH Key", ^{
      NSString *key = @"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC680qx9VjT77l+OhPcb0CbRe3pw1jWa0UBLrcPM2T8Zxf+acIz7V3AowsCk5XHtsM1fKs0LH3bJqp9kTZoAwX3JOjGXE3JyXglRUcybS2ay059KP0ySorvXHfHUl1lwZvwGfeABqVtCKHrkJw4Q0etI8Xdf0F6WXyPlHyERWI1Iwzml1o1RtAkJ92OqkQKfps0VgxwYHxXcppf2IsqvDv9NMOVHp15G3/is3irP1JQj7BxXe6OvT3a2XWJZtaC55pJWhD787MgfOwuyGEe/Y8jD66OuycNA5yvCkKEZTcqvvuIFiFSHISoV2ahtUv7MQuB6rEoR6c2OZvljq6sBfc1 DO@DO-rMBP.local";
      
      query = [DOQuery insertSSHKeyNamed:@"My Key" publicKey:key];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOSSHKey.class)];
      [[query.path should] equal:DOURL(@"account/keys?name=My%20Key&public_key=ssh-rsa%20AAAAB3NzaC1yc2EAAAADAQABAAABAQC680qx9VjT77l+OhPcb0CbRe3pw1jWa0UBLrcPM2T8Zxf+acIz7V3AowsCk5XHtsM1fKs0LH3bJqp9kTZoAwX3JOjGXE3JyXglRUcybS2ay059KP0ySorvXHfHUl1lwZvwGfeABqVtCKHrkJw4Q0etI8Xdf0F6WXyPlHyERWI1Iwzml1o1RtAkJ92OqkQKfps0VgxwYHxXcppf2IsqvDv9NMOVHp15G3/is3irP1JQj7BxXe6OvT3a2XWJZtaC55pJWhD787MgfOwuyGEe/Y8jD66OuycNA5yvCkKEZTcqvvuIFiFSHISoV2ahtUv7MQuB6rEoR6c2OZvljq6sBfc1%20DO@DO-rMBP.local").absoluteString];
    });
    
  });

});

SPEC_END