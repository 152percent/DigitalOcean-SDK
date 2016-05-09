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

#import "NSString+DOAdditions.h"
#import "SPXDefines.h"

@implementation NSString (DOAdditions)

- (instancetype)do_singularRepresentationForClassWithPrefix:(NSString *)prefix
{
  NSMutableString *rep = self.mutableCopy;
  
  if ([self hasPrefix:prefix]) {
    [rep replaceCharactersInRange:NSMakeRange(0, prefix.length) withString:@""];
  }
  
  return [rep do_JSONKeyRepresentation];
}

- (instancetype)do_pluralRepresentationForClassWithPrefix:(NSString *)prefix
{
  return [[self do_singularRepresentationForClassWithPrefix:prefix] stringByAppendingString:@"s"];
}

- (instancetype)do_JSONKeyRepresentation
{
  return [self stringByReplacingCamelCaseWithSeparator:@"_"].lowercaseString;
}

- (NSDictionary *)do_queryParameters
{
  NSArray *pathComponents = [self componentsSeparatedByString:@"?"];
  
  NSArray *paramComponents = [[pathComponents lastObject] componentsSeparatedByString:@"&"];
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  for (NSString *param in paramComponents) {
    NSArray *keyValue = [param componentsSeparatedByString:@"="];
    
    if (keyValue.count != 2) {
      continue;
    }
    
    parameters[[keyValue[0] stringByRemovingPercentEncoding]] = [keyValue[1] stringByRemovingPercentEncoding];
  }
  
  return parameters.copy;
}

#pragma mark - Internal Helpers

- (instancetype)stringByDeletingPrefix:(NSString *)prefix
{
  return [self stringByReplacingCharactersInRange:NSMakeRange(0, prefix.length) withString:@""];
}

- (NSMutableString *)camelCaseStringByReplacingSeparator:(NSString *)separator
{
  NSMutableString *rep = [NSMutableString new];
  NSArray *components = [self componentsSeparatedByString:separator];
  
  for (int i = 0; i < components.count; i++) {
    NSString *comp = components[i];
    
    if (i == 0) {
      [rep appendString:comp.lowercaseString];
    } else {
      [rep appendString:comp.capitalizedString];
    }
  }
  
  return rep;
}

- (NSMutableString *)stringByReplacingCamelCaseWithSeparator:(NSString *)separator
{
  NSMutableString *rep = [NSMutableString new];
  
  for (int i = 0; i < self.length; i++){
    NSString *ch = [self substringWithRange:NSMakeRange(i, 1)];
    NSString *nextChar = (i < self.length - 1) ? [self substringWithRange:NSMakeRange(i + 1, 1)] : nil;
    
    BOOL chIsUppercase = [ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound;
    BOOL nextCharIsLowercase = [nextChar rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]].location != NSNotFound;
    if (chIsUppercase && nextCharIsLowercase && i > 0) {
      [rep appendString:separator];
    }
    
    [rep appendString:ch];
  }
  
  return rep;
}

@end