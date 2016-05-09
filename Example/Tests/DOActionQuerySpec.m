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
#import "DOInternal.h"
#import "DOEndpointConstants.h"

SPEC_BEGIN(DOActionQuerySpec)

describe(@"DOQuery", ^{

  __block DOQuery *query = nil;
  
  context(@"Droplets", ^{
    
    it(@"should create a valid query for a soft power off", ^{
      query = [DOQuery softPowerOffDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=shutdown").absoluteString];
    });
    
    it(@"should create a valid query for a hard power off", ^{
      query = [DOQuery hardPowerOffDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=power_off").absoluteString];
    });
    
    it(@"should create a valid query for a soft reboot", ^{
      query = [DOQuery softRebootDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=reboot").absoluteString];
    });
    
    it(@"should create a valid query for a hard reboot", ^{
      query = [DOQuery hardRebootDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=power_cycle").absoluteString];
    });
    
    it(@"should create a valid query for a power on", ^{
      query = [DOQuery powerOnDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=power_on").absoluteString];
    });
    
    it(@"should create a valid query for a droplet upgrade", ^{
      query = [DOQuery upgradeDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=upgrade").absoluteString];
    });
    
    it(@"should create a valid query for a droplet resize", ^{
      query = [DOQuery resizeDropletWithID:12345 toSizeSlug:@"1gb" increaseDiskPermanently:YES];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=resize&size=1gb&disk=1").absoluteString];
    });
    
    it(@"should create a valid query for a droplet rebuild", ^{
      query = [DOQuery rebuildDropletWithID:12345 withImageWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=rebuild&image=12345").absoluteString];
    });
    
    it(@"should create a valid query for a password reset", ^{
      query = [DOQuery resetPasswordForDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=password_reset").absoluteString];
    });
    
    it(@"should create a valid query for a droplet rename", ^{
      query = [DOQuery renameDropletWithID:12345 name:@"shaps.me"];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=rename&name=shaps.me").absoluteString];
    });
    
    it(@"should create a valid query for a droplet kernel update", ^{
      query = [DOQuery updateKernelForDropletWithID:12345 kernelID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=change_kernel&kernel=12345").absoluteString];
    });
    
    it(@"should create a valid query for disabling droplet backups", ^{
      query = [DOQuery disableBackupsForDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=disable_backups").absoluteString];
    });
    
    it(@"should create a valid query for restoring a backup", ^{
      query = [DOQuery restoreBackupForDropletWithID:12345 imageID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=restore&image=12345").absoluteString];
    });
    
    it(@"should create a valid query for enabling IPv6", ^{
      query = [DOQuery enableIPV6ForDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=enable_ipv6").absoluteString];
    });
    
    it(@"should create a valid query for enabling private networking", ^{
      query = [DOQuery enablePrivateNetworkingForDropletWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=enable_private_networking").absoluteString];
    });
    
    it(@"should create a valid query for creating a snapshot", ^{
      query = [DOQuery createSnapshotForDropletWithID:12345 name:@"New Snapshot"];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"droplets/12345/actions?type=snapshot&name=New%20Snapshot").absoluteString];
    });
    
  });
  
  context(@"Images", ^{
    
    it(@"should create a valid query for converting a backup to a snapshot", ^{
      query = [DOQuery convertBackupToSnapshotForImageWithID:12345];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"images/12345/actions?type=convert").absoluteString];
    });
    
    it(@"should create a valid query for transferring an image between regions", ^{
      query = [DOQuery transferImageWithID:12345 toRegionSlug:@"lon1"];
      [[query.HTTPMethod should] equal:@"POST"];
      [[theValue(query.objectClass) should] equal:theValue(DOAction.class)];
      [[query.path should] equal:DOURL(@"images/12345/actions?type=transfer&region=lon1").absoluteString];
    });
    
  });

  
});

SPEC_END