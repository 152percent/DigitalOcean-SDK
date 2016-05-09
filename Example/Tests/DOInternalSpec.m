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
#import "DOInternal.h"

typedef NS_OPTIONS(NSInteger, MyOptions)
{
  MyOptionOne,
  MyOptionTwo,
};

SPEC_BEGIN(DOInternalSpec)

describe(@"DOInternal", ^{
  
  context(@"URL Construction", ^{
    
    it(@"should should return a fully qualifier URL", ^{
      NSURL *baseURL = [NSURL URLWithString:@"https://api.digitalocean.com/v2/"];
      [[DOURL(@"droplets") should] equal:[NSURL URLWithString:@"droplets" relativeToURL:baseURL]];
    });
    
    it(@"should fail for an invalid path", ^{
      [[DOURL(@"droplets here") should] beNil];
    });
    
  });
  
  context(@"Reverse Domain Construction", ^{
    
    it(@"should return a reverse domain path", ^{
      [[DOReverseDomain(@"auth") should] equal:@"com.digitalocean.auth"];
    });
    
    it(@"should fallback to prefix only for an invalid path", ^{
      [[DOReverseDomain(@"auth error") should] equal:@"com.digitalocean"];
    });
    
  });

  context(@"Number Conversion", ^{
    
    it(@"should return a string representation of a number", ^{
      [[DONumberAsString(123214) should] equal:@"123214"];
    });
    
  });
  
  context(@"Object Encoding", ^{
    
    it(@"should return YES", ^{
      [[theValue(_DO_IS_OBJECT(@"")) should] beYes];
    });
    
    it(@"should return NO", ^{
      [[theValue(_DO_IS_OBJECT(0)) should] beNo];
    });
    
    it(@"should return NO", ^{
      [[theValue(_DO_IS_OBJECT(0.4)) should] beNo];
    });
    
    it(@"should return NO", ^{
      [[theValue(_DO_IS_OBJECT(YES)) should] beNo];
    });
    
    it(@"should return NO", ^{
      [[theValue(_DO_IS_OBJECT(2.f)) should] beNo];
    });
    
  });
  
  context(@"Enum Masking", ^{
    
    it(@"should return YES", ^{
      MyOptions options = MyOptionOne | MyOptionTwo;
      [[theValue(_DOMaskHasValue(options, MyOptionOne)) should] beYes];
      [[theValue(_DOMaskHasValue(options, MyOptionTwo)) should] beYes];
    });
    
    it(@"should return NO", ^{
      MyOptions options = MyOptionOne;
      [[theValue(_DOMaskHasValue(options, MyOptionOne)) should] beYes];
      [[theValue(_DOMaskHasValue(options, MyOptionTwo)) should] beNo];
    });
    
  });
  
});

SPEC_END