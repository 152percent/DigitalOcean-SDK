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
#import "NSDate+DOAdditions.h"


SPEC_BEGIN(NSDate_DOAdditionsSpec)

describe(@"NSDate_DOAdditions", ^{
  
  context(@"NSDate parsing", ^{
    
    it(@"should return a valid NSDate", ^{
      [[[NSDate do_dateFromISO8601String:@"2014-11-14T16:29:21Z"] shouldNot] beNil];
    });
    
    it(@"should have the correct values", ^{
      NSDate *date = [NSDate do_dateFromISO8601String:@"2014-11-14T16:29:21Z"];
      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
      
      NSCalendarUnit units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
      NSDateComponents *components = [calendar components:units fromDate:date];
      
      [[theValue(components.year) should] equal:theValue(2014)];
      [[theValue(components.month) should] equal:theValue(11)];
      [[theValue(components.day) should] equal:theValue(14)];
      [[theValue(components.hour) should] equal:theValue(16)];
      [[theValue(components.minute) should] equal:theValue(29)];
      [[theValue(components.second) should] equal:theValue(21)];
    });
    
  });
  
});

SPEC_END