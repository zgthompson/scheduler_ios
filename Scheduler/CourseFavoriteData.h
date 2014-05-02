// Zachary Thompson
//
//  CourseFavoriteData.h
//  Scheduler
//
//  Created by student on 4/27/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@protocol CourseFavoriteDataDelegate;

@interface CourseFavoriteData : NSObject

@property (nonatomic) id<CourseFavoriteDataDelegate> delegate;

+(CourseFavoriteData *) sharedInstance;
-(int) courseCount;
-(Course *) courseAtIndex:(int) index;
-(void) addCourse:(Course *) course;
-(void) removeCourse:(Course *) course;
-(BOOL) savedCoursesIncludesCourse:(Course *) course;

@end

@protocol CourseFavoriteDataDelegate<NSObject>

-(void) courseFavoriteDataUpdated;

@end
