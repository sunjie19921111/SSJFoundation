//
//  PL_ProvidencePaperDetailVC.m
//  EvianFutures-OC
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/9/30.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidencePaperDetailVC.h"
//#import "PL_ProvidenceWebViewController.h"
//#import <WebKit/WebKit.h>
//#import "PL_ProvidencePaperDetailVC.h"


@interface PL_ProvidencePaperDetailVC ()<WKUIDelegate,WKNavigationDelegate>

//@property (nonatomic, strong) UIScrollView *scrllView;
//@property (nonatomic, strong) WKWebView *webView;


@end

@implementation PL_ProvidencePaperDetailVC

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self loadData];
//}
//
//
//
//
//- (void)loadWebViewUrl:(NSString *)url {
//    _scrllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_scrllView];
//    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    
//    
//    
//    
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
//    
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    
//    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:wkWebConfig];
//    webView.UIDelegate = self;
//    webView.navigationDelegate = self;
//    webView.scrollView.scrollEnabled = NO;
//    webView.userInteractionEnabled = NO;
//    
//    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
//                       "<head> \n"
//                       "<style type=\"text/css\"> \n"
//                       "body {font-size:15px;}\n"
//                       "</style> \n"
//                       "</head> \n"
//                       "<body>"
//                       "<script type='text/javascript'>"
//                       "window.onload = function(){\n"
//                       "var $img = document.getElementsByTagName('img');\n"
//                       "for(var p in  $img){\n"
//                       " $img[p].style.width = '100%%';\n"
//                       "$img[p].style.height ='auto'\n"
//                       "}\n"
//                       "}"
//                       "</script>%@"
//                       "</body>"
//                       "</html>",url];
//    [webView loadHTMLString:htmls baseURL:nil];
//    [_scrllView addSubview:webView];
//    self.webView = webView;
//}
//
//- (void)loadData {
//    
//    
//    NSString *urlString = @"http://47.110.124.138:8081/stock/api/newsdetail/";
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
//    [params setObject:_ID forKey:@"id"];
//    [PL_ProvidenceBaseNetwork getWithURL:urlString params:params completion:^(NSError *error, id responseObject) {
//        if (!error) {
//            self.navigationItem.title = responseObject[@"data"][@"title"];
//            NSString *str = responseObject[@"data"][@"content"];
//            [self loadWebViewUrl:str];
//        }
//      
//    }];
//
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
////    self.title = webView.title;
//    __block CGFloat webViewHeight;
//    
//    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
//    [_webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
//        webViewHeight = [result doubleValue];
//        NSLog(@"web内容高度%f",webViewHeight); // 远高于实际值
//        self.scrllView.contentSize = CGSizeMake(0, webViewHeight);
//        self.webView.size = CGSizeMake(ScreenWidth, webViewHeight);
//    }];
//}

@end
