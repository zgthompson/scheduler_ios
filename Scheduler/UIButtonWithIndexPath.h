//
//  UIButtonWithIndexPath.h
//  Scheduler
//
//  Created by student on 4/27/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonWithIndexPath : UIButton

@property (nonatomic) NSIndexPath *indexPath;

-(id)initWithFrame:(CGRect)frame andIndexPath:(NSIndexPath *)indexPath;

@end
