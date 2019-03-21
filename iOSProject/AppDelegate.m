//
//  AppDelegate.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/23.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "AppDelegate.h"
#import "YKExTabbarViewController.h"
#import "YKKZViewController.h"
#import "YK3DTouchViewController.h"
#import "XHLaunchAd.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:0.5];
    [AMapServices sharedServices].apiKey = @"e9b3e931741fe6780bb3752a4020908e";
    
    [self setLaunchAdd];
    [self set3DTouch];
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    YKExTabbarViewController *vc = [[YKExTabbarViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

#pragma mark - 设置APP广告页
//设置启动页广告
-(void)setLaunchAdd{
    NSString *currentVersion = [YKSystem getCurrentVersion];
    NSString *showedVersion = [YKUser getStringDataFromUserDefaults:@"firstInVersion" default:nil];
    if (![currentVersion isEqualToString:showedVersion]) {
        return;
    }
    
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    imageAdconfiguration.duration = 5;
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    imageAdconfiguration.imageNameOrURLString = @"image1.jpg";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFlipFromLeft;
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    imageAdconfiguration.showEnterForeground = YES;
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
}

/**
 广告点击事件代理方法
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    
    if(openModel==nil) return;
    
    NSString *urlString = (NSString *)openModel;
    NSLog(@"%@",urlString);
    //此处跳转页面
    //WebViewController *VC = [[WebViewController alloc] init];
    //VC.URLString = urlString;
    ////此处不要直接取keyWindow
    //UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    //[rootVC.myNavigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 3DTouch
-(void)set3DTouch{
    if ([UIApplication sharedApplication].shortcutItems.count >= 4)
        return;

    NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"YK.3DTouch.openAdd" localizedTitle:@"新增" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
    [arrShortcutItem addObject:shoreItem1];
    
    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"YK.3DTouch.Compose" localizedTitle:@"新消息" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    [arrShortcutItem addObject:shoreItem2];
    
    
    UIApplicationShortcutItem *shoreItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"YK.3DTouch.openSearch" localizedTitle:@"搜索" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [arrShortcutItem addObject:shoreItem3];
    
    UIApplicationShortcutItem *shoreItem4 = [[UIApplicationShortcutItem alloc] initWithType:@"YK.3DTouch.openShare" localizedTitle:@"分享" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:nil];
    [arrShortcutItem addObject:shoreItem4];
    
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
    
    YK3DTouchViewController *vc = [[YK3DTouchViewController alloc] init];
    [(UINavigationController*)self.window.rootViewController.childViewControllers[[(UITabBarController *)self.window.rootViewController selectedIndex]] pushViewController:vc animated:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    return [self appHandleOpenURL:url];
}

#pragma mark - private method
- (BOOL)appHandleOpenURL:(NSURL *)url{
    if([url.scheme compare:@"iOSProject" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        YKKZViewController *vc = [[YKKZViewController alloc] init];
        [(UINavigationController*)self.window.rootViewController.childViewControllers[[(UITabBarController *)self.window.rootViewController selectedIndex]] pushViewController:vc animated:YES];
        return YES;
    }
    
    return NO;
}

@end
