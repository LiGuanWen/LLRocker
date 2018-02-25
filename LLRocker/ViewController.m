//
//  ViewController.m
//  LLRocker
//
//  Created by Lilong on 2018/2/24.
//  Copyright © 2018年 第七代目. All rights reserved.
//

#import "ViewController.h"
#import "LLRockerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet LLRockerView *rockerView;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.directionLabel.text = @"Center";
    
    [self.rockerView setRockerStyle:RockStyleOpaque];

    self.rockerView.rockerDidChangeOriginBlock = ^(CGFloat x, CGFloat y) {
        NSLog(@"  x = %zd y = %zd",x,y);
    };
    NSArray *directios = @[@"Left",@"Up",@"Right",@"Down",@"Center"];
    __weak typeof (self) weakSelf = self;
    self.rockerView.rockerDidChangeDirectionBlock = ^(RockDirection direction) {
        NSLog(@"Direction : %ld",(long)direction);
        weakSelf.directionLabel.text = directios[direction];
    };
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
