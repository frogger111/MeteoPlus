//
//  SearchTownViewController.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 11/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "SearchTownViewController.h"
#import "MEDynamicTransition.h"
#import "UIViewController+ECSlidingViewController.h"
#import "METransitions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SearchAPI.h"
#import "Location.h"
#import <TSMessages/TSMessage.h>

@interface SearchTownViewController ()

@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;

@end

@implementation SearchTownViewController{

    NSArray *_places;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    [[SearchAPI api] searchPlaceWithName:searchString success:^(NSArray *places) {
        _places = places;
    } failure:^(NSError *error) {
        
        NSString *errorMsg = @"";
        
        if(error.code == -1009){
            errorMsg = @"Check network connection";
            [TSMessage showNotificationWithTitle:@"ERROR"
                                        subtitle:errorMsg
                                            type:TSMessageNotificationTypeError];
        }
        
    }];
     
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([(NSObject *)self.slidingViewController.delegate isKindOfClass:[MEDynamicTransition class]]) {
        MEDynamicTransition *dynamicTransition = (MEDynamicTransition *)self.slidingViewController.delegate;
        if (!self.dynamicTransitionPanGesture) {
            self.dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:dynamicTransition action:@selector(handlePanGesture:)];
        }
        
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
        [self.navigationController.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    } else {
        [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }
}

#pragma mark - IBActions

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_places){
        
        return [_places count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SearchTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView){
        
        if(_places){
            
            Location *place = [_places objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@, %@ %f %f %d", place.areaName, place.country, place.latitude, place.longitude, place.population];
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        }
    }
    
    return cell;
}



@end
