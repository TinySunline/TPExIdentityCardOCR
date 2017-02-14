//
//  TPExIdentityCardOCR.m
//  Pods
//
//  Created by kingdomrain on 2017/2/6.
//
//

#import "TPExIdentityCardOCR.h"
#import <ExCardSDK/ExCardSDK.h>

@interface TPExIdentityCardOCR()
@property (nonatomic, strong) EXOCRIDCardInfo * IDInfo;
@property (nonatomic, strong) UIViewController *viewController;

@end


@implementation TPExIdentityCardOCR
@synthesize error;
@synthesize success;
@synthesize bFront;

-(id)init{
    if(self = [super init]) {
        [EXOCRCardEngineManager initEngine];
    }
    return self;
    
}

-(void)start{
    UIViewController *window = [UIApplication sharedApplication].keyWindow.rootViewController;
    self.viewController = window;
    
    EXOCRIDCardRecoManager *manager = [EXOCRIDCardRecoManager sharedManager:self.viewController];
    [manager setImageMode:ID_IMAGEMODE_HIGH];
    
    BOOL bShouldFront = YES;   //默认是YES  识别正面还是背面，YES为正面，NO为背面
    if([self.bFront isEqualToString:@"NO"]){
        bShouldFront = NO;
    }
    
    [manager recoIDCardFromStreamWithSide:bShouldFront OnCompleted:^(int statusCode, EXOCRIDCardInfo *idInfo) {
        NSLog(@"Completed");
        NSLog(@"%@", [idInfo toString]);
        
        //将扫描的人脸缓存到本地
        UIImage *faceImage = idInfo.faceImg;
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageFilePath = [path stringByAppendingPathComponent:@"/faceImage.jpg"];
        BOOL success = [UIImageJPEGRepresentation(faceImage, 0.5) writeToFile:imageFilePath  atomically:YES];
        
        if (success){
            if(bShouldFront == NO){
                NSString *bdata = [NSString stringWithFormat:@"{\"issue\":\"%@\",\"valid\":\"%@\"}",idInfo.issue,idInfo.valid];
                [self.success callWithArguments:@[bdata]];
            }
            else{
                //1.0.5 add faceImgBase64
                UIImage *faceImg = idInfo.faceImg;
                NSData *faceImgData = UIImageJPEGRepresentation(faceImg, 0.2);
                NSString *encodedString2 = [faceImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                NSString *fdata = [NSString stringWithFormat:@"{\"name\":\"%@\",\"gender\":\"%@\",\"nation\":\"%@\",\"birth\":\"%@\",\"address\":\"%@\",\"code\":\"%@\",\"faceImgBase64\":\"%@\"}",idInfo.name,idInfo.gender,idInfo.nation,idInfo.birth,idInfo.address,idInfo.code,encodedString2];
                [self.success callWithArguments:@[fdata]];
            }
        }
        else{
            [self.error callWithArguments:@[@"失败"]];
        }
        
    } OnCanceled:^(int statusCode) {
        //NSLog(@"Canceled");
        [self.error callWithArguments:@[@"取消"]];
    } OnFailed:^(int statusCode, UIImage *recoImg) {
        //NSLog(@"Failed");
        [self.error callWithArguments:@[@"失败"]];
    }];
}

-(void)dealloc
{
    [EXOCRCardEngineManager finishEngine];
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
