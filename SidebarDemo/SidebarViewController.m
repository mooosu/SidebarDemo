//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "PhotoViewController.h"
#import "SWRevealViewController.h"
#define CELL_HEIGHT             44.0f
#define SECTION_HEADER_HEIGHT   29.0f

@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation SidebarViewController

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        PhotoViewController *photoController = (PhotoViewController*)segue.destinationViewController;
        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [_menuItems objectAtIndex:indexPath.row]];
        photoController.photoFilename = photoFilename;
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
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
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor  = [UIColor colorWithWhite:0.15f alpha:0.2f];
    _menuItems = @[@"title", @"news", @"comments", @"map", @"calendar", @"wishlist", @"bookmark", @"tag"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_cell_bg.png"]];
        UIImageView *chevron = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_cell_arrow.png"]];;
        
        bg.frame = CGRectMake(0.0f, 0.0f, 320.0f, CELL_HEIGHT);
        chevron.frame = CGRectMake(235.0f, 14.0f, 15.0f, 15.0f);
        [bg addSubview:chevron];
        cell.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_cell_bg_active.png"]];
        selectedBg.frame = CGRectMake(0.0f, 0.0f, 320.0f, CELL_HEIGHT);
        UIImageView *selectedChevron = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_cell_arrow_active.png"]];
        selectedChevron.frame = CGRectMake(235.0f, 14.0f, 15.0f, 15.0f);
        [selectedBg addSubview:selectedChevron];
        cell.selectedBackgroundView = selectedBg;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    }
    return cell;
}

@end
