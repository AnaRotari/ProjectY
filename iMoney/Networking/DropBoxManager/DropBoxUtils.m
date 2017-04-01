//
//  DropBoxUtils.m
//  CloudVideo
//
//  Created by Ion Postolachi on 4/1/16.
//  Copyright © 2016 Ion Postolachi. All rights reserved.
//

#import "DropBoxUtils.h"

static DropBoxUtils *DropBoxObj;
NSString *const kDropboxKey =          @"1kvmbutn84bnfax";
NSString *const kDropboxSecret =       @"5jcw4fiw8w6qx6l";

@implementation DropBoxUtils{
    NSInteger downloadedFiles;
}

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DropBoxObj = [DropBoxUtils new];
        [DropBoxObj initRestClient];
    });
    return DropBoxObj;
}

-(void)initRestClient{
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:kDropboxKey appSecret:kDropboxSecret root:kDBRootAppFolder];
    [DBSession setSharedSession:dbSession];

    if ([DropBoxObj isAuthorized]) {
        DropBoxObj.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        [DropBoxObj.restClient setDelegate:self];
    }
}

-(BOOL)setupDropBox:(NSURL *)url{
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"dropbox linked successfully!");
            [self initRestClient];
            DropBoxObj.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            [DropBoxObj.restClient setDelegate:self];
            
            NSArray<NSString *> *fileNames = @[kDBiMoneySQLite, kDBiMoneySQLiteSHM, kDBiMoneySQLiteWAL];
            NSString *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].path;
            for (NSString *fileName in fileNames) {
                [DropBoxObj.restClient loadFile:[@"/" stringByAppendingString:fileName] intoPath:[docPath stringByAppendingPathComponent:fileName]];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(DropBoxWasLinked)]) {
                [self.delegate DropBoxWasLinked];
            }
            [self loadUserInfo];
            return YES;
        }
    }
    NSLog(@"dropbox not linked successfully!");
    return NO;
}

-(void)logIn{
    [[DBSession sharedSession] linkFromController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(void)logOut{
    [[DBSession sharedSession] unlinkAll];
    DropBoxObj.restClient = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(DropBoxStateChangedWithText:)]) {
        [self.delegate DropBoxStateChangedWithText:@"Login"];
    }
}

-(void)logInAndOut{
    if ([self isAuthorized]) {
        [self logOut];
    }else
        [self logIn];
}

-(void)logInOrDoStuff:(void(^)(void))block{
    if (![self isAuthorized]) {
        [self logIn];
    }else{
        if (block) {
            block();
        }
    }
}

-(BOOL)isAuthorized{
    return [[DBSession sharedSession] isLinked];
}

#pragma mark user info
-(void)loadUserInfo{
    if (![self isAuthorized]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(DropBoxStateChangedWithText:)]) {
            [self.delegate DropBoxStateChangedWithText:@"Login"];
        }
        return;
    }
    [DropBoxObj.restClient loadAccountInfo];
}

- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info.displayName forKey:kUserName];
    [defaults synchronize];
    if (self.delegate && [self.delegate respondsToSelector:@selector(DropBoxStateChangedWithText:)]) {
        [self.delegate DropBoxStateChangedWithText:info.displayName];
    }
}

- (void)restClient:(DBRestClient*)client loadAccountInfoFailedWithError:(NSError*)error{
    NSLog(@"%@", error);
}

#pragma mark - rest client methods
-(void)uploadCoreData{
    NSArray<NSString *> *fileNames = @[kDBiMoneySQLite, kDBiMoneySQLiteSHM, kDBiMoneySQLiteWAL];
    NSString *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].path;
    
    for (NSString *fileName in fileNames) {
        NSString *filepath = [docPath stringByAppendingPathComponent:fileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
            NSString *fileRev = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];
            [DropBoxObj.restClient uploadFile:fileName toPath:@"/" withParentRev:fileRev fromPath:filepath];
        }
    }
}

-(void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata{
    NSLog(@"%@", metadata.filename);
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error{
    NSLog(@"%@", error);
}

-(void)restClient:(DBRestClient *)restClient loadedStreamableURL:(NSURL *)url forFile:(NSString *)path{

}

- (void)restClient:(DBRestClient*)restClient loadStreamableURLFailedWithError:(NSError*)error{
    
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath
          metadata:(DBMetadata*)metadata{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:metadata.rev forKey:metadata.filename];
    [defaults synchronize];
    NSLog(@"1 - success");
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error{
    NSLog(@"2 - error: %@",[error localizedDescription]);
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath{
    downloadedFiles++;
    if (downloadedFiles == 3) {
        downloadedFiles = 0;
        if (self.delegate && [self.delegate respondsToSelector:@selector(downloadCoreDataFinished)]) {
            [self.delegate downloadCoreDataFinished];
        }
    }
    NSLog(@"%@", destPath);
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error{
    NSLog(@"%@", error);
}

@end
