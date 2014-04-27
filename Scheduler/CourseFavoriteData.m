//
//  CourseFavoriteData.m
//  Scheduler
//
//  Created by student on 4/27/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseFavoriteData.h"

@interface CourseFavoriteData ()

@property NSMutableArray *courses;

@end

@implementation CourseFavoriteData


+(CourseFavoriteData *) sharedInstance
{
    static CourseFavoriteData *instance = nil;
    if (! instance) {
        instance = [[CourseFavoriteData alloc] init];
        [instance loadCourses];
    }
    return instance;
}

-(int) courseCount
{
    return [self.courses count];
}

-(Course *) courseAtIndex:(int) index
{
    return [self.courses objectAtIndex:index];
}
-(void) addCourse:(Course *) course
{
    if (![self isInCourses:course]) {
        [self.courses addObject:course];
        [self saveCourses];
        [self.delegate courseFavoriteDataUpdated];
    }
}
-(void) removeCourse:(Course *) course
{
    NSString *removeSubjectWithNumber = course.subjectWithNumber;
    for (Course* curCourse in self.courses) {
        if ([removeSubjectWithNumber isEqualToString:[curCourse subjectWithNumber]]) {
            [self.courses removeObject:curCourse];
            [self saveCourses];
            [self.delegate courseFavoriteDataUpdated];
            return;
        }
    }
}
        
-(BOOL) isInCourses:(Course *) course
{
    NSPredicate *subjectWithNumberMatch = [NSPredicate predicateWithFormat:@"subjectWithNumber == '%@'", course.subjectWithNumber];
    return [[self.courses filteredArrayUsingPredicate:subjectWithNumberMatch] count] > 0;
}

-(void) loadCourses
{
    self.courses = [NSMutableArray array];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *courseFile = [documentsDirectory stringByAppendingPathComponent:@"savedCourses.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:courseFile];
    
    if (jsonData) {
        NSArray *loadedCourseDicts = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        for (NSDictionary *courseDict in loadedCourseDicts) {
            [self.courses addObject:[[Course alloc] initWithDict:courseDict]];
        }
    }
}

-(void) saveCourses
{
    NSMutableArray *serializableCourses = [NSMutableArray array];
    for (Course *curCourse in self.courses) {
        [serializableCourses addObject:curCourse.courseDict];
    }
    if ([NSJSONSerialization isValidJSONObject:serializableCourses]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializableCourses options:kNilOptions error:nil];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *courseFile = [documentsDirectory stringByAppendingPathComponent:@"savedCourses.json"];
        [jsonData writeToFile:courseFile atomically:YES];
    }
    else {
        NSLog(@"Invalid JSON course array serialization!");
    }
}

@end
