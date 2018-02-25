//
//  LLRockerView.h
//  Pods-LLRocker
//
//  Created by Lilong on 2018/2/24.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RockStyle){
    RockStyleOpaque = 0,
    RockStyleTranslucent
};

typedef NS_ENUM(NSInteger, RockDirection){
    RockDirectionLeft = 0,
    RockDirectionUp,
    RockDirectionRight,
    RockDirectionDown,
    RockDirectionCenter,
};

@protocol LLRockerDelegate;

@interface LLRockerView : UIView
@property (weak ,nonatomic) id <LLRockerDelegate> delegate;
@property (nonatomic, readonly) RockDirection direction;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (copy, nonatomic) void (^rockerDidChangeDirectionBlock)(RockDirection direction);
@property (copy, nonatomic) void (^rockerDidChangeOriginBlock)(CGFloat x,CGFloat y);

- (void)setRockerStyle:(RockStyle)style;

@end


@protocol LLRockerDelegate <NSObject>
@optional
- (void)rockerDidChangeDirection:(LLRockerView *)rocker;
@end
