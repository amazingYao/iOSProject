//
//  YK3DESViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/21.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YK3DESViewController.h"
#import "AA3DESManager.h"
@interface YK3DESViewController ()

@end

@implementation YK3DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"3DES"];
    
    NSString *beMakeString = @"lja1234";
    
    NSString *encrypptString = [AA3DESManager getEncryptWithString:beMakeString keyString:@"010135891289502694869710" ivString:nil];
    NSString *decryptString = [AA3DESManager getDecryptWithString:@"P31uJdaOSiw=" keyString:@"010135891289502694869710" ivString:nil];
    
    NSLog(@"3des加密:%@",encrypptString);
    NSLog(@"3des解密:%@",decryptString);
}


@end
