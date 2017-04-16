//
//  EXOCRCustomScanView.h
//  ExCardSDK
//
//  Created by kubo on 2016/12/8.
//  Copyright © 2016年 kubo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief 自定义扫描视图协议
 *
 *	@discussion 用户自定义扫描视图，须实现协议中的代理方法
 */
@protocol EXOCRCustomScanViewDelegate <NSObject>
@required
/**
*  @brief   根据扫描页面方向，返回扫描框Rect(每次识别实时调用该方法获取扫描框Rect)
*  @return  扫描框Rect，须保证扫描框Rect的坐标以竖屏状态下屏幕的左上角为原点计算
*  @param   orientation - 扫描页面方向
*/
-(CGRect)getGuideRect:(UIInterfaceOrientation)orientation;

/**
 *  @brief   根据扫描页面方向，刷新自定义视图(扫描页面方向改变时调用该方法)
 *  @param   orientation - 扫描页面方向
 */
-(void)refreshScanView:(UIInterfaceOrientation)orientation;

/**
 *  @brief   识别完成，获取识别结果
 *  @param   info - 识别结果
 */
-(void)recoCompleted:(id)info;

@optional
/**
 *  @brief   识别正反面错误（当前版本仅支持身份证识别）
 */
-(void)recoErrorWithWrongSide;
@end
