//
//  LLRockerView.m
//  Pods-LLRocker
//
//  Created by Lilong on 2018/2/24.
//

#import "LLRockerView.h"
#define kRadius ([self bounds].size.width * 0.5f)
#define kTrackRadius kRadius * 0.8f

@interface LLRockerView ()

@property (strong, nonatomic) UIImageView *handleImageView;
@end

@implementation LLRockerView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self setRockerStyle:RockStyleOpaque];
    _direction = RockDirectionCenter;
    if (!_handleImageView) {
        UIImage *handleImage = [UIImage imageNamed:@"handlePressed"];
        
        _handleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.5f-handleImage.size.width*0.5f,
                                                                         self.bounds.size.height*0.5f-handleImage.size.height*0.5f,
                                                                         handleImage.size.width,
                                                                         handleImage.size.height)];
        _handleImageView.image = handleImage;
        [self addSubview:_handleImageView];
    }
    _x = 0;
    _y = 0;
}
- (void)setRockerStyle:(RockStyle)style{
    NSArray *imageNames = @[@"rockerOpaqueBg",@"rockerTranslucentBg"];
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageNames[style]]]];
}

- (void)resetHandle{
    _handleImageView.image = [UIImage imageNamed:@"handleNormal"];
    _x = 0.0;
    _y = 0.0;
    CGRect handleImageFrame = [_handleImageView frame];
    handleImageFrame.origin = CGPointMake(([self bounds].size.width - [_handleImageView bounds].size.width) * 0.5f,
                                          ([self bounds].size.height - [_handleImageView bounds].size.height) * 0.5f);
    [_handleImageView setFrame:handleImageFrame];
}

- (void)setHandlePositionWithLocation:(CGPoint)location{
    _x = location.x - kRadius;
    _y = -(location.y - kRadius);
    float r = sqrt(_x * _x + _y * _y);
    if (r >= kTrackRadius) {
        _x = kTrackRadius * (_x / r);
        _y = kTrackRadius * (_y / r);
        location.x = _x + kRadius;
        location.y = -_y + kRadius;
        [self rockerValueChanged];
    }
    CGRect handleImageFrame = [_handleImageView frame];
    handleImageFrame.origin = CGPointMake(location.x - ([_handleImageView bounds].size.width * 0.5f),
                                          location.y - ([_handleImageView bounds].size.width * 0.5f));
    [_handleImageView setFrame:handleImageFrame];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _handleImageView.image = [UIImage imageNamed:@"handlePressed"];
    CGPoint location = [[touches anyObject] locationInView:self];
    [self setHandlePositionWithLocation:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self];
    [self setHandlePositionWithLocation:location];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resetHandle];
    [self rockerValueChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resetHandle];
    [self rockerValueChanged];
}

- (void)rockerValueChanged{
    NSInteger rockerDirection = -1;
    float arc = atan2f(_y,_x);
    if ((arc > (3.0f/4.0f)*M_PI &&  arc < M_PI) || (arc < -(3.0f/4.0f)*M_PI &&  arc > -M_PI)) {
        rockerDirection = RockDirectionLeft;
    }else if (arc > (1.0f/4.0f)*M_PI &&  arc < (3.0f/4.0f)*M_PI) {
        rockerDirection = RockDirectionUp;
    }else if ((arc > 0 &&  arc < (1.0f/4.0f)*M_PI) || (arc < 0 &&  arc > -(1.0f/4.0f)*M_PI)) {
        rockerDirection = RockDirectionRight;
    }else if (arc > -(3.0f/4.0f)*M_PI &&  arc < -(1.0f/4.0f)*M_PI) {
        rockerDirection = RockDirectionDown;
    }else if (0 == _x && 0 == _y)
    {
        rockerDirection = RockDirectionCenter;
    }
    if (self.rockerDidChangeOriginBlock) {
        self.rockerDidChangeOriginBlock(_x, _y);
    }
//    NSLog(@"------y = %zd  x = %zd",_y,_x);
    if (-1 != rockerDirection && rockerDirection != _direction) {
        _direction = rockerDirection;
        if (self.rockerDidChangeDirectionBlock) {
            self.rockerDidChangeDirectionBlock(_direction);
        }
        if ([self.delegate respondsToSelector:@selector(rockerDidChangeDirection:)]) {
            [self.delegate rockerDidChangeDirection:self];
        }
    }
}

@end
