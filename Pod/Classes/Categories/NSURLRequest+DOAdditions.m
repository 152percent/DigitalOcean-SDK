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

#import "NSURLRequest+DOAdditions.h"

static NSString *DOCurlRequestDumpHeader = @"--dump-header";
static NSString *DOCurlRequestMethodFlag = @"-X";

static NSString *DOCurlRequestHeaderFormat = @" -H \"%@: %@\"";
static NSString *DOCurlRequestBodyFormat = @" -d \"%@\"";
static NSString *DOCurlRequestURLFormat = @" \"%@\"";

@implementation NSURLRequest (DOAdditions)

- (NSString *)do_curlRepresentation
{
  NSMutableString *curlString = [NSMutableString stringWithFormat:@"\ncurl %@ %@ %@ -", DOCurlRequestMethodFlag, self.HTTPMethod, DOCurlRequestDumpHeader];
  
  [self.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop) {
    NSString *headerKey = [self do_escapeQuotesInString:key];
    NSString *headerValue = [self do_escapeQuotesInString:val];
    
    [curlString appendFormat:DOCurlRequestHeaderFormat, headerKey, headerValue];
  }];
  
  NSString *bodyString = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
  
  if (bodyString.length) {
    bodyString = [self do_escapeQuotesInString:bodyString];
    [curlString appendFormat:DOCurlRequestBodyFormat, bodyString];
  }
  
  [curlString appendFormat:DOCurlRequestURLFormat, self.URL.absoluteString];
  
  return curlString;
}

- (NSString *)do_escapeQuotesInString:(NSString *)string
{
  return [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

@end