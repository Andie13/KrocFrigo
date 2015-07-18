//
//  NavigationViewControllerTableViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 15/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "NavigationViewControllerTableViewController.h"
#import "SWRevealViewController.h"
#import "AccueilCollectionViewController.h"
#import "CreditsViewController.h"

@interface NavigationViewControllerTableViewController ()

@end

@implementation NavigationViewControllerTableViewController{
    
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  menu = @[@"Accueil",@"Credits"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *Cell = [menu objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     NSLog(@"j'ai cliqué ");
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menu objectAtIndex:indexPath.row] capitalizedString];
    
    if ([segue.identifier isEqualToString:@"Accueil"]) {
        
        
       AccueilCollectionViewController *accueilViewController = [segue destinationViewController ];
      
    }
    else if([segue.identifier isEqualToString:@"Credits"]) {
        
        CreditsViewController *creditViewController = [segue destinationViewController];
    
    }
    
}


@end
