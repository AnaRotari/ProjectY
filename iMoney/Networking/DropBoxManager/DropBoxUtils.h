//
//  DropBoxUtils.h
//  CloudVideo
//
//  Created by Ion Postolachi on 4/1/16.
//  Copyright © 2016 Ion Postolachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@protocol DropBoxDelegate <NSObject>

@optional
-(void)DropBoxStateChangedWithText:(NSString *)text;
-(void)DropBoxWasLinked;

-(void)downloadCoreDataFinished;
@end

@interface DropBoxUtils : NSObject<DBRestClientDelegate>

+(instancetype)sharedInstance;

@property(weak, nonatomic) id<DropBoxDelegate>delegate;
@property(strong, nonatomic) DBRestClient *restClient;

-(BOOL)setupDropBox:(NSURL *)url;
-(void)logIn;
-(void)logOut;
-(void)logInAndOut;
-(void)logInOrDoStuff:(void(^)(void))block;
-(void)loadUserInfo;

-(void)uploadCoreData;

@end
