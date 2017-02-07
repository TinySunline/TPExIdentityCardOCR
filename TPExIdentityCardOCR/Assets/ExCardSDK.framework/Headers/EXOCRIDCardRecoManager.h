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
 *	@brief 身份证识别回调CompletedIDCardBlock, CanceledBlock, FailedBlock
 *
 *	@discussion 用来设定异步调用的回调
 */
typedef void (^CompletedIDCardBlock)(int statusCode, EXOCRIDCardInfo *idInfo);
typedef void (^CanceledBlock)(int statusCode);
typedef void (^FailedBlock)(int statusCode, UIImage *recoImg);

@interface EXOCRIDCardRecoManager : NSObject
/**
 *	@brief 获取EXOCRIDCardRecoManager实例化对象
 *  @return EXOCRIDCardRecoManager对象
 */
+(instancetype)sharedManager:(UIViewController *)vc;

/**
 * @brief 调用身份证证扫描识别
 * @param bFront - 识别正面还是背面，YES为正面，NO为背面
 * @param completedBlock - 识别完成回调，获取识别结果EXOCRIDCardInfo对象
 * @param canceledBlock - 识别取消回调
 * @param failedBlock - 识别失败回调
 */
-(void)recoIDCardFromStreamWithSide:(BOOL)bFront OnCompleted:(CompletedIDCardBlock)completedBlock
                          OnCanceled:(CanceledBlock)canceledBlock
                            OnFailed:(FailedBlock)failedBlock;
/**
 * @brief 静态图片识别方法
 * @param image - 待识别静态图像
 * @param completedBlock - 识别成功回调，获取识别结果EXOCRIDCardInfo对象
 * @param failedBlock - 识别失败回调
 */
-(void)recoIDCardFromStillImage:(UIImage *)image
                  OnCompleted:(CompletedIDCardBlock)completedBlock
                     OnFailed:(FailedBlock)failedBlock;

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

/**
 * @brief 取图设置，设置取图模式（目前支持三种取图模式）
 * @param imageMode - 取图模式（可配置取图模式在EXOCRIDCardInfo.h中定义）
 */
-(void)setImageMode:(int)imageMode;
@end
