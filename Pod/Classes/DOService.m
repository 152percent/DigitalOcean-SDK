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

#import "DOService.h"
#import "DOInternal.h"
#import "SPXDefines.h"
#import "DOEndpointConstants.h"
#import "NSString+DOAdditions.h"
#import "NSDictionary+DOAdditions.h"
#import "NSURLRequest+DOAdditions.h"

@interface DOMetaData (Private)
@property (nonatomic, strong) DOQuery *originalQuery;
@end

@interface DOService ()
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation DOService

- (instancetype)init
{
  SPXAssertTrueOrPerformAction(NO, NSLog(@"You must not call init directly on this object! Use one of the specified designated initializers"));
  return [self initWithToken:@"" delegate:nil];
}

#pragma mark - Lifecycle

+ (instancetype)serviceWithToken:(NSString *)token delegate:(id<DOServiceRequestHandler>)delegate
{
  return [[self alloc] initWithToken:token delegate:delegate];
}

- (instancetype)initWithToken:(NSString *)token delegate:(id<DOServiceRequestHandler>)delegate
{
  self = [super init];
  
  SPXAssertTrueOrReturnNil(self);
  SPXAssertTrueOrReturnNil(token);
  
  _authToken = token;
  _delegate = delegate;
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
  configuration.timeoutIntervalForRequest = 20;
  
  _session = [NSURLSession sessionWithConfiguration:configuration];
  
  return self;
}

#pragma mark - Request Preparation

- (NSURLRequest *)prepareRequestForQuery:(DOQuery *)query
{
  SPXAssertTrueOrReturnNil(query);
  SPXAssertTrueOrReturnNil(query.path);
  
  NSMutableURLRequest *request = query.URLRequest.mutableCopy;
  
  request.allHTTPHeaderFields = @
  {
    @"Content-Type" : @"application/json",
    @"Authorization" : [@"Bearer " stringByAppendingString:self.authToken],
  };
  
  return request;
}

#pragma mark - Perform Query

- (void)performQuery:(DOQuery *)query completion:(void (^)(id, DOMetaData *, NSError *))completion
{
  SPXAssertTrueOrReturn(query);
  SPXAssertTrueOrPerformAction(self.authToken, SPXLog(@"A valid authentication token must be provided before a query can be performed"); return);
  
  NSURLRequest *request = [self prepareRequestForQuery:query];
  SPXAssertTrueOrReturn(request);
  
  if ([self.delegate respondsToSelector:@selector(service:performRequest:completion:)]) {
    [self.delegate service:self performRequest:request completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      [self handleResponse:response data:data error:error query:query completion:completion];
    }];
    
    return;
  }
  
  // If no delegate was provided -- we'll do the networking automatically
  if (self.loggingLevel == DOServiceLoggingLevelVerbose) {
    SPXLog(@"%@ -> %@", request.HTTPMethod, request.URL);
  }
  
  if (self.loggingLevel == DOServiceLoggingLevelDebug) {
    SPXLog(@"%@ -> %@ -> %@", request.HTTPMethod, request.URL, request.do_curlRepresentation);
  }
  
  NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    [self handleResponse:response data:data error:error query:query completion:completion];
  }];
  
  [task resume];
}

#pragma mark - Response Handling

- (void)processQuery:(DOQuery *)query completion:(NSError *)error
{
  if (!error && (self.loggingLevel == DOServiceLoggingLevelDebug || self.loggingLevel == DOServiceLoggingLevelVerbose)) {
    if (self.loggingLevel == DOServiceLoggingLevelDebug) {
      SPXLog(@"%@ -> %@ -> %@", query.HTTPMethod, query.URLRequest.URL, query.URLRequest.do_curlRepresentation);
    } else {
      SPXLog(@"%@ -> %@", query.HTTPMethod, query.URLRequest.URL);
    }
    
    return;
  }
  
  switch (self.loggingLevel) {
    case DOServiceLoggingLevelDebug: {
      SPXLog(@"%@ -> %@ -> %@ -> %@ -- %@", query.HTTPMethod, query.URLRequest.URL, query.URLRequest.do_curlRepresentation, @(error.code), error.localizedDescription)
      break;
    }
    case DOServiceLoggingLevelNone: {
      // log nothing
      break;
    }
    default: {
      if (error) {
        SPXLog(@"%@ -> %@ -> %@ -- %@", query.HTTPMethod, query.URLRequest.URL, @(error.code), error.localizedDescription);
      }
      
      break;
    }
  }
}

- (void)handleResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error query:(DOQuery *)query completion:(void (^)(id, DOMetaData *, NSError *))completion
{
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
  DOMetaData *meta = nil;
  
  if (error) {
    meta = [self metaDataFromJSON:nil headers:httpResponse.allHeaderFields query:query];
    [self processQuery:query completion:error];
    !completion ?: completion(nil, meta, error);
    return;
  }
  
  NSError *internalError = nil;
  BOOL serverError = httpResponse.statusCode >= 500;
  id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&internalError];
  
  if (serverError) {
    NSString *domain = DOReverseDomain(NSStringFromClass(query.class));
    internalError = [NSError errorWithDomain:domain code:httpResponse.statusCode userInfo:@{ NSLocalizedDescriptionKey : json[@"message"] ?: @"The server did not respond" }];
    [self processQuery:query completion:internalError];
    !completion ?: completion(nil, nil, internalError);
    return;
  }
  
  if (error) {
    SPXLog(@"%@", error);
    meta = [self metaDataFromJSON:nil headers:httpResponse.allHeaderFields query:query];
    [self processQuery:query completion:internalError];
    !completion ?: completion(nil, meta, internalError);
    return;
  }
  
  if (httpResponse.statusCode == 401) {
    NSString *domain = DOReverseDomain(@"auth");
    internalError = [NSError errorWithDomain:domain code:httpResponse.statusCode userInfo:@{ NSLocalizedDescriptionKey : json[@"message"] }];
    [self processQuery:query completion:internalError];
    !completion ?: completion(nil, nil, internalError);
    return;
  }
  
  if (httpResponse.statusCode > 299) {
    NSString *domain = DOReverseDomain(NSStringFromClass(query.class));
    internalError = [NSError errorWithDomain:domain code:httpResponse.statusCode userInfo:@{ NSLocalizedDescriptionKey : json[@"message"] }];
    meta = [self metaDataFromJSON:json headers:httpResponse.allHeaderFields query:query];
    [self processQuery:query completion:internalError];
    !completion ?: completion(nil, meta, internalError);
    return;
  }
  
  id result = nil;
  NSString *key = [query.objectClass singularRepresentation];
  
  if (!json[key] && !json[[query.objectClass pluralRepresentation]]) {
    NSString *message = [NSString stringWithFormat:@"Unrecognized key: %@ for objectClass: %@", key, query.objectClass];
    SPXLog(@"%@", message);
  }
  
  if (key) {
    if (json[key]) {
      result = [self objectForObjectClass:query.objectClass source:json[key]];
    } else {
      key = [query.objectClass pluralRepresentation];
      result = [self objectsForObjectClass:query.objectClass source:json[key]];
    }
  } else {
    result = json;
  }
  
  meta = [self metaDataFromJSON:json headers:httpResponse.allHeaderFields query:query];
  
  if (query.pageIndex > meta.numberOfPages) {
    NSString *domain = DOReverseDomain(NSStringFromClass(query.class));
    internalError = [NSError errorWithDomain:domain code:DOErrorCodeInternalPageIndexExceededLimit userInfo:@{ NSLocalizedDescriptionKey : @"The pageIndex you specified is greater than numberOfPages. Check meta.numberOfPages to avoid this error" }];
    [self processQuery:query completion:internalError];
    !completion ?: completion(nil, meta, internalError);
    return;
  }
  
  [self processQuery:query completion:error];
  !completion ?: completion(result, meta, nil);
}

#pragma mark - Compiling Meta Data

- (DOMetaData *)metaDataFromJSON:(NSDictionary *)json headers:(NSDictionary *)headers query:(DOQuery *)query
{
  DOMetaData *meta = [DOMetaData new];
  meta.originalQuery = query;
  
  NSMutableDictionary *attributes = [NSMutableDictionary new];
  
  attributes[@"rate_limit_limit"] = headers[@"ratelimit-limit"];
  attributes[@"rate_limit_remaining"] = headers[@"ratelimit-remaining"];
  attributes[@"rate_limit_reset"] = headers[@"ratelimit-reset"];
  
  if (![json isKindOfClass:[NSDictionary class]]) {
    [meta updateAttributes:attributes];
    return meta;
  }
  
  if (json[@"links"]) {
    NSDictionary *pages = json[@"links"][@"pages"];
    
    if (pages) {
      if (pages[@"first"]) {
        attributes[@"first_page"] = pages[@"first"];
      }
      
      if (pages[@"last"]) {
        attributes[@"last_page"] = pages[@"last"];
      }
      
      if (pages[@"next"]) {
        attributes[@"next_page"] = pages[@"next"];
      }
      
      if (pages[@"prev"]) {
        attributes[@"previous_page"] = pages[@"prev"];
      }
    }
  }

  if (query.itemsPerPage) {
    attributes[@"items_per_page"] = @(query.itemsPerPage);
  }
  
  if (json[@"meta"][@"total"]) {
    attributes[@"total"] = json[@"meta"][@"total"];
    [meta updateAttributes:attributes];
  }
  
  return meta;
}

#pragma mark - Object Generation

- (NSArray *)objectsForObjectClass:(Class <DOObject>)objectClass source:(NSArray *)source
{
  NSMutableArray *objects = [NSMutableArray new];
  
  for (NSDictionary *attributes in source){
    id <DOObject> object = [self objectForObjectClass:objectClass source:attributes];
    
    if (!object) {
      SPXLog(@"Unable to create object for class: %@", objectClass);
      continue;
    }
    
    [objects addObject:object];
  }
  
  return objects.copy;
}

- (id <DOObject>)objectForObjectClass:(Class <DOObject>)objectClass source:(NSDictionary *)source
{
  id <DOObject> object = [objectClass.class new];

  SPXAssertTrueOrReturnNil([object conformsToProtocol:@protocol(DOObject)]);
  SPXAssertTrueOrReturnNil([object respondsToSelector:@selector(updateAttributes:)]);
  SPXAssertTrueOrReturnNil([object respondsToSelector:@selector(JSONRepresentation)]);
  SPXAssertTrueOrReturnNil([object respondsToSelector:@selector(boxedValue:forKey:)]);
  SPXAssertTrueOrReturnNil([object.class respondsToSelector:@selector(attributeNameForKey:)]);

  [object updateAttributes:source];
  return object;
}

@end