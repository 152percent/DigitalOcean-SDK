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

#import "DOAuthenticationController.h"
#import "DOValidators.h"

#import "DOQuery+Actions.h"
#import "DOQuery+Deletes.h"
#import "DOQuery+Fetches.h"
#import "DOQuery+Inserts.h"
#import "DOQuery+Updates.h"

#import "DOAction.h"
#import "DODomain.h"
#import "DODomainRecord.h"
#import "DODroplet.h"
#import "DOImage.h"
#import "DOSSHKey.h"
#import "DORegion.h"
#import "DOSize.h"
#import "DOKernel.h"
#import "DOAccount.h"
#import "DOFloatingIP.h"


/*
 GETTING STARTED
 ---------------
 
 
 Importing this class will bring in all the necessary classes you need to access the Digital Ocean API
 
 To get started you need to configure an instance of the service:
 
    DOService *service = [DOService serviceWithToken:$TOKEN delegate:nil]];
 
 If no delegate is assigned, a default NSURLSession will be used for all networking automatically.
 Although useful during early development and testing, it is recommended you use your own network stack for a release.
 
 
 QUERIES
 -------
 
 
 The Digital Ocean SDK uses DOQuery objects to query the API and perform any associated actions. These queries are separated into various objects for fetch, insert, delete, update, and other actions.
 
 So, if you wanted to fetch all Droplets associated with your account you would call the following code:
 
     DOQuery *query = [DOFetchQuery fetchDroplets];
     [service performQuery:query completion:^(NSArray *results, DOMetaData *meta, NSError *error) {
        NSLog(@"%@", results);
     }];
 
 Instead of the original NSData and NSURLResponse being returned, we now have a more 'object representation' of the response.
 'results' will contain an array of DODroplet instances.
 'meta' will contain various information such as rate-limit info, pagination, etc...
 'error' will contain any associated errors -- note: an error will always be returned when necessary, even if the associated response didn't return one -- this is for consistency

 
 QUERY TYPES
 -----------
 
 
 There are various query object types to choose from, they are separated and named for clarity:
 
      DOQuery+Fetches
      DOQuery+Actions
      DOQuery+Inserts
      DOQuery+Updates
      DOQuery+Deletes
 
 Each of these classes provides access to all documented Digital Ocean API's -- however there may be times when you new API becomes available and you need access to it. 
 In this case, you can use DOQuery directly -- refer to the above implementation for usage.
 
 
 FURTHER DOCUMENTATION
 -----
 
 For further documentation you can refer to the Header documentation as well as the included unit tests and example project.
 
 */