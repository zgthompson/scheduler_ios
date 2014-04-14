//
//  CourseSearchData.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseSearchData.h"

@interface CourseSearchData()

@property (nonatomic) NSArray *courses;
@property (nonatomic) NSArray *filters;
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
        self.courses = @[@[[[Course alloc] init]]];
        self.filters = @[[[Filter alloc] init]];
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

-(void) acceptCourseSearchResponse:(NSDictionary *)response
{
    [self updateWithDict:response];
    [self.delegate courseSearchDataUpdated];
}

-(void) updateWithDict: (NSDictionary *) dict
{
    return;
}

@end
