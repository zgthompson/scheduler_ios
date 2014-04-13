//
//  Meteor.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "Meteor.h"
#import "ObjectiveDDP/MeteorClient.h"
#import "ObjectiveDDP/ObjectiveDDP.h"

@interface Meteor()

@property (nonatomic) MeteorClient *meteorClient;

@end

@implementation Meteor

+(Meteor *)sharedInstance
{
    static Meteor *instance = nil;
    if (! instance) {
        instance = [[Meteor alloc] init];
    }
    return instance;
}

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        self.meteorClient = [[MeteorClient alloc] init];
    }
    
    return self;
}

-(void) connectToURLAtString:(NSString *) url
{
    ObjectiveDDP *ddp = [[ObjectiveDDP alloc] initWithURLString:url delegate:self.meteorClient];
    self.meteorClient.ddp = ddp;
    [self.meteorClient.ddp connectWebSocket];
}

-(void) updateCourseSearchData:(CourseSearchData *) courseSearchData WithCoursesFromQuery:(NSString* ) query
{
    [self.meteorClient callMethodName:@"coursesForQuery" parameters:@[query] responseCallback:^(NSDictionary *response, NSError *error) {
        NSLog(@"%@", error);
        [courseSearchData updateWithDict:response];
    }];
}

@end
