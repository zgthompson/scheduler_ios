// Zachary Thompson
//
//  CourseSearchViewController.h
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseSearchData.h"
#import "RoundedGroupedTableViewController.h"

@interface CourseSearchViewController :  RoundedGroupedTableViewController<UISearchBarDelegate, CourseSearchDataDelegate>

@end
