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
        Class TinyPlus=NSClassFromString(@"TinyPlus");
        if(TinyPlus){
            id tinyPlusInPod  =  [[TinyPlus alloc] init];
            if([tinyPlusInPod respondsToSelector:@selector(getViewController)]){
                self.viewController =[tinyPlusInPod performSelector:@selector(getViewController)];
            }
        }
    }
    return self;
    
}

-(void)start{
    
    EXOCRIDCardRecoManager *manager = [EXOCRIDCardRecoManager sharedManager:self.viewController];
    [manager setImageMode:ID_IMAGEMODE_HIGH];
    [manager setDisplayLogo:NO];
    [manager displayScanViewControllerByPresent:YES];
    
    BOOL bShouldFront = YES;   //默认是YES  识别正面还是背面，YES为正面，NO为背面
    if([self.bFront isEqualToString:@"NO"]){
        bShouldFront = NO;
    }
    [manager recoIDCardFromStreamWithSide:bShouldFront OnCompleted:^(int statusCode, EXOCRIDCardInfo *idInfo) {
        NSLog(@"%@", [idInfo toString]);
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
            if(bShouldFront == NO){
                UIImage *backFullImg =idInfo.backFullImg;    //身份证背面全图
                NSString *backFullImgPath = [path stringByAppendingPathComponent:@"/backFullImg.jpg"];
                BOOL success = [UIImageJPEGRepresentation(backFullImg, 0.5) writeToFile:backFullImgPath  atomically:YES];
                if(success){
                    NSString *imgUrl=@"local://";
                    imgUrl = [imgUrl stringByAppendingString:backFullImgPath];
                    NSString *bdata = [NSString stringWithFormat:@"{\"office\":\"%@\",\"validdate\":\"%@\",\"imgPath\":\"%@\"}",idInfo.issue,idInfo.valid,imgUrl];
                    [self.success callWithArguments:@[bdata]];
                }
            }
            else{
                //1.0.5 add faceImgBase64
//                UIImage *faceImg = idInfo.faceImg;
//                NSData *faceImgData = UIImageJPEGRepresentation(faceImg, 0.2);
//                NSString *encodedString2 = [faceImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                //1.0.6 add 头像图片路径
                UIImage *faceImage = idInfo.faceImg;
                NSString *imageFilePath = [path stringByAppendingPathComponent:@"/faceImage.jpg"];
                BOOL success1 = [UIImageJPEGRepresentation(faceImage, 0.5) writeToFile:imageFilePath  atomically:YES];
                
                UIImage *frontFullImg = idInfo.frontFullImg;
                NSString *frontFullImgPath = [path stringByAppendingPathComponent:@"/frontFullImg.jpg"];
                BOOL success2 = [UIImageJPEGRepresentation(frontFullImg, 0.5) writeToFile:frontFullImgPath  atomically:YES];
                if(success1&&success2){
                    NSString *imageFileimgUrl=@"local://";
                    imageFileimgUrl = [imageFileimgUrl stringByAppendingString:imageFilePath];
                    NSString *ifrontFullImgUrl=@"local://";
                    ifrontFullImgUrl = [ifrontFullImgUrl stringByAppendingString:frontFullImgPath];
                    NSString *fdata = [NSString stringWithFormat:@"{\"name\":\"%@\",\"sex\":\"%@\",\"nation\":\"%@\",\"birth\":\"%@\",\"address\":\"%@\",\"cardnum\":\"%@\",\"imgPath\":\"%@\",\"imgFacePath\":\"%@\"}",idInfo.name,idInfo.gender,idInfo.nation,idInfo.birth,idInfo.address,idInfo.code,ifrontFullImgUrl,imageFileimgUrl];
                    [self.success callWithArguments:@[fdata]];
                }
            }
    } OnCanceled:^(int statusCode) {
        [self.error callWithArguments:@[@"取消"]];
    } OnFailed:^(int statusCode, UIImage *recoImg) {
        [self.error callWithArguments:@[@"失败"]];
    }];
}

-(void)dealloc
{
    [EXOCRCardEngineManager finishEngine];
}

@end
