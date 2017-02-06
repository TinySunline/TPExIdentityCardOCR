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
-(void)start;
@end


@interface TPExIdentityCardOCR : NSObject<TPExIdentityCardOCRProtocol>

@end
