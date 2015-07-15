//
//  Outils.m
//  bistrotsBeaujolais
//
//  Created by Hugo GUTIERREZ on 04/03/13.
//  Copyright (c) 2013 Hugo GUTIERREZ. All rights reserved.
//

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#import "Outils.h"
#import <sys/xattr.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SOURCETYPE UIImagePickerControllerSourceTypeCamera

@implementation Outils


+ (BOOL) isVideoCameraAvailable
{
	
	if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE]) {
		// if so, does that camera support video?
		NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:SOURCETYPE];
		
		BOOL isA3GS = [mediaTypes containsObject:(id)kUTTypeMovie];
		
		return isA3GS;
	}
	return FALSE;
}


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
	
	if (SYSTEM_VERSION_EQUAL_TO(@"5.0.1")) {
		
		const char* filePath = [[URL path] fileSystemRepresentation];
		
		const char* attrName = "com.apple.MobileBackup";
		u_int8_t attrValue = 1;
		
		int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
		return result == 0;
		
	} else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1") ) {
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:[URL path]]) {
			
			//assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
			
			NSError *error = nil;
			BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
										  forKey:NSURLIsExcludedFromBackupKey
										   error:&error];
			if(!success){
				NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
			}
			return success;
		}
	}
	
	return NO;
}

+ (BOOL)iphone5{
    CGRect sBounds = [[UIScreen mainScreen] bounds];
    int sHeight = sBounds.size.height;
    
    if (sHeight>=568) {
        return TRUE;
    }else{
        return FALSE;
    }
    
}

+(NSString *)getNomApp{
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    return prodName;
}

+ (NSString*)getFilePath:(NSString *)nomRessource folder:(NSString*)folder type:(NSString *)type{
    NSString * langue = [Outils languageSelectedStringForKey:@"langue"];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"LangueApp"] != nil){
        langue = [[NSUserDefaults standardUserDefaults] valueForKey:@"LangueApp"];
    }
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:nomRessource ofType:type inDirectory:[NSString stringWithFormat:@"multilingue/%@",langue]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", [NSBundle mainBundle].bundlePath,folder,langue];
    if ([folder rangeOfString:@"content"].location != NSNotFound) {
        filePath = [NSString stringWithFormat:@"%@/%@", [NSBundle mainBundle].bundlePath,folder];
    }

    //NSLog(@"[%@]:%@",filePath,[[NSBundle bundleWithPath:filePath] pathForResource:nomRessource ofType:type inDirectory:NO]);
    return [[NSBundle bundleWithPath:filePath] pathForResource:nomRessource ofType:type inDirectory:NO];
}

+(NSString*) languageSelectedStringForKey:(NSString*) key
{
    //NSLog(@"Langue de l'application %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"LangueApp"]);
	NSString *path;
	if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LangueApp"] isEqualToString:@"fr"])
        path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
	else
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (int)getFontSize:(int)size{
    int fontSize = size;
    if (IPAD) {
        fontSize*=2;
    }
    return fontSize;
}


#pragma mark - LOADING
+ (id)addLoadingView:(NSString *)msg senderView:(UIView *)senderView loadingView:(UIView *)loadingView{
    
    int compIphone5=0;
    if ([self iphone5]){
        compIphone5 = 44;
    }
	
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, compIphone5, 320, 480)];
    loadingView.backgroundColor = [UIColor clearColor];
    loadingView.hidden = YES;
    
    UIView *loaderView = [[UIView alloc] initWithFrame:CGRectMake(85, 140.5+compIphone5, 150, 150)];
    loaderView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loaderView.clipsToBounds = YES;
    loaderView.layer.cornerRadius = 10.0;
    [loadingView addSubview:loaderView];
    
    
    UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loader setFrame:CGRectMake(57, 40, 37, 37)];
    [loader startAnimating];
    [loaderView addSubview:loader];
    
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 140, 40)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.numberOfLines = 2;
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.font = [UIFont boldSystemFontOfSize:14.0];
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.text = msg;
    [loaderView addSubview:loadingLabel];
    
    
    [senderView addSubview:loadingView];
    
    return loadingView;
}



@end
