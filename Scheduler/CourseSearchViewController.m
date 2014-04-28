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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:CellIdentifier];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [searchBar setDelegate:self];
    [self.tableView setTableHeaderView:searchBar];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    [self setTabBarItem:tabBarItem];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.navigationItem.title = @"Search Courses";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // title is actually set in viewForHeaderInSection function
    return @"Section Header";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width - 20, 0)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.numberOfLines = 0;
    titleLabel.text = [[self.courseSearchData filterAtIndex:section] description];
    [titleLabel sizeToFit];
    
    return titleLabel.frame.size.height + 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,tableView.frame.size.width - 20, 0)];
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = [[self.courseSearchData filterAtIndex:section] description];
    [titleLabel sizeToFit];
    CGRect textSize = titleLabel.frame;
    titleLabel.bounds = textSize;
    titleLabel.frame = CGRectOffset(textSize, 0, 5);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectOffset(textSize, 0, 10)];
    headerView.backgroundColor = [UIColor clearColor];
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

    [cell.textLabel setText:[curCourse description]];
    [cell.detailTextLabel setText:[curCourse title]];
    
    UIImage *starImage = [UIImage imageNamed:@"star.png"];
    UIImage *emptyStarImage = [UIImage imageNamed:@"star_empty.png"];
    
    UIButtonWithIndexPath *favoriteButton = [[UIButtonWithIndexPath alloc] initWithFrame:CGRectMake(22, 8, 24, 24) andIndexPath:indexPath];
    
    [favoriteButton setImage:emptyStarImage forState:UIControlStateNormal];
    [favoriteButton setImage:starImage forState:UIControlStateSelected];
    [favoriteButton addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchDown];

    [cell addSubview:favoriteButton];
    
    if ([self.courseFavoriteData savedCoursesIncludesCourse:curCourse]) {
        favoriteButton.selected = YES;
    }
    


    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Search submission / keyboard hiding

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.courseSearchData coursesForQuery:[searchBar text]];
    [searchBar resignFirstResponder];
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
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
