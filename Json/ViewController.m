//
//  ViewController.m
//  Json
//
//  Created by zhaohang on 2017/12/28.
//  Copyright © 2017年 HangZhao. All rights reserved.
//

#import "ViewController.h"
#import "KeepLabelInfoModel.h"
@interface ViewController ()
@property (nonatomic, copy) NSString *tmpString;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label1.backgroundColor = [UIColor colorWithRed:0.35 green:0.87 blue:0.67 alpha:0.8];
    self.label2.backgroundColor = [UIColor colorWithRed:0.98 green:0.56 blue:0.07 alpha:0.6];
    for (UILabel *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UILabel class]] ) {
            [[KeepLabelInfoModel getInstance] addObject:subview];
        }
    }
    self.tmpString = [KeepLabelInfoModel getInstance].JSONString;
    NSLog(@"%@",[KeepLabelInfoModel getInstance].JSONString);
}

- (IBAction)deleteLabel:(id)sender {
    
    for (UILabel* subview in self.view.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview removeFromSuperview];
        }
    }
}

- (IBAction)addLabel:(id)sender {
    [[KeepLabelInfoModel getInstance] modelObjectsWithJSONString:[KeepLabelInfoModel getInstance].JSONString];
    for (UILabel *subview in [KeepLabelInfoModel getInstance].modelObject) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [self.view addSubview:subview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
