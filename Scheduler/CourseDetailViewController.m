//
//  CourseDetailViewController.m
//  Scheduler
//
//  Created by student on 4/21/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseSearchData.h"
#import "CourseCell.h"

@interface CourseDetailViewController ()

@property (nonatomic) Course *course;

@end

static NSString *CellIdentifier = @"Cell";

@implementation CourseDetailViewController

- (id)initWithCourse:(Course *)course {
    self = [super init];
    if (self) {
        self.course = course;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:CellIdentifier];
    
    [self setTitle:[self.course subjectWithNumber]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.course classCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)tableSection
{
    // Return the number of rows in the section.
    return [self.course sectionCountForClass:tableSection];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)tableSection
{
    return [self.course classDescriptionForClass:tableSection];
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Section *section = [self.course section:[indexPath row] ForClass:[indexPath section]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    [cell.textLabel setText:[section timeString]];
    
    NSString *detailString = [NSString stringWithFormat:@"%@, %@, %@", [section locations], [section professors], [section type]];
    
    [cell.detailTextLabel setText:detailString];
    
    return cell;
}

@end
