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

#import "DOMetaData.h"
#import "DOQuery.h"
#import "NSString+DOAdditions.h"
#import "SPXDefines.h"

@interface DOQuery (Private)
@property (nonatomic, strong) NSString *path;
@end

@interface DOMetaData ()
@property (nonatomic, strong) DOQuery *originalQuery;
@end

@implementation DOMetaData

@dynamic total;
@dynamic rateLimitLimit;
@dynamic rateLimitRemaining;
@dynamic rateLimitReset;
@dynamic nextPage;
@dynamic previousPage;
@dynamic firstPage;
@dynamic lastPage;
@dynamic itemsPerPage;

#pragma mark - Convenience Methods

- (DOQuery *)queryForPageURI:(NSString *)page
{
  DOQuery *query = self.originalQuery.copy;
  query.path = page;
  return query;
}

- (NSUInteger)pageForSelector:(SEL)selector
{
  NSString *key = [NSStringFromSelector(selector) do_JSONKeyRepresentation];
  NSString *pageURI = self.JSONRepresentation[key];
  NSNumber *page = [pageURI do_queryParameters][@"page"];
  return page.integerValue;
}

#pragma mark - Indexing

- (NSInteger)nextPageIndex
{
  return [self pageForSelector:@selector(nextPage)] ?: self.lastPageIndex;
}

- (NSInteger)previousPageIndex
{
  return [self pageForSelector:@selector(previousPage)] ?: self.firstPageIndex;
}

- (NSInteger)firstPageIndex
{
  return self.total ? 1 : -1;
}

- (NSInteger)lastPageIndex
{
  return self.numberOfPages ?: -1;
}

- (NSInteger)currentPageIndex
{  
  if (!self.total) {
    return -1;
  }
  
  if (self.nextPage) {
    return MIN(self.nextPageIndex - 1, self.lastPageIndex);
  }
  
  if (self.previousPage) {
    return MAX(self.previousPageIndex + 1, self.firstPageIndex);
  }
  
  return 1;
}

- (NSUInteger)numberOfPages
{
  return self.total ? ceil((float)self.total / (float)self.itemsPerPage) : 0;
}

#pragma mark - Boxing

- (id)boxedValue:(id)value forKey:(NSString *)key
{
  if ([key compare:@"page" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
    return [NSURL URLWithString:value];
  }
  
  return [super boxedValue:value forKey:key];
}

- (NSString *)description
{
  return self.JSONRepresentation.description;
}

@end