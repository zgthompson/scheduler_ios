// Zachary Thompson
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
#import "Meteor.h"

@protocol CourseSearchDataDelegate;

@interface CourseSearchData : NSObject<MeteorCourseSearchDelegate>

@property (nonatomic) id<CourseSearchDataDelegate> delegate;

+(CourseSearchData *) sharedInstance;
-(Filter *) filterAtIndex: (int) index;
-(Course *) courseNumber: (int) number atIndex: (int) index;
-(int) filterCount;
-(int) courseCountAtIndex: (int) index;
-(void) coursesForQuery:(NSString *) query;

@end

@protocol CourseSearchDataDelegate<NSObject>

-(void) courseSearchDataUpdated;

@end