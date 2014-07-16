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
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(120, 400, 80, 20);
    
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    
    
    
    UIDatePicker *datepicker = [[UIDatePicker alloc] init];
    
    datepicker.datePickerMode = UIDatePickerModeTime;
    datepicker.minuteInterval = 1;
    datepicker.frame = CGRectMake(35, 100, 250, 100);
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
