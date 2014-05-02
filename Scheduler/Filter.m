// Zachary Thompson
//
//  Filter.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "Filter.h"

@interface Filter()

@property (nonatomic) NSDictionary *filterDict;

@end

@implementation Filter

-(instancetype) initWithDict:(NSDictionary *)filterDict
{
    self = [super init];
        
    if (self) {
        self.filterDict = filterDict;
    }
    
    return self;
}

-(NSString *) description
{
    NSMutableArray *stringBuilder = [NSMutableArray array];
    for (id key in self.filterDict) {
        NSString *filterString = [[NSString alloc] initWithFormat:@"%@: %@", key, [self.filterDict objectForKey:key]];
        [stringBuilder addObject:filterString];
    }
    return [stringBuilder componentsJoinedByString:@", "];
}

@end
