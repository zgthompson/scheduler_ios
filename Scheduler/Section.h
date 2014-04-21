//
//  Section.h
//  Scheduler
//
//  Created by student on 4/21/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

-(instancetype) initWithDict:(NSDictionary *) sectionDict;
-(NSString *) locations;
-(NSString *) professors;
-(NSString *) timeString;
-(NSString *) type;

@end
