//
//  Outils.h
//  bistrotsBeaujolais
//
//  Created by Hugo GUTIERREZ on 04/03/13.
//  Copyright (c) 2013 Hugo GUTIERREZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Outils : NSObject

+ (BOOL)iphone5;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+ (id)addLoadingView:(NSString *)msg senderView:(UIView *)senderView loadingView:(UIView *)loadingView;
+ (NSString*)getFilePath:(NSString *)nomRessource folder:(NSString*)folder type:(NSString *)type;
+ (NSString *)getNomApp;
+ (NSString*)languageSelectedStringForKey:(NSString*) key;
+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (int)getFontSize:(int)size;

@end
