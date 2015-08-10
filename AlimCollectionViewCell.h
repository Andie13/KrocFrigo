//
//  AlimCollectionViewCell.h
//  KrocFrigo
//
//  Created by Andie Perrault on 23/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlimCollectionViewCell : UICollectionViewCell{

}


@property (weak, nonatomic) IBOutlet UILabel *alimLabel;




@property (nonatomic, assign)  NSInteger id_unite_mesure;
@property (nonatomic, strong) NSString *unite_mesure;



@end
