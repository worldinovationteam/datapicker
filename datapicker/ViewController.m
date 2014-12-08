//
//  ViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/06/26.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import "ViewController.h"
#import "ClockViewController.h"

@interface ViewController ()



@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if([self isiPhone5]){
        UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        backGroundImage.image = [UIImage imageNamed:@"haikei.png"];
        [self.view addSubview:backGroundImage];
        
        UIImageView *anzu = [[UIImageView alloc] initWithFrame:CGRectMake(-30, 610-364, 241, 309)];
        anzu.image = [UIImage imageNamed:@"apurigazou.png"];
        [self.view addSubview:anzu];
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((320-279)/2, 20, 279, 74)];
        logo.image = [UIImage imageNamed:@"logo2.png"];
        [self.view addSubview:logo];
        
                
    }else if ([self isiPhone4]) {
        UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        backGroundImage.image = [UIImage imageNamed:@"haikei.png"];
        [self.view addSubview:backGroundImage];
        
        
        UIImageView *anzu = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 610-364, 169, 216)];
        anzu.image = [UIImage imageNamed:@"apurigazou.png"];
        [self.view addSubview:anzu];
        
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((320-279)/2, 20, 279, 74)];
        logo.image = [UIImage imageNamed:@"logo2.png"];
        [self.view addSubview:logo];
        
        
    }else{
        UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        backGroundImage.image = [UIImage imageNamed:@"haikei.png"];
        [self.view addSubview:backGroundImage];
        
        UIImageView *anzu = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 610-364, 169, 216)];
        anzu.image = [UIImage imageNamed:@"apurigazou.png"];
        [self.view addSubview:anzu];
        
        
        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((320-279)/2, 20, 279, 74)];
        logo.image = [UIImage imageNamed:@"logo2.png"];
        [self.view addSubview:logo];
    }
        
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(100, 240, 120, 20);
    startButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    startButton.layer.borderWidth = 1.0f;
    startButton.layer.cornerRadius = startButton.frame.size.height/2.0;
    
    startButton.layer.shadowOpacity = 0.2;
    startButton.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    
    [startButton setTitle:@"アラームセット" forState:UIControlStateNormal];
    
    
    
    UIDatePicker *datepicker = [[UIDatePicker alloc] init];
    
    datepicker.datePickerMode = UIDatePickerModeTime;
    datepicker.minuteInterval = 1;
    datepicker.frame = CGRectMake(35, 80, 250, 100);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    _arguments = [df stringFromDate:datepicker.date];
    
    NSLog(@"%@",_arguments);

    
    
    [datepicker addTarget:self
                   action:@selector(datePicker_ValueChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    [startButton addTarget:self
                    action:@selector(startButton_pushed:)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:datepicker];
    [self.view addSubview:startButton];
    
}

-(void)datePicker_ValueChanged:(id)sender{
    UIDatePicker *datepicker = sender;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    _arguments = [df stringFromDate:datepicker.date];
    
    
    NSLog(@"%@",_arguments);
}

-(void)startButton_pushed:(id)sender{
    ClockViewController *clockview = [self.storyboard instantiateViewControllerWithIdentifier:@"ClockView"];
    clockview.arguments = _arguments;
    clockview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:clockview animated:YES completion:nil];
    
}

- (NSString *)iOSDevice
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            if(result.height == 960){
                return (@"iPhone4");
            }
            if(result.height == 1136){
                return (@"iPhone5");
            }
            if (result.height == 1334) {
                return (@"iphone6");
            }
            if (result.height == 2208) {
                return (@"iphone6_plus");
            }
        } else {
            return (@"iPhone3");
        }
    } else {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            return (@"iPad Retina");
        } else {
            return (@"iPad");
        }
    }
    return (@"unknown");
}

- (BOOL) isiPhone6_plus
{
    return ([[self iOSDevice] isEqualToString:@"iPhone6_plus"]);
}

- (BOOL) isiPhone6
{
    return ([[self iOSDevice] isEqualToString:@"iPhone6"]);
}

- (BOOL) isiPhone5
{
    return ([[self iOSDevice] isEqualToString:@"iPhone5"]);
}

- (BOOL) isiPhone4
{
    return ([[self iOSDevice] isEqualToString:@"iPhone4"]);
}

- (BOOL) isiPhone3
{
    return ([[self iOSDevice] isEqualToString:@"iPhone3"]);
}

- (BOOL) isIpad
{
    return ([[self iOSDevice] isEqualToString:@"iPad"]);
}

- (BOOL) isIpadRetina
{
    return ([[self iOSDevice] isEqualToString:@"iPad Retina"]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
