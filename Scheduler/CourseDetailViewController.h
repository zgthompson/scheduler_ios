//
//  CourseDetailViewController.h
//  Scheduler
//
//  Created by student on 4/21/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseDetailViewController : UITableViewController

- (id)initWithCourse:(Course *)course andStyle:(UITableViewStyle)style;

@end
