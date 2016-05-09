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

#import "DOObject.h"

@class DOQuery;

/**
 *  Change lastPage, firstPage, etc... to represent the page numbers
 *  Add lastPathURI, firstPageURI, etc... to represent the URIs
 *  Add currentPage for convenience
 */


/**
 *  Defines the 'meta-data' associated with a response
 */
@interface DOMetaData : DOObject


/**
 *  Returns the total number of results
 */
@property (nonatomic, readonly) NSUInteger total;


/**
 *  Returns the number of results per page
 */
@property (nonatomic, readonly) NSUInteger itemsPerPage;


/**
 *  Returns the total number of requests allowed per hour
 */
@property (nonatomic, readonly) NSUInteger rateLimitLimit;


/**
 *  Returns the number of remaining requests allowed before a request will be rejected
 */
@property (nonatomic, readonly) double rateLimitRemaining;


/**
 *  Returns the number of seconds remaining until the oldest request is reset
 */
@property (nonatomic, readonly) double rateLimitReset;


/**
 *  Returns the URL path for the next page of results. May be nil
 */
@property (nonatomic, readonly, nullable) NSURL *nextPage;


/**
 *  Returns the URL path for the previous page of results. May be nil
 */
@property (nonatomic, readonly, nullable) NSURL *previousPage;


/**
 *  Returns the URL path for the first page of results. May be nil
 */
@property (nonatomic, readonly, nullable) NSURL *firstPage;


/**
 *  Returns the URL path for the last page of results. May be nil
 */
@property (nonatomic, readonly, nullable) NSURL *lastPage;


/**
 *  When pagination is available you can use this convience method to get a new query for the associated page
 *
 *  @param page The page URL (e.g. nextPage, prevPage, etc...)
 *
 *  @return A copy of the current query with its URL updated
 */
- (nonnull DOQuery *)queryForPageURI:(nonnull NSURL *)page;


#pragma mark - Convenience Indexing


/**
 *  Returns the index of the next page. Returns -1 if no page exists
 */
@property (nonatomic, readonly) NSInteger nextPageIndex;


/**
 *  Returns the index of the previous page. Returns -1 if no page exists
 */
@property (nonatomic, readonly) NSInteger previousPageIndex;


/**
 *  Returns the index of the first page. Returns -1 if no results were returned
 */
@property (nonatomic, readonly) NSInteger firstPageIndex;


/**
 *  Returns the index of the last page. Returns -1 if no results were returned
 */
@property (nonatomic, readonly) NSInteger lastPageIndex;


/**
 *  Returns the index of the current page. Returns -1 if no results were returned or the pageIndex specified on the query was invalid
 */
@property (nonatomic, readonly) NSInteger currentPageIndex;


/**
 *  Returns the total number of pages
 */
@property (nonatomic, readonly) NSUInteger numberOfPages;


@end