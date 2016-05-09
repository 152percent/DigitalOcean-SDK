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

#import "DOQuery+Private.h"
#import "SPXAssertionDefines.h"
#import "DOInternal.h"
#import "NSDictionary+DOAdditions.h"

@interface DOQuery (Internal)
@property (nonatomic, assign) Class <DOObject> objectClass;
@property (nonatomic, strong) NSDictionary *HTTPBody;
@property (nonatomic, strong) NSString *HTTPMethod;
@property (nonatomic, strong) NSString *path;

- (instancetype)initWithObjectClass:(Class <DOObject>)objectClass;
@end

@implementation DOQuery (Private)

+ (instancetype)fetchQueryForObjectClass:(Class<DOObject>)objectClass attributes:(NSDictionary *)attributes endpoint:(NSString *)endpoint params:(NSString *)params, ... NS_REQUIRES_NIL_TERMINATION
{
  va_list args;
  va_start(args, params);
  DOQuery *query = [self.class queryForObjectClass:objectClass attributes:attributes method:@"GET" endpoint:endpoint param:params args:args];
  va_end(args);
  return query;
}

+ (instancetype)updateQueryForObjectClass:(Class<DOObject>)objectClass attributes:(NSDictionary *)attributes endpoint:(NSString *)endpoint params:(NSString *)params, ... NS_REQUIRES_NIL_TERMINATION
{
  va_list args;
  va_start(args, params);
  DOQuery *query = [self.class queryForObjectClass:objectClass attributes:attributes method:@"PUT" endpoint:endpoint param:params args:args];
  va_end(args);
  return query;
}

+ (instancetype)insertQueryForObjectClass:(Class<DOObject>)objectClass attributes:(NSDictionary *)attributes endpoint:(NSString *)endpoint params:(NSString *)params, ... NS_REQUIRES_NIL_TERMINATION
{
  va_list args;
  va_start(args, params);
  DOQuery *query = [self.class queryForObjectClass:objectClass attributes:attributes method:@"POST" endpoint:endpoint param:params args:args];
  va_end(args);
  return query;
}

+ (instancetype)deleteQueryForEndpoint:(NSString *)endpoint params:(NSString *)params, ... NS_REQUIRES_NIL_TERMINATION
{
  va_list args;
  va_start(args, params);
  DOQuery *query = [self.class queryForObjectClass:nil attributes:nil method:@"DELETE" endpoint:endpoint param:params args:args];
  va_end(args);
  return query;
}

+ (instancetype)actionQueryForObjectClass:(Class<DOObject>)objectClass attributes:(NSDictionary *)attributes endpoint:(NSString *)endpoint params:(NSString *)params, ... NS_REQUIRES_NIL_TERMINATION
{
  va_list args;
  va_start(args, params);
  DOQuery *query = [self.class queryForObjectClass:objectClass attributes:attributes method:@"POST" endpoint:endpoint param:params args:args];
  va_end(args);
  return query;
}

#pragma mark - Internal Helpers

+ (instancetype)queryForObjectClass:(Class <DOObject>)objectClass attributes:(NSDictionary *)attributes method:(NSString *)method endpoint:(NSString *)endpoint param:(NSString *)param args:(va_list)args
{
  SPXAssertTrueOrReturnNil(endpoint.length);
  SPXAssertTrueOrReturnNil([NSURL URLWithString:endpoint]);
  
  NSMutableArray *arguments = [NSMutableArray new];
  
  while (param != nil) {
    [arguments addObject:param];
    param = va_arg(args, NSString *);
  }
  
  // the number of arguments passed should be the same number of expected arguments in the endpoint
  NSUInteger numberOfExpectedArguments = [endpoint componentsSeparatedByString:@"/:"].count - 1;
  NSAssert((arguments.count == numberOfExpectedArguments), @"\n\nNumber of expected arguments: %zd\nNumber of arguments given: %zd\n", numberOfExpectedArguments, arguments.count);
  
  NSArray *components = [endpoint componentsSeparatedByString:@"/"];
  NSMutableArray *pathComponents = [NSMutableArray new];
  NSUInteger index = 0;
  
  for (NSString *comp in components) {
    if ([comp hasPrefix:@":"]) {
      [pathComponents addObject:arguments[index]];
      index++;
    } else {
      [pathComponents addObject:comp];
    }
  }
  
  DOQuery *query = [[self.class alloc] initWithObjectClass:objectClass];
  NSString *path = DOURL([pathComponents componentsJoinedByString:@"/"]).absoluteString;
  NSString *parameters = attributes.do_queryParameters;
  
  if (parameters.length) {
    path = [path stringByAppendingFormat:@"?%@", parameters];
  }
  
  query.path = path;
  query.HTTPMethod = method;
  
  return query;
}

@end