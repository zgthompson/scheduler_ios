//
//  CourseSearchData.h
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
#import "Filter.h"

@interface CourseSearchData : NSObject

-(void) updateWithDict: (NSDictionary *) dict;
-(Filter *) filterAtIndex: (int) index;
-(Course *) courseNumber: (int) number atIndex: (int) index;
-(int) filterCount;
-(int) courseCountAtIndex: (int) index;


@end
