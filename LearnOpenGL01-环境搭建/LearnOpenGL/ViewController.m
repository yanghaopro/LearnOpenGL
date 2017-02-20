//
//  ViewController.m
//  LearnOpenGL
//
//  Created by yanghao on 2017/2/20.
//  Copyright © 2017年 yanghao. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view = [[OpenGLView alloc]initWithFrame:self.view.bounds];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
