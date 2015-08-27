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
    
    // NSLog(@"info %@",info.id_cat);
    
    
    
    NSInteger id_cat = [info.id_cat integerValue];
    
    self.navigationItem.titleView = info.labelCat;
    aliments = [[DataManager sharedDataManager] getIngrediantsFromCat:id_cat];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    
    // Do any additional setup after loading the view.}
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
        NSLog(@"je tape");
        NSLog(@"//////// %@",selAli.unite_mesure);
        
        // la view
        
        CGRect frame = CGRectMake(10, 80, 300, 350);
        selAlim =[[UIView alloc]initWithFrame:frame];
        selAlim.backgroundColor =[UIColor whiteColor];
        [selAlim setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
        selAlim.userInteractionEnabled = YES;
        
        CGRect titleFrame = CGRectMake (30, 10, 200
                                        , 50
                                        );
        CGRect textdesc = CGRectMake (30, 60, 200, 50);
        CGRect qntText = CGRectMake (80, 120, 100, 50);
        CGRect qnt = CGRectMake (200, 120, 100, 50);
         CGRect ok = CGRectMake (0, 180 , 290, 50);
         CGRect non = CGRectMake (0, 232, 290, 50);


        
        //le titre de la view
        
        UILabel *alertMessage = [[UILabel alloc]initWithFrame:titleFrame];
        alertMessage.text = [NSString stringWithFormat:@"vous avez choisi : %@" ,selAli.nom_aliment ];
        alertMessage.lineBreakMode = NSLineBreakByWordWrapping;
        alertMessage.numberOfLines = 2;
        alertMessage.textAlignment = NSTextAlignmentCenter;
        
        alertMessage.textColor = [UIColor greenColor];
        
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
   /*-(void)valider:(id)sender{
       NSString *myData = (NSArray *)objc_getAssociatedObject(sender, &myDataKey);
   }*/


        //    UIAlertView *selAliments = [[UIAlertView alloc] initWithTitle:@"saisissez la quantité "  message:[NSString stringWithFormat:@"%ld %@ en %@",(long)selAli.id_aliment,selAli.nom_aliment,selAli.unite_mesure ] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Oui, c'est bien ça", nil];
        //    UILabel *um = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
        //    [um setBackgroundColor:[UIColor whiteColor]];
        //
        //     um.text = [NSString stringWithFormat:@"%@",selAli.unite_mesure];
        //    NSLog(@"um %@",um.text);
        //
        //
        //    UILabel *idAlim = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
        //    [um setBackgroundColor:[UIColor whiteColor]];
        //
        //    idAlim.text = [NSString stringWithFormat:@"%ld",(long)selAli.id_aliment];
        //
        //
        //    [selAliments addSubview:um];
        //    [selAliments addSubview:idAlim];
        //
        //
        //
        //    //textfield pour saisir la quantité
        //
        //    selAliments.alertViewStyle = UIAlertViewStylePlainTextInput;
        //
        //    UITextField *writeQnt= [selAliments textFieldAtIndex:0];
        //
        //
        //    assert(writeQnt);
        //
        //    //keyboard numeric pour sécuriser les données entrées en base.
        //    writeQnt.keyboardType = UIKeyboardTypeNumberPad;
        //
        //
        //       [selAliments show];

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
     return YES;
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     return YES;
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
     return NO;
     }
     
     - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
     return NO;
     }
     
     - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
     
     }
     */
    

@end
