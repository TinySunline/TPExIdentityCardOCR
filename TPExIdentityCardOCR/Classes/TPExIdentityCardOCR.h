//
//  TPExIdentityCardOCR.h
//  Pods
//
//  Created by kingdomrain on 2017/2/6.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSExport.h>
#import <UIKit/UIKit.h>


@protocol TPExIdentityCardOCRProtocol <JSExport>
@property(nonatomic,strong) NSString *bFront;
@property(nonatomic, strong) JSValue *success;
@property(nonatomic, strong) JSValue *error;
-(void)start;       //scan
@end


@interface TPExIdentityCardOCR : NSObject<TPExIdentityCardOCRProtocol>

@end
