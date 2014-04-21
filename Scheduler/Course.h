//
//  Course.h
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Section.h"

@interface Course : NSObject

-(instancetype) initWithDict:(NSDictionary *) courseDict;
-(NSString *) title;
-(NSString *) subjectWithNumber;
-(NSString *) units;
-(int) classCount;
-(int) sectionCountForClass:(int)classNum;
-(NSString *) classDescriptionForClass:(int)classNum;
-(Section *) section:(int)sectionNum ForClass:(int)classNum;

@end
