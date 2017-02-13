# DigitalOcean iOS SDK (Unofficial)

[![CI Status](http://img.shields.io/travis/shaps80/DigitalOcean.svg?style=flat)](https://travis-ci.org/shaps80/DigitalOcean)
[![Version](https://img.shields.io/cocoapods/v/DigitalOcean.svg?style=flat)](http://cocoapods.org/pods/DigitalOcean)
[![License](https://img.shields.io/cocoapods/l/DigitalOcean.svg?style=flat)](http://cocoapods.org/pods/DigitalOcean)
[![Platform](https://img.shields.io/cocoapods/p/DigitalOcean.svg?style=flat)](http://cocoapods.org/pods/DigitalOcean)

## Disclaimer

This SDK is in no way affiliated with Digital Ocean, or their any of their development efforts. 

Although the SDK has been built specifically to work with Digital Ocean's public API, it has not been endorsed nor is it supported by Digital Ocean. 

I built this for my own purposes almost 3 years ago and am open sourcing it now, but have no plans to continue supporting or developing it. 

It is currently in use in production apps, and has many unit tests to keep it stable. It is considered a **v1.0** so please feel free to use it in your own apps.

## Platforms

This SDK is compatible with the following platforms & versions:

- iOS 7.0+
- OSX 10.9+

## Examples

**Services & Queries**

The SDK uses simple patterns -- paired with an object oriented design -- for integrating with the public Digital Ocean API.

In order to access an endpoint, the SDK provides access to various Queries. A query can then be processed through a Service.

- `DOService`
- `DOQuery`

Its recommended you create a single service, and reuse it throughout your applications lifecycle. However, its not enforced and you can choose to create multiple services if you prefer.

This is useful when you want to access multple accounts at the same time.

**Authentication**

In order to perform a query however, we need to pass a `authToken`. You can either generate a token through the Digital Ocean API section of their website, or use the SDK to perform login for you.

```swift
DOAuthenticationController *controller = [[DOAuthenticationController alloc] initWithDelegate:self clientID:$CLIENT_ID clientSecret:$CLIENT_SECRET redirectURI:$REDIRECT_URI];
  [self presentViewController:controller animated:YES completion:nil];
```

To get started you need to configure an instance of the service:

```swift
// Creates a new authenticated service
DOService *service = [DOService serviceWithToken:$TOKEN delegate:nil]];

// This method is called when authentication is successful
- (void)authenticationController:(DOAuthenticationController *)controller didAuthenticateWithUser:(DOUser *)user;
```

Passing nil for the delegate, forces the SDK to use a default NSURLSession for all networking. You can optionally provide your own delegate to override this behaviour. 

Note: Requests will still be generated automatically, including authentication headers.

**Queries**

The Digital Ocean SDK uses DOQuery objects to query the API and perform any associated actions. These queries are separated into various objects for fetch, insert, delete, update, and other actions.

So, if you wanted to fetch all Droplets associated with your account you would call the following code:

```objc
DOQuery *query = [DOQuery fetchDroplets];
[service performQuery:query completion:^(NSArray *results, DOMetaData *meta, NSError *error) {
  NSLog(@"%@", results);
}];
```

Instead of the original NSData and NSURLResponse being returned, we now have an `object representation` of the response.
`results` will contain an array of DODroplet instances.
`meta` will contain various information such as rate-limit info, pagination, etc...
`error` will contain any associated errors -- note: an error will always be returned when necessary, even if the associated response didn't return one -- this is for consistency

## Queries

**Actions**

```swift
+ (instancetype)softPowerOffDropletWithID:(NSUInteger)dropletID;
+ (instancetype)hardPowerOffDropletWithID:(NSUInteger)dropletID;
+ (instancetype)softRebootDropletWithID:(NSUInteger)dropletID;
+ (instancetype)hardRebootDropletWithID:(NSUInteger)dropletID;
+ (instancetype)powerOnDropletWithID:(NSUInteger)dropletID;
+ (instancetype)upgradeDropletWithID:(NSUInteger)dropletID;
+ (instancetype)resizeDropletWithID:(NSUInteger)dropletID toSizeSlug:(NSString *)sizeSlug increaseDiskPermanently:(BOOL)disk;
+ (instancetype)rebuildDropletWithID:(NSUInteger)dropletID withImageWithID:(NSUInteger)imageID;
+ (instancetype)resetPasswordForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)renameDropletWithID:(NSUInteger)dropletID name:(NSString *)name;
+ (instancetype)updateKernelForDropletWithID:(NSUInteger)dropletID kernelID:(NSUInteger)kernelID;
+ (instancetype)enableBackupsForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)disableBackupsForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)restoreBackupForDropletWithID:(NSUInteger)dropletID imageID:(NSUInteger)imageID;
+ (instancetype)enableIPV6ForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)enablePrivateNetworkingForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)createSnapshotForDropletWithID:(NSUInteger)dropletID name:(NSString *)name;
+ (instancetype)convertBackupToSnapshotForImageWithID:(NSUInteger)imageID;
+ (instancetype)transferImageWithID:(NSUInteger)imageID toRegionSlug:(NSString *)regionSlug;
+ (instancetype)assignFloatingIP:(NSString *)IPAddress toDropletWithID:(NSUInteger)dropletID;
+ (instancetype)unAssignFloatingIP:(NSString *)IPAddress;
+ (instancetype)reserveFloatingIPForRegionSlug:(NSString *)regionSlug;
```

**Fetches**

```swift
+ (instancetype)fetchAccount;
+ (instancetype)fetchRegions;
+ (instancetype)fetchSizes;
+ (instancetype)fetchScheduledUpgrades;
+ (instancetype)fetchNeighbors;
+ (instancetype)fetchNeighborsForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)fetchKernelsForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)fetchActions;
+ (instancetype)fetchActionsForDropletWithID:(NSUInteger)dropletID;
+ (instancetype)fetchActionsForImageWithID:(NSUInteger)imageID;
+ (instancetype)fetchActionWithID:(NSUInteger)actionID;
+ (instancetype)fetchDroplets;
+ (instancetype)fetchDropletWithID:(NSUInteger)dropletID;
+ (instancetype)fetchImages;
+ (instancetype)fetchImagesOfType:(DOImageFetchType)type;
+ (instancetype)fetchImageWithID:(NSUInteger)imageID;
+ (instancetype)fetchDomains;
+ (instancetype)fetchDomainNamed:(NSString *)name;
+ (instancetype)fetchRecordsForDomainNamed:(NSString *)name;
+ (instancetype)fetchRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID;
+ (instancetype)fetchSSHKeys;
+ (instancetype)fetchSSHKeyWithID:(NSUInteger)SSHKeyID;
+ (instancetype)fetchSSHKeyWithFingerprint:(NSString *)fingerprint;
+ (instancetype)fetchFloatingIPs;
+ (instancetype)fetchFloatingIP:(NSString *)IPAddress;
```

**Inserts**

```swift
+ (instancetype)insertDropletWithConfiguration:(void (^)(DODropletConfiguration * __configuration))configurationBlock;
+ (instancetype)insertDomainNamed:(NSString *)name ipAddress:(NSString *)ipAddress;
+ (instancetype)insertRecordForDomainNamed:(NSString *)name attributes:(NSDictionary *)attributes;
+ (instancetype)insertSSHKeyNamed:(NSString *)name publicKey:(NSString *)publicKey;
+ (instancetype)insertFloatingIPWithDropletID:(NSUInteger)dropletID;
+ (instancetype)insertFloatingIPWithRegionSlug:(NSString *)regionSlug;
```

**Updates**

```swift
+ (instancetype)updateRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID attributes:(NSDictionary *)attributes;
+ (instancetype)updateImageWithID:(NSUInteger)imageID withName:(NSString *)name;
+ (instancetype)updateSSHKeyWithID:(NSUInteger)SSHKeyID withName:(NSString *)name;
+ (instancetype)updateSSHKeyWithFingerprint:(NSString *)fingerprint withName:(NSString *)name;
```

**Deletes**

```swift
+ (instancetype)deleteDropletWithID:(NSUInteger)dropletID;
+ (instancetype)deleteImageWithID:(NSUInteger)imageID;
+ (instancetype)deleteDomainNamed:(NSString *)name;
+ (instancetype)deleteRecordForDomainNamed:(NSString *)name recordID:(NSUInteger)recordID;
+ (instancetype)deleteSSHKeyWithID:(NSUInteger)SSHKeyID;
+ (instancetype)deleteSSHKeyWithFingerprint:(NSString *)fingerprint;
+ (instancetype)deleteFloatingIP:(NSString *)IPAddress;
```


## Documentation

For further documentation you can refer to the Header documentation as well as the included unit tests and example projects.

## Installation

DigitalOcean is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DigitalOcean-SDK"
```

## Author

Shaps [@shaps](http://twiter.com/shaps)

## License

DigitalOcean is available under the MIT license. See the LICENSE file for more info.
