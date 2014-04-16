//
//  Course.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "Course.h"

@interface Course()

@property (nonatomic) NSDictionary *courseDict;

@end

@implementation Course

-(instancetype) initWithDict:(NSDictionary *)courseDict
{
    self = [super init];
    
    if (self) {
        self.courseDict = courseDict;
    }
    
    NSLog(@"%@", courseDict);
    
    return self;
}

-(NSString *) title
{
    return [self.courseDict objectForKey:@"title"];
}

-(NSString *) subjectWithNumber
{
    return [self.courseDict objectForKey:@"subject_with_number"];
}

-(NSString *) units
{
    return [self.courseDict objectForKey:@"units"];
}

@end
