//
//  DataManager.h
//
//  Created by Simon Fage on 28/09/12.
//  Copyright (c) 2011 Voxinzebox All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

#import "POI.h"
#import "Media.h"

@interface DataManager : NSObject {

}

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (DataManager *)sharedDataManager;

- (void)initiliaze;
- (NSArray *)getPOI;
- (POI *)getPOI:(int)idPOI;
- (int)getIdProchainPOI;
- (NSArray *)getMedias:(int)idPOI;
- (NSArray *)getMediasPrincipaux:(int)idPOI;
- (NSArray *)getMediasSecondaires:(int)idPOI;
- (Media *)getMedia:(int)idMedia;
- (void)setPOIAsFinished:(int)idPOI;
- (void)setMediaAsUnlock:(int)idMedia;
- (void)clearAlbum;
- (NSArray *)getPersonnages;

@end
