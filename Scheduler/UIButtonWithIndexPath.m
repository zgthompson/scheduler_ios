//
//  UIButtonWithIndexPath.m
//  Scheduler
//
//  Created by student on 4/27/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "UIButtonWithIndexPath.h"

@implementation UIButtonWithIndexPath

-(id)initWithFrame:(CGRect)frame andIndexPath:(NSIndexPath *)indexPath
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indexPath = indexPath;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
