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
@property NSMutableDictionary *coursesDict;

@end

@implementation CourseFavoriteData


+(CourseFavoriteData *) sharedInstance
{
    static CourseFavoriteData *instance = nil;
    if (! instance) {
        instance = [[CourseFavoriteData alloc] init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.courses = [NSMutableArray array];
        self.coursesDict = [NSMutableDictionary dictionary];
        [self loadCourses];
    }
    return self;
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
    if (![self savedCoursesIncludesCourse:course]) {
        [self addNewCourse:course];
    }
}

-(void) addNewCourse:(Course *) course
{
    [self.courses addObject:course];
    [self.coursesDict setObject:course forKey:[course subjectWithNumber]];
    [self saveCourses];
    [self.delegate courseFavoriteDataUpdated];
}

-(void) removeCourse:(Course *) course
{
    Course *currentCourse = [self.coursesDict objectForKey:[course subjectWithNumber]];
    if (currentCourse) {
        [self removeCurrentCourse:currentCourse];
    }
}

-(void) removeCurrentCourse:(Course *) course
{
    [self.courses removeObject:course];
    [self.coursesDict removeObjectForKey:[course subjectWithNumber]];
    [self saveCourses];
    [self.delegate courseFavoriteDataUpdated];
}

-(BOOL) savedCoursesIncludesCourse:(Course *) course
{
    //NSLog(@"includes course? %@", [course subjectWithNumber]);
    //NSLog(@"%@", [self.coursesDict objectForKey:[course subjectWithNumber]]);
    return !![self.coursesDict objectForKey:[course subjectWithNumber]];
}

-(void) loadCourses
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *courseFile = [documentsDirectory stringByAppendingPathComponent:@"savedCourses.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:courseFile];
    
    if (jsonData) {
        NSArray *loadedCourseDicts = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        for (NSDictionary *courseDict in loadedCourseDicts) {
            Course *newCourse = [[Course alloc] initWithDict:courseDict];
            [self.courses addObject:newCourse];
            [self.coursesDict setObject:newCourse forKey:[newCourse subjectWithNumber]];
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
