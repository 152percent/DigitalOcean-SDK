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

#import <Kiwi/Kiwi.h>
#import "NSDictionary+DOAdditions.h"


SPEC_BEGIN(NSDictionary_DOAdditionsSpec)

describe(@"NSDictionary_DOAdditions", ^{
  
  context(@"Query Parameters", ^{
    
    it(@"should pass or fail as expected", ^{
      NSDictionary *values = @
      {
        @{ @"key" : @"value" } : @"key=value",
        @{ @"key1" : @"value1", @"key2" : @"value2" } : @"key1=value1&key2=value2",
        @{ @"key 1" : @"£200" } : @"key%201=%C2%A3200",
      };
      
      for (NSDictionary *value in values.allKeys) {
        NSString *expected = values[value];
        NSString *params = [value do_queryParameters];
        [[params should] equal:expected];
      }
    });
    
  });

});

SPEC_END