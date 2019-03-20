//
//  YKWeakScriptMessageDelegate.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKWeakScriptMessageDelegate.h"

@implementation YKWeakScriptMessageDelegate
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
