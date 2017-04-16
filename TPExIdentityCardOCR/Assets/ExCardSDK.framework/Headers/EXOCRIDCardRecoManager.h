//
//  EXOCRIDCardRecoManager.h
//  ExCardSDK
//
//  Created by kubo on 16/9/6.
//  Copyright © 2016年 kubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXOCRIDCardInfo.h"

/**
 *	@brief 身份证识别回调EXOCRCompletedIDCardBlock, EXOCRCanceledBlock, EXOCRFailedBlock
 *
 *	@discussion 用来设定异步调用的回调
 */
typedef void (^EXOCRCompletedIDCardBlock)(int statusCode, EXOCRIDCardInfo *idInfo);
typedef void (^EXOCRCanceledBlock)(int statusCode);
typedef void (^EXOCRFailedBlock)(int statusCode, UIImage *recoImg);

@interface EXOCRIDCardRecoManager : NSObject
/**
 *	@brief 获取EXOCRIDCardRecoManager实例化对象
 *  @return EXOCRIDCardRecoManager对象
 */
+(instancetype)sharedManager:(UIViewController *)vc;

/**
 * @brief 取图设置，设置取图模式（目前支持三种取图模式）
 * @param imageMode - 取图模式（可配置取图模式在EXOCRIDCardInfo.h中定义）
 */
-(void)setImageMode:(int)imageMode;

/**
 * @brief 静态图片识别方法
 * @param image - 待识别静态图像
 * @param completedBlock - 识别成功回调，获取识别结果EXOCRIDCardInfo对象
 * @param EXOCRFailedBlock - 识别失败回调
 */
-(void)recoIDCardFromStillImage:(UIImage *)image
                    OnCompleted:(EXOCRCompletedIDCardBlock)completedBlock
                       OnFailed:(EXOCRFailedBlock)EXOCRFailedBlock;

/**
 * @brief 扫描页面调用方式设置，设置扫描页面调用方式
 * @param bByPresent - 是否以present方式调用，默认为NO，YES-以present方式调用，NO-以sdk默认方式调用(push或present)
 */
-(void)displayScanViewControllerByPresent:(BOOL)bByPresent;

#pragma mark - 默认扫描视图
/**
 * @brief 调用身份证扫描识别(若自定义扫描视图，请使用recoIDCardFromStreamByCustomScanViewWithSide:方法调用识别)
 * @param bFront - 身份证方向，YES-正面，NO-背面
 * @param completedBlock - 识别完成回调，获取识别结果EXOCRIDCardInfo对象
 * @param EXOCRCanceledBlock - 识别取消回调
 * @param EXOCRFailedBlock - 识别失败回调
 */
-(void)recoIDCardFromStreamWithSide:(BOOL)bFront OnCompleted:(EXOCRCompletedIDCardBlock)completedBlock
                          OnCanceled:(EXOCRCanceledBlock)EXOCRCanceledBlock
                            OnFailed:(EXOCRFailedBlock)EXOCRFailedBlock;

/**
 * @brief 扫描页设置，是否显示logo
 * @param bDisplayLogo - 默认为YES
 */
-(void)setDisplayLogo:(BOOL)bDisplayLogo;

/**
 * @brief 扫描页设置，是否开启本地相册识别
 * @param bEnablePhotoRec - 默认为YES
 */
-(void)setEnablePhotoRec:(BOOL)bEnablePhotoRec;

/**
 * @brief 扫描页设置，扫描框颜色
 * @param rgbColor - rgb颜色值(例:0xffffff)
 * @param alpha - 透明度(例：0.8f, 0-1之间)
 */
-(void)setScanFrameColorRGB:(long)rgbColor andAlpha:(float)alpha;

/**
 * @brief 扫描页设置，正常状态扫描字体颜色
 * @param rgbColor - rgb颜色值(例:0xffffff)
 */
-(void)setScanNormalTextColorRGB:(long)rgbColor;

/**
 * @brief 扫描页设置，错误状态扫描字体颜色
 * @param rgbColor - rgb颜色值(例:0xffffff)
 */
-(void)setScanErrorTextColorRGB:(long)rgbColor;

/**
 * @brief 扫描页设置，正常状态正面扫描提示文字
 * @param tipStr - 提示文字
 */
-(void)setScanFrontNormalTips:(NSString *)tipStr;

/**
 * @brief 扫描页设置，错误状态正面扫描提示文字
 * @param tipStr - 提示文字
 */
-(void)setScanFrontErrorTips:(NSString *)tipStr;

/**
 * @brief 扫描页设置，正常状态背面扫描提示文字
 * @param tipStr - 提示文字
 */
-(void)setScanBackNormalTips:(NSString *)tipStr;

/**
 * @brief 扫描页设置，错误状态背面扫描提示文字
 * @param tipStr - 提示文字
 */
-(void)setScanBackErrorTips:(NSString *)tipStr;

/**
 * @brief 扫描页设置，正常状态扫描提示文字字体名称及字体大小
 * @param fontName - 字体名称
 * @param fontSize - 字体大小
 */
-(void)setScanNormalTipsFontName:(NSString *)fontName andFontSize:(float)fontSize;

/**
 * @brief 扫描页设置，错误状态扫描提示文字字体名称及字体大小
 * @param fontName - 字体名称
 * @param fontSize - 字体大小
 */
-(void)setScanErrorTipsFontName:(NSString *)fontName andFontSize:(float)fontSize;

#pragma mark - 自定义扫描视图
/**
 *	@brief 设置自定义扫描视图，当前版本仅支持横屏识别（若自定义扫描视图，其他扫描页设置接口将无效）
 *         自定义扫描视图frame须与竖屏屏幕大小一致
 *         建议：1.自定义扫描视图frame设置为[UIScreen mainScreen].bounds(须保证width小于height)
 *              2.自定义扫描视图扫描框宽高比设置为720:454，以达到最佳识别效果
 *  @return YES-设置自定义扫描视图成功，NO-设置自定义扫描视图失败
 *  @param customScanView - 自定义扫描试图
 */
-(BOOL)setCustomScanView:(UIView *)customScanView;

/**
 *	@brief 退出扫描识别控制器（仅在设置自定义扫描视图成功后生效）
 */
-(void)dismissScanViewControllerAnimated:(BOOL)animated;

/**
 *	@brief 闪光灯开启与关闭（仅在设置自定义扫描视图成功后生效）
 *  @param bMode - 闪光灯模式，YES-打开闪光灯，NO-关闭闪光灯
 */
-(void)setFlashMode:(BOOL)bMode;

/**
 * @brief 调用身份证扫描识别(若默认扫描视图，请使用recoIDCardFromStreamWithSide:OnCompleted:OnCanceled:OnFailed:方法调用识别)
 * @param bFront - 身份证方向，YES-正面，NO-背面
 */
-(void)recoIDCardFromStreamByCustomScanViewWithSide:(BOOL)bFront;
@end
