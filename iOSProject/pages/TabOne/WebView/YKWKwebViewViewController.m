//
//  YKWKwebViewViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKWKwebViewViewController.h"
#import "YKWeakScriptMessageDelegate.h"
#import <WebKit/WebKit.h>
@interface YKWKwebViewViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)WKWebView *webV;
@end

@implementation YKWKwebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"WKWebView"];
    [self setNavigationLeftBarButtonWithImage:@"back"];
    [self setNavigationRightBarButtonWithString:@"调用JS方法"];
    [self loadRequests];
}

-(void)loadRequests{
    NSURL *url = [NSURL URLWithString:[YKHelper returnStr:self.urlStr OrNilStr:@"http://www.baidu.com"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.webV loadRequest:request];
}

-(void)leftBAction{
    if ([self.webV canGoBack]) {
        [self.webV goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)rightBAction{
    //OC调用JS方法
    [self.webV evaluateJavaScript:@"JS中方法名(参数)" completionHandler:nil];
}



#pragma mark - lazy
-(WKWebView *)webV{
     WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
     WKUserContentController *userController = [[WKUserContentController alloc] init];
     configuration.userContentController = userController;
    //注入JS
     [userController addScriptMessageHandler:[[YKWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"约定方法名"];
    
    //注入cookie
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie ='TeskCookieKey1=TeskCookieValue1';document.cookie = 'TeskCookieKey2=TeskCookieValue2';"injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userController addUserScript:cookieScript];
    
    _webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:configuration];
    _webV.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webV];
    [(UIScrollView *)[[_webV subviews] objectAtIndex:0] setBounces:NO];
    _webV.navigationDelegate = self;
    return _webV;
}

#pragma mark - delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"是否允许这个导航?允许！");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"知道返回内容之后，是否允许加载?允许!");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页开始接收网页内容");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页导航加载完毕");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"网页由于某些原因加载失败");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"网页加载内容进程终止");
}
# pragma mark - JS
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 判断是否是调用原生的
    if ([@"约定方法名" isEqualToString:message.name]) {
        //获取传参
        NSString *str = message.body;
        NSLog(@"%@",str);
    }
}

-(void)dealloc{
    [_webV.configuration.userContentController removeScriptMessageHandlerForName:@"约定方法名"];
    NSLog(@"WKWebView销毁了");
}

@end
