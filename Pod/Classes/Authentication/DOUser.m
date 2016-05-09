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

#import "DOUser.h"
#import "SPXDefines.h"

@interface DOUser()

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *refreshToken;

@end

@implementation DOUser

- (instancetype)init
{
  SPXAssertTrueOrPerformAction(YES, NSLog(@"You must not call init directly on this object! Use one of the specified designated initializers"));
  return [self initWithAttributes:@{}];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [self initWithAttributes:@{ }];
  SPXDecode(email);
  SPXDecode(identifier);
  SPXDecode(authToken);
  SPXDecode(refreshToken);
  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  DOUser *user = [DOUser new];
  
  user->_authToken = self.authToken;
  user->_email = self.email;
  user->_identifier = self.identifier;
  user->_refreshToken = self.refreshToken;
  
  return user;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  SPXEncode(email);
  SPXEncode(identifier);
  SPXEncode(authToken);
  SPXEncode(refreshToken);
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
  self = [super init];
  SPXAssertTrueOrReturnNil(self);
  
  _authToken = attributes[@"access_token"];
  _refreshToken = attributes[@"refresh_token"];
  _identifier = attributes[@"info"][@"uuid"];
  _email = attributes[@"info"][@"email"];
  
  return self;
}

- (NSUInteger)hash
{
  return self.email.hash;
}

- (BOOL)isEqual:(DOUser *)object
{
  if (![object isKindOfClass:self.class]) {
    return NO;
  }

  if ([object.email isEqualToString:self.email]) {
    return YES;
  }
  
  return NO;
}

+ (BOOL)supportsSecureCoding
{
  return YES;
}

- (NSString *)description
{
  return SPXDescription(SPXKeyPath(identifier), SPXKeyPath(email));
}

@end