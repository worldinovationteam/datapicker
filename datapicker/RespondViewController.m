//
//  RespondViewController.m
//  WebTest
//
//  Created by nariyuki on 11/22/14.
//  Copyright (c) 2014 Nariyuki Saito. All rights reserved.
//

#import "RespondViewController.h"

@interface RespondViewController ()

@end

@implementation RespondViewController

@synthesize connector;
@synthesize myName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenSize=[[UIScreen mainScreen] bounds].size;
    int buttonheight=screenSize.height*0.1;
    int buttonwidth=buttonheight*3;
    int dropheight=screenSize.height*0.35;
    int dropwidth=screenSize.height*0.5;
    
    UIImageView* bg=[[UIImageView alloc]init];
    bg.image = [UIImage imageNamed:@"background1334.png"];
    bg.frame = CGRectMake(0,0,screenSize.width,screenSize.height);
    [self.view addSubview:bg];
    
    fr=[[UIImageView alloc]init];
    fr.image = [UIImage imageNamed:@"anzu.png"];
    fr.frame = CGRectMake((screenSize.width-dropwidth)*0.5,screenSize.height*0.3,dropwidth,dropheight);
    [self.view addSubview:fr];
    
    call=[UIButton buttonWithType:UIButtonTypeCustom];
    [call setBackgroundImage:[UIImage imageNamed:@"respond.png"] forState:UIControlStateNormal];
    [call addTarget:self action:@selector(startCalling:) forControlEvents:UIControlEventTouchUpInside];
    [call setFrame:CGRectMake((screenSize.width-buttonwidth)*0.5,screenSize.height*0.3+dropheight+10,buttonwidth,buttonheight)];
    [self.view addSubview:call];
    
    hangUp=[UIButton buttonWithType:UIButtonTypeCustom];
    [hangUp setBackgroundImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [hangUp addTarget:self action:@selector(stopCalling:) forControlEvents:UIControlEventTouchUpInside];
    [hangUp setFrame:CGRectMake((screenSize.width-buttonwidth)*0.5,screenSize.height*0.3+dropheight+10,buttonwidth,buttonheight)];
    
    back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [back setFrame:CGRectMake((screenSize.width-buttonwidth)*0.5,screenSize.height*0.3+dropheight+10,buttonwidth,buttonheight)];

    label=[[UILabel alloc]init];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:100.0f];
    label.frame=CGRectMake(screenSize.width*0.15,screenSize.height*0.35,screenSize.width*0.7,screenSize.height*0.1);
    label.text=@"お待ちください...";
    
    UILabel* label2=[[UILabel alloc]init];
    label2.textColor=[UIColor whiteColor];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.adjustsFontSizeToFitWidth=YES;
    label2.font=[UIFont systemFontOfSize:100.0f];
    label2.frame=CGRectMake(screenSize.width*0.0,screenSize.height*0.05,screenSize.width*1.0,screenSize.height*0.35);
    label2.numberOfLines=2;
    label2.text=@"おはようございます！\n あんずちゃんから着信です！";
    [self.view addSubview:label2];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    myName=[ud stringForKey:@"nickName"];
    if(myName==nil){
        myName=@"名無しさん";
    }
}

-(void)connect{
    [NSThread sleepForTimeInterval:1.0f];
    int port=(arc4random()%40000)+1024;
    connector=[[P2PConnector alloc]initWithServerAddr:@"153.121.70.32"
                                           serverPort:5000
                                           clientPort:port
                                             delegate:self
                                                   ID:myName];
    for(int i=0; i<5; i++ ){
        if( [connector findPartner]==NO ){
            if( i==4 ){
                fr.image = [UIImage imageNamed:@"anzuaseri.png"];
                label.numberOfLines=2;
                label.text=@"申し訳ありません\n あんずちゃんは不在です";
                [self.view addSubview:back];
                return;
            }else{
                continue;
            }
        }else{
            break;
        }
    }
    
    if( [connector prepareP2PConnection]==NO ){
        fr.image = [UIImage imageNamed:@"anzuaseri.png"];
        label.numberOfLines=2;
        label.text=@"申し訳ありません\n あんずちゃんは不在です";
        [self.view addSubview:back];
        return;
    }
    
    [connector startWaitingForPartner];
    if([connector flg]==1){
        [connector call];
    }
    
    [connector sendPartnerMessage:@"P2P通信開始！"];
    
    fr.alpha=0.0f;
    NSString* tmp=@"通話中: ";
    label.text=[tmp stringByAppendingString:[connector partnerID]];
    
    [self.view addSubview:hangUp];
}

-(IBAction)startCalling:(id)sender{
    [NSThread detachNewThreadSelector:@selector(connect) toTarget:self withObject:nil];
    [call removeFromSuperview];
    fr.alpha=0.5f;
    [self.view addSubview:label];
}

-(IBAction)stopCalling:(id)sender{
    if( [connector hangUp]==YES ){
        [hangUp removeFromSuperview];
        [self.view addSubview:back];
        label.text=@"通話終了しました";
    }
}

-(IBAction)back:(id)sender{
    ViewController* next=[[ViewController alloc]init];
    next.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:NO completion:^ {
        [self presentViewController:next animated:YES completion:nil];
    }];
}


-(void)didReceiveMessage:(NSString *)message{
    NSLog(@"received message: %@",message);
}

-(void)didReceiveHangUp{
    NSLog(@"partner has hung up");
    [hangUp removeFromSuperview];
    [self.view addSubview:back];
    label.text=@"通話終了しました";
}

-(void)didReceiveCall{
    NSLog(@"received call");
    [connector respond];
}

-(void)didReceiveResponse{
    NSLog(@"partner has responded to call");
}

-(void)didReceiveDisconnection{
    NSLog(@"partner has disconnected");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
