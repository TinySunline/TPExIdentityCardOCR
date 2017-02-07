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
    NSLog(@"开始ocr扫描");
    UIViewController *window = [UIApplication sharedApplication].keyWindow.rootViewController;
    
//    UIViewController *currentVC = [self getCurrentVC];
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
        
        if(bShouldFront == NO){
            NSString *fdata = [NSString stringWithFormat:@"{\"name\":\"%@\",\"gender\":\"%@\",\"nation\":\"%@\",\"birth\":\"%@\",\"address\":\"%@\",\"code\":\"%@\"}",idInfo.name,idInfo.gender,idInfo.nation,idInfo.birth,idInfo.address,idInfo.code];
            [self.success callWithArguments:@[fdata]];
        }
        else{
            NSString *bdata = [NSString stringWithFormat:@"{\"issue\":\"%@\",\"valid\":\"%@\"}",idInfo.issue,idInfo.valid];
            [self.success callWithArguments:@[bdata]];
        }
    } OnCanceled:^(int statusCode) {
        NSLog(@"Canceled");
        [self.error callWithArguments:@[@"取消"]];
    } OnFailed:^(int statusCode, UIImage *recoImg) {
        NSLog(@"Failed");
        [self.error callWithArguments:@[@"失败"]];
    }];
    NSLog(@"结束扫描");
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
