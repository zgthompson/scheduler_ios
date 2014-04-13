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

@end

@implementation CourseSearchData

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        self.courses = @[@[[[Course alloc] init]]];
        self.filters = @[[[Filter alloc] init]];
    }
    
    return self;
}

-(void) updateWithDict: (NSDictionary *) dict
{
    return;
}

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

@end
