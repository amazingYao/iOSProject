//
//  YKUIWebViewViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKUIWebViewViewController.h"

@interface YKUIWebViewViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webV;
@end

@implementation YKUIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"UIWebView"];
    [self loadRequests];
}

-(void)loadRequests{
    NSURL *url = [NSURL URLWithString:@"https://www.iqiyi.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.webV loadRequest:request];
}

#pragma mark - lazy
-(UIWebView *)webV{
    if (!_webV) {
        _webV  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        _webV.scrollView.delegate = self;
        _webV.delegate = self;
        [self.view addSubview:_webV];
        [(UIScrollView *)[[_webV subviews] objectAtIndex:0]    setBounces:NO];
    }
    return _webV;
}

#pragma mark - delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"即将开始加载");
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"页面加载失败====%@",error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"页面加载完成");
}

-(void)dealloc{
    NSLog(@"UIWebView销毁了");
}
@end
