//
//  CourseSearchViewController.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "CourseSearchViewController.h"
#import "CourseDetailViewController.h"
#import "CourseSearchData.h"
#import "CourseFavoriteData.h"
#import "CourseCell.h"
#import "UIButtonWithIndexPath.h"
#import "Meteor.h"

@interface CourseSearchViewController ()

@property (nonatomic) CourseSearchData *courseSearchData;
@property (nonatomic) CourseFavoriteData *courseFavoriteData;

@end

static NSString *CellIdentifier = @"Cell";

@implementation CourseSearchViewController

-(id)init
{
    self = [super init];
    if (self) {
        self.courseSearchData = [CourseSearchData sharedInstance];
        [self.courseSearchData setDelegate:self];
        
        self.courseFavoriteData = [CourseFavoriteData sharedInstance];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
        [tabBarItem setTitle:@"Course Search"];
        [self setTabBarItem:tabBarItem];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.courseSearchData = [CourseSearchData sharedInstance];
        [self.courseSearchData setDelegate:self];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Course Search"];
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:CellIdentifier];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [searchBar setDelegate:self];
    [self.tableView setTableHeaderView:searchBar];
    
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
    return [self.courseSearchData filterCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.courseSearchData courseCountAtIndex:section];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // title is actually set in viewForHeaderInSection function
    return @"Section Header";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 66;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,66)];
    headerView.backgroundColor=[UIColor clearColor];
 
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, headerView.frame.size.width - 30, 66)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.numberOfLines = 0;
    titleLabel.text = [[self.courseSearchData filterAtIndex:section] description];
 
    [headerView addSubview:titleLabel];
 
    return headerView;
}

- (IBAction) favoriteClicked:(UIButtonWithIndexPath *) favoriteButton
{
    NSIndexPath *indexPath = favoriteButton.indexPath;
    Course* course = [self.courseSearchData courseNumber:[indexPath row] atIndex:[indexPath section]];
    if (favoriteButton.selected) {
        [self.courseFavoriteData removeCourse:course];
        favoriteButton.selected = NO;
    }
    else {
        [self.courseFavoriteData addCourse:course];
        favoriteButton.selected = YES;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Course *curCourse = [self.courseSearchData courseNumber:[indexPath row] atIndex:[indexPath section]];
    
    UIImage *blankImage = [UIImage imageNamed:@"blank.png"];
    
    [cell.imageView setImage:blankImage];

    [cell.textLabel setText:[curCourse subjectWithNumber]];
    [cell.detailTextLabel setText:[curCourse title]];
    
    UIImage *starImage = [UIImage imageNamed:@"star.png"];
    UIImage *emptyStarImage = [UIImage imageNamed:@"star_empty.png"];
    
    UIButtonWithIndexPath *favoriteButton = [[UIButtonWithIndexPath alloc] initWithFrame:CGRectMake(22, 8, 24, 24) andIndexPath:indexPath];
    
    [favoriteButton setImage:emptyStarImage forState:UIControlStateNormal];
    [favoriteButton setImage:starImage forState:UIControlStateSelected];
    [favoriteButton addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchDown];

    [cell addSubview:favoriteButton];
    


    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Search submission

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.courseSearchData coursesForQuery:[searchBar text]];
    [searchBar resignFirstResponder];
}

#pragma mark - Course Search Data Delegate methods

-(void) courseSearchDataUpdated
{
    [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course *course = [self.courseSearchData courseNumber:[indexPath row] atIndex:[indexPath section]];
    CourseDetailViewController *courseDetail = [[CourseDetailViewController alloc] initWithCourse:course];
    [self.navigationController pushViewController:courseDetail animated:YES];
}

@end
