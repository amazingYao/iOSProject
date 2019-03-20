//
//  YKWeakScriptMessageDelegate.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface YKWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic,weak)id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
