// Zachary Thompson
//
//  Section.m
//  Scheduler
//
//  Created by student on 4/21/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "Section.h"

@interface Section()

@property (nonatomic) NSDictionary *sectionDict;

@end

@implementation Section

-(instancetype) initWithDict:(NSDictionary *)sectionDict
{
    self = [super init];
    
    if (self) {
        self.sectionDict = sectionDict;
    }
    return self;
}

-(NSString *) locations
{
    return [[self.sectionDict objectForKey:@"locations"] componentsJoinedByString:@", "];
}

-(NSString *) professors
{
    return [[self.sectionDict objectForKey:@"professors"] componentsJoinedByString:@", "];
}

-(NSString *) type
{
    return [self.sectionDict objectForKey:@"type"];
}

-(NSString *) timeString
{
    NSMutableArray *stringBuilder = [NSMutableArray array];
    for (NSDictionary *timeDict in [self timeArray]) {
        [stringBuilder addObject:[self stringFromTimeDict:timeDict]];
    }
    return [stringBuilder componentsJoinedByString:@", "];
}

-(NSDictionary *) timeArray
{
    return [self.sectionDict objectForKey:@"times"];
}

-(NSString *) stringFromTimeDict:(NSDictionary *)timeDict
{
    NSString *days = [timeDict objectForKey:@"days"];
    NSString *startTime = [timeDict objectForKey:@"start_time"];
    NSString *endTime = [timeDict objectForKey:@"end_time"];
    return [NSString stringWithFormat:@"%@ %@ - %@", days, startTime, endTime];
}

@end
