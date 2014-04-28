//
//  Course.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "Course.h"

@implementation Course

-(instancetype) initWithDict:(NSDictionary *)courseDict
{
    self = [super init];
    
    if (self) {
        self.courseDict = courseDict;
    }
    
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

-(NSString *) geCode
{
    return [self.courseDict objectForKey:@"ge_code"];
}

-(NSString *) description
{
    NSString *geCodeString = [self geCode];
    
    if ([geCodeString length] > 0) {
        NSArray *stringBuilder = @[@" ", @"(", geCodeString, @")"];
        return [[self subjectWithNumber] stringByAppendingString:[stringBuilder componentsJoinedByString:@""]];
    }
    else {
        return [self subjectWithNumber];
    }
}

-(int) classCount
{
    return [[self.courseDict objectForKey:@"classes"] count];
}
-(int) sectionCountForClass:(int)classNum
{
    NSDictionary *classDict = [[self.courseDict objectForKey:@"classes"] objectAtIndex:classNum];
    return [[classDict objectForKey:@"sections"] count];
}
-(NSString *) classDescriptionForClass:(int)classNum
{
    NSDictionary *classDict = [[self.courseDict objectForKey:@"classes"] objectAtIndex:classNum];
    return [NSString stringWithFormat:@"Section %@", [classDict objectForKey:@"number"]];
}
-(Section *) section:(int)sectionNum ForClass:(int)classNum
{
    NSDictionary *classDict = [[self.courseDict objectForKey:@"classes"] objectAtIndex:classNum];
    NSDictionary *sectionDict = [[classDict objectForKey:@"sections"] objectAtIndex:sectionNum];
    return [[Section alloc] initWithDict:sectionDict];
}

@end
