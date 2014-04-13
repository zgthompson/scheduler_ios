//
//  Meteor.h
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseSearchData.h"

@interface Meteor : NSObject

+(Meteor *) sharedInstance;
-(void) connectToURLAtString:(NSString *) url;
-(void) updateCourseSearchData:(CourseSearchData *) courseSearchData WithCoursesFromQuery:(NSString* ) query;

@end
