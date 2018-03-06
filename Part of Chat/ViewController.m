//
//  ViewController.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "ViewController.h"
#import "ChatSessionViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    ChatSessionViewController * chatSessionVC = [[ChatSessionViewController alloc]init];
//    [self addChildViewController:chatSessionVC];
//    chatSessionVC.view.frame = self.view.bounds;
//    [self.view addSubview:chatSessionVC.view];
    

    
    
}
- (IBAction)action:(id)sender {
    ChatSessionViewController * chatSessionVC = [[ChatSessionViewController alloc]initWithNibName:@"ChatSessionViewController" bundle:nil];
    chatSessionVC.count =[self.textFiled.text integerValue];
    [self.navigationController pushViewController:chatSessionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
