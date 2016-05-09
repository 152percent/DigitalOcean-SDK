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


#ifndef _DO_DEFINES_H
#define _DO_DEFINES_H


#ifndef DO_DESIGNATED_INITIALIZER
  #if __has_attribute(objc_designated_initializer)
    #define DO_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
  #else
    #define DO_DESIGNATED_INITIALIZER
  #endif
#endif

#ifndef DO_DEPRECATED
#define DO_DEPRECATED(msg) __attribute__((deprecated(msg)))
#endif

#ifndef DO_CONVENIENCE_INITIALIZER
  #define DO_CONVENIENCE_INITIALIZER
#endif


#endif