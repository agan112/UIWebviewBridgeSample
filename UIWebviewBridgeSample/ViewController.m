//
//  ViewController.m
//  UIWebviewBridgeSample
//
//  Created by letv on 16/9/9.
//  Copyright © 2016年 haha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.button];
}

- (UIWebView *)webView {
    if (!_webView) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseUrl = [NSURL fileURLWithPath:path];
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"webviewTest" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:(NSUTF8StringEncoding) error:nil];
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        rect.origin.y = 64;
        rect.size.height -= 64;
        _webView = [[UIWebView alloc] initWithFrame:rect];
        _webView.delegate = self;
        [_webView loadHTMLString:htmlString baseURL:baseUrl];
    }
    return _webView;
}

- (UIButton *)button {
    if (!_button) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        _button = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width - 100, rect.size.height - 84, 80, 40)];
        _button.backgroundColor = [UIColor blueColor];
        [_button setTitle:@"添加一行" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(addContent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"test"]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"webview test" message:[url absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}

- (IBAction)addContent:(id)sender {
    NSString * js = @" var p = document.createElement('p'); p.innerText = 'this is new content line.';document.body.appendChild(p);";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
