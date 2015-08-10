//
//  MonGardeMangerTableViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 21/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonGardeMangerTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

-(void)reloadTableView;


@end
