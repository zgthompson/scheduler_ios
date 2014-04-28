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

        [self setTabBarItem:tabBarItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.navigationItem.title = @"Saved Courses";
    self.tabBarController.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    [cell.textLabel setText:[curCourse description]];
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

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course *courseToDelete = [self.courseFavoriteData courseAtIndex:[indexPath row]];
    [self.courseFavoriteData removeCourse:courseToDelete];
}


@end
