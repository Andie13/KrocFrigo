//
//  AlimChoserViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 01/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//
#import <objc/runtime.h>
#import "AlimChoserViewController.h"

#import "foodCatTableViewController.h"
#import "Ingredients.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "AlimCollectionViewCell.h"

@interface AlimChoserViewController ()


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *OK;
@property (nonatomic, strong) UIButton *CXL;



@end

NSArray *aliments;


@implementation AlimChoserViewController
UIView *selAlim;

@synthesize info;

- (void)viewDidLoad {
    [super viewDidLoad];
   [self customSetup];
    
    NSLog(@"info %ld",(long)info.id_cat);
    
    
    
    NSInteger id_cat = info.id_cat;
    
  //  self.navigationItem.titleView = [NSString stringWithFormat:@"%@",info.nom_classeAlim];
    ;
    aliments = [[DataManager sharedDataManager] getIngrediantsFromCat:id_cat];
    
    
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    - (void)customSetup
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sideBarButton setTarget: self.revealViewController];
            [self.sideBarButton setAction: @selector( revealToggle: )];
            [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        }
    }


- (void)loadView
{
    [super loadView];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void) popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
#pragma mark <UICollectionViewDataSource>
    
    - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        
        return 1;
    }
    
    
    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return aliments.count;
    }
    
    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
        
        AlimCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"alimCell" forIndexPath:indexPath];
        
        Ingredients *monAlim = [aliments objectAtIndex:indexPath.row];
        cell.unite_mesure = monAlim.unite_mesure;
        cell.alimLabel.text = monAlim.nom_aliment;
        //  NSLog(@"aliments %@", monAlim.nom_aliment);
        
        return cell;
    }
    
#pragma mark <UICollectionViewDelegate>
    
    
    -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        // NSLog(@" %@",[aliments objectAtIndex:indexPath.row]);
        Ingredients *selAli= [aliments objectAtIndex:indexPath.row];
       // NSLog(@"je tape");
       // NSLog(@"//////// %@",selAli.unite_mesure);
        
        // la view
        
        CGRect frame = CGRectMake(10, 80, 300, 285);
        selAlim =[[UIView alloc]initWithFrame:frame];
        selAlim.backgroundColor =[UIColor whiteColor];
        [selAlim setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
        selAlim.userInteractionEnabled = YES;
        
        CGRect titleFrame = CGRectMake (40, 10, 200
                                        , 50
                                        );
        CGRect textdesc = CGRectMake (40, 60, 200, 50);
        CGRect qntText = CGRectMake (80, 120, 100, 50);
        CGRect qnt = CGRectMake (200, 120, 100, 50);
         CGRect ok = CGRectMake (0, 180 , 300, 50);
         CGRect non = CGRectMake (0, 232, 300, 50);
        
        //le titre de la view
        
        UILabel *alertMessage = [[UILabel alloc]initWithFrame:titleFrame];
        alertMessage.text = [NSString stringWithFormat:@"vous avez choisi : %@" ,selAli.nom_aliment ];
        alertMessage.lineBreakMode = NSLineBreakByWordWrapping;
        alertMessage.numberOfLines = 2;
        alertMessage.textAlignment = NSTextAlignmentCenter;
        
        alertMessage.textColor = [UIColor grayColor];
        
        //le descriptif
        UILabel *textDescr  = [[UILabel alloc]initWithFrame:textdesc];
        textDescr.text = [NSString stringWithFormat:@"Veuillez entrer une quantité :"];
        
        textDescr.lineBreakMode = NSLineBreakByWordWrapping;
        textDescr.numberOfLines = 2;
        textDescr.textAlignment = NSTextAlignmentCenter;
         textDescr.textColor = [UIColor blackColor];
        
        //quantité text a saisir
        
        UITextField *qntTxt  = [[UITextField alloc]initWithFrame:qntText];
        qntTxt.backgroundColor = [UIColor whiteColor];
        qntTxt.keyboardType = UIKeyboardTypeNumberPad;
        qntTxt.tag = 100;
        //qunt
        
        UILabel *Qnt  = [[UILabel alloc]initWithFrame:qnt];
        Qnt.text = [NSString stringWithFormat:@"%@",selAli.unite_mesure];
        Qnt.tag = 200;
        
        UILabel *idUm =[[UILabel alloc]initWithFrame:qnt];
        idUm.text = [NSString stringWithFormat:@"%ld", (long)selAli.id_uniteMesure];
        idUm.tag = 250;
        idUm.hidden = YES;
        
        //valider
        
       UIButton *valider = [[UIButton alloc]initWithFrame:ok
                   ];
     
        
        [valider setTitle:@"Oui, c'est ça!" forState:UIControlStateNormal];
        [valider addTarget:self action:@selector(addAlimToFridg) forControlEvents:UIControlEventTouchUpInside];

        valider.backgroundColor = [UIColor lightGrayColor];
         [valider.layer setBorderColor:[[UIColor greenColor] CGColor]];
        
        //annuler
        UIButton *Cxl  = [[UIButton alloc]initWithFrame:non];
        Cxl.backgroundColor = [UIColor lightGrayColor];
        [Cxl setTitle:@"Non" forState:UIControlStateNormal ];
        [Cxl addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];

       UILabel *id_alim  = [[UILabel alloc]initWithFrame:textdesc];
        
        id_alim.text = [NSString stringWithFormat:@"%ld" ,(long)selAli.id_aliment];
        id_alim.hidden = YES;
        id_alim.tag = 300;
        [selAlim addSubview:alertMessage]
        ;
        
        
        [selAlim addSubview:textDescr];
        [selAlim addSubview:qntTxt];
        [selAlim addSubview:idUm];
        [selAlim addSubview:Qnt];
        [selAlim addSubview:valider];
        [selAlim addSubview: id_alim];
        
        
        
         [selAlim addSubview:Cxl];
        [self.view.superview addSubview:selAlim];
        
        
        //valider.accessibilityHint = [selAli.id_aliment]
      }


-(void)removeFromSuperview
{
    [selAlim removeFromSuperview];
}  //
-(void)addAlimToFridg{
    
    UITextField *qntTxt = (UITextField *) [selAlim viewWithTag:100];
    UILabel *Qnt = (UILabel*) [selAlim viewWithTag:200];
    UILabel *idUm = (UILabel*) [selAlim viewWithTag:250];
    
    
    UILabel *id_alim = (UILabel*) [selAlim viewWithTag:300];
    
    NSInteger IDAL = [id_alim.text   intValue ];
    NSInteger IDUM = [idUm.text intValue];
    
    NSLog(@"là j'ai cliqué %@", qntTxt.text);
    NSLog(@"là j'ai cliqué %@", Qnt.text);
    NSLog(@"id_alim %ld",(long)IDAL);
    
    [[DataManager sharedDataManager] setfoodInTheFridge:IDAL qnt:qntTxt.text id_um:IDUM];
    
    [self removeFromSuperview]
    ;}

@end
