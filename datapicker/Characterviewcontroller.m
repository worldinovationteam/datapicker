//
//  CharacterViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/12/09.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "CharacterViewController.h"

@interface CharacterViewController ()

@end

@implementation CharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize =[[UIScreen mainScreen] bounds].size;
    
    NSLog(@"%f,%f",screenSize.height, screenSize.width);
    
    
    UILabel *copywrite = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width*0.1, screenSize.height*0.1,screenSize.width*0.8, screenSize.height*0.3)];
    copywrite.numberOfLines = 4;
    copywrite.text = @"使用キャラクター：あんずちゃん（美雲あんず）\n このキャラクターの使用はこのアプリのみとし、商用利用致しません \n ©GMO Internet, Inc. 2012";
    copywrite.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:copywrite];

    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbutton.frame = CGRectMake(screenSize.width*0.4, screenSize.height*0.6, screenSize.width*0.2, screenSize.height*0.4);

                    
    [backbutton setTitle:@"戻る" forState:UIControlStateNormal];
    
    [backbutton addTarget:self
                    action:@selector(backButton_pushed:)
          forControlEvents:UIControlEventTouchUpInside];
    

    
    [self.view addSubview:backbutton];
    // Do any additional setup after loading the view.
}

-(void)backButton_pushed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];

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
