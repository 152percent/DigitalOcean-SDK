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
#import "SPXDefines.h"
#import "DOInternal.h"
#import "NSDictionary+DOAdditions.h"
#import "DOEndpointConstants.h"
#import "NSString+DOAdditions.h"

NSUInteger const DOQueryMaxItemsPerPage = 200;

@interface DOQuery ()

@property (nonatomic, assign) Class <DOObject> objectClass;
@property (nonatomic, strong) NSDictionary *HTTPBody;
@property (nonatomic, strong) NSString *HTTPMethod;
@property (nonatomic, strong) NSString *path;

@end

@implementation DOQuery

- (BOOL)isEqual:(DOQuery *)object
{
  if (![object isKindOfClass:[DOQuery class]]) {
    return NO;
  }
  
  return
  (self.objectClass == object.objectClass &&
  [self.HTTPMethod isEqualToString:object.HTTPMethod] &&
  [self.HTTPMethod isEqualToString:object.HTTPMethod] &&
  [self.path isEqualToString:object.path]);
}

- (NSUInteger)hash
{
  return NSStringFromClass(self.objectClass).hash + self.HTTPBody.hash + self.HTTPMethod.hash + self.path.hash;
}

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super init];
  SPXAssertTrueOrReturnNil(self);
  
  SPXDecode(objectClass);
  SPXDecode(HTTPBody);
  SPXDecode(HTTPMethod);
  SPXDecode(itemsPerPage);
  SPXDecode(path);
  
  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  DOQuery *query = [self.class new];
  
  query->_HTTPBody = self.HTTPBody;
  query->_HTTPMethod = self.HTTPMethod;
  query->_itemsPerPage = self.itemsPerPage;
  query->_objectClass = self.objectClass;
  query->_path = self.path;
  
  return query;
}

+ (BOOL)supportsSecureCoding
{
  return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  SPXEncode(objectClass);
  SPXEncode(HTTPMethod);
  SPXEncode(HTTPBody);
  SPXEncode(itemsPerPage);
  SPXEncode(path);
}

- (void)setItemsPerPage:(NSUInteger)itemsPerPage
{
  _itemsPerPage = MIN(itemsPerPage, DOQueryMaxItemsPerPage);
}

- (NSURLRequest *)URLRequest
{
  SPXAssertTrueOrReturnNil(self.path);
  
  NSString *path = self.path;
  NSMutableDictionary *params = [path do_queryParameters].mutableCopy;
  
  if (self.itemsPerPage) {
    params[@"per_page"] = @(self.itemsPerPage);
  }
  
  if (self.pageIndex) {
    params[@"page"] = @(self.pageIndex);
  }
  
  if (params.count) {
    NSRange range = [path rangeOfString:@"?"];
    
    if (range.location != NSNotFound) {
      path = [path substringWithRange:NSMakeRange(0, range.location)];
    }
    
    path = [path stringByAppendingFormat:@"?%@", [params do_queryParameters]];
  }
  
  NSURL *url = [NSURL URLWithString:path];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
  
  request.HTTPMethod = self.HTTPMethod ?: @"GET";
  return request;
}

#pragma mark - Lifecycle

- (instancetype)initWithObjectClass:(Class <DOObject>)objectClass
{
  self = [super init];
  _objectClass = objectClass;
  return self;
}

#pragma mark - Debugging

- (NSString *)description
{
  return SPXDescription(SPXKeyPath(path), SPXKeyPath(HTTPMethod), SPXKeyPath(objectClass), SPXKeyPath(itemsPerPage), SPXKeyPath(HTTPBody));
}

@end