//
//  CourseSearchData.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseSearchData.h"

@interface CourseSearchData()

@property (nonatomic) NSMutableArray *courses;
@property (nonatomic) NSMutableArray *filters;
@property (nonatomic) Meteor *meteor;

@end

@implementation CourseSearchData

#pragma mark - Singleton methods

+(CourseSearchData *) sharedInstance
{
    static CourseSearchData *instance = nil;
    if (! instance) {
        instance = [[CourseSearchData alloc] init];
    }
    return instance;
}

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        self.courses = [NSMutableArray array];
        self.filters = [NSMutableArray array];
        self.meteor = [Meteor sharedInstance];
        [self.meteor setDelegate:self];
    }
    
    return self;
}

#pragma mark - Data access methods

-(Filter *) filterAtIndex:(int)index
{
    return [self.filters objectAtIndex:index];
}

-(Course *) courseNumber:(int)number atIndex:(int)index
{
    return [[self.courses objectAtIndex:index] objectAtIndex:number];
}

-(int) filterCount
{
    return [self.filters count];
}

-(int) courseCountAtIndex:(int)index
{
    return [[self.courses objectAtIndex:index] count];
}

#pragma mark - Meteor interactions

-(void) coursesForQuery:(NSString *)query
{
    [self.meteor coursesForQuery:query];
}

#pragma mark - Course Search Delegate Methods and helpers

-(void) acceptCourseSearchResults:(NSDictionary *)response
{
    [self resetFiltersAndCourses];
    
    for (NSDictionary *queryResult in response) {
        [self addFilterFromDict:[queryResult objectForKey:@"filter"]];
        [self addCourseArrayFromArray:[queryResult objectForKey:@"results"]];
    }
    
    [self.delegate courseSearchDataUpdated];
}

-(void) resetFiltersAndCourses
{
    self.filters = [NSMutableArray array];
    self.courses = [NSMutableArray array];
}

-(void) addFilterFromDict: (NSDictionary *) filterDict {
    [self.filters addObject:[[Filter alloc] initWithDict:filterDict]];
}

-(void) addCourseArrayFromArray: (NSArray *) courseArray {
    [self.courses addObject:@[ [[Course alloc] init] ]];
}


@end
