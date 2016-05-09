# DigitalOcean

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

- iOS 7.1+
- OSX 10.9+

## Examples

**Patterns**

Importing this class will bring in all the necessary classes you need to access the Digital Ocean API

To get started you need to configure an instance of the service:

```objc
DOService *service = [DOService serviceWithToken:$TOKEN delegate:nil]];
```

If no delegate is assigned, a default NSURLSession will be used for all networking automatically.
Although useful during early development and testing, it is recommended you use your own network stack for a release.

**Service**

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


QUERY TYPES
-----------


There are various query object types to choose from, they are separated and named for clarity:

```objc
DOQuery+Fetches
DOQuery+Actions
DOQuery+Inserts
DOQuery+Updates
DOQuery+Deletes
```

Each of these classes provides access to all documented Digital Ocean API's -- however there may be times when you new API becomes available and you need access to it. 
In this case, you can use DOQuery directly -- refer to the above implementation for usage.


FURTHER DOCUMENTATION
-----

For further documentation you can refer to the Header documentation as well as the included unit tests and example projects.

## Installation

DigitalOcean is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DigitalOcean-SDK"
```

## Author

Shaps (@shaps)

## License

DigitalOcean is available under the MIT license. See the LICENSE file for more info.
