//
//  Meteor.h
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MeteorCourseSearchDelegate;

@interface Meteor : NSObject

@property (nonatomic) id<MeteorCourseSearchDelegate> delegate;

+(Meteor *) sharedInstance;
-(void) connect;
-(void) coursesForQuery:(NSString* ) query;

@end

@protocol MeteorCourseSearchDelegate<NSObject>

-(void) acceptCourseSearchResults:(NSDictionary *) response;

@end
