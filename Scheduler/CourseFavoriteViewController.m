//
//  CourseFavoriteViewController.m
//  Scheduler
//
//  Created by student on 4/27/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseFavoriteData.h"
#import "CourseFavoriteViewController.h"
#import "CourseDetailViewController.h"
#import "CourseCell.h"

@interface CourseFavoriteViewController ()

@property (atomic) CourseFavoriteData *courseFavoriteData;

@end

static NSString *CellIdentifier = @"Cell";

@implementation CourseFavoriteViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.courseFavoriteData = [CourseFavoriteData sharedInstance];
        [self.courseFavoriteData setDelegate:self];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2];
        [tabBarItem setTitle:@"Saved Courses"];
        [self setTabBarItem:tabBarItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Saved Courses"];
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    /*
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.tableView setTableHeaderView:headerView];
     */

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.courseFavoriteData courseCount];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)tableSection
{
    return @"Saved Courses";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Course *curCourse = [self.courseFavoriteData courseAtIndex:[indexPath row]];
    
    [cell.textLabel setText:[curCourse subjectWithNumber]];
    [cell.detailTextLabel setText:[curCourse title]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course *course = [self.courseFavoriteData courseAtIndex:[indexPath row]];
    CourseDetailViewController *courseDetail = [[CourseDetailViewController alloc] initWithCourse:course];
    [self.navigationController pushViewController:courseDetail animated:YES];
}

-(void) courseFavoriteDataUpdated
{
    [self.tableView reloadData];
}


@end
