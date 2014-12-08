//
//  CallViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/11/15.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController ()

@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //背景画像のセット
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundImage.image = [UIImage imageNamed:@"callbackground.png"];
    [self.view addSubview:backGroundImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
