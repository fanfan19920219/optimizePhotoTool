//
//  ZZH_PHCellImageView.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//
#define BUTTON_SIZE 44.f

#define BUTTON_ANIMATION_SCALE 1.3f

#define BUTTON_ANIMATION_DURATION 0.1f

#define SELECTIMAGENAME @"selete@2x.png"

#define SELECTEDIMAGENAME @"seleted@2x.png"

#define DEFALUT_COLOR RGBA(188, 163, 114, 1)


#import "ZZH_PHCellImageView.h"

@interface ZZH_PHCellImageView()



@end

@implementation ZZH_PHCellImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.selectButton.backgroundColor = [UIColor blackColor];
        self.selectButton.frame = CGRectMake(self.frame.size.width-BUTTON_SIZE - 5, 5, BUTTON_SIZE, BUTTON_SIZE);
//        self.selectButton.backgroundColor = [UIColor whiteColor];
        self.selectButton.selected = NO;
        [self.selectButton addTarget:self action:@selector(selectButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        self.showNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(BUTTON_SIZE - 30, 5, 25, 25)];
        self.showNumLabel.layer.cornerRadius = self.showNumLabel.frame.size.width/2.f;
        self.showNumLabel.clipsToBounds = YES;
        self.showNumLabel.backgroundColor = [UIColor whiteColor];
        self.showNumLabel.textAlignment = NSTextAlignmentCenter;
        self.showNumLabel.textColor = DEFALUT_COLOR;
        [self.selectButton addSubview:self.showNumLabel];
        
        
//        [self.selectButton setImage: [UIImage imageNamed:SELECTIMAGENAME] forState:UIControlStateNormal];
//        [self.selectButton setImage:[UIImage imageNamed:SELECTEDIMAGENAME] forState:UIControlStateSelected];
        [self.selectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 15, -10)];
        [self addSubview:self.selectButton];
    }
    return self;
}

-(void)setSelectButtonFrame{
    self.selectButton.frame = CGRectMake(self.frame.size.width-BUTTON_SIZE -5, 5, BUTTON_SIZE, BUTTON_SIZE);
    [self addSubview:self.selectButton];
}

-(void)selectButtonMethod:(UIButton*)sender {
    ZZH_PHCellImageView *selectView = (ZZH_PHCellImageView*)[sender superview];
    
    
    [self.delegate cellSelectButtonClick:sender andZZH_PHCellImageView:selectView andIndex:selectView.tag orClick:sender.selected];
//    sender.selected = !sender.selected;
//    if(sender.selected){
//        [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
//            sender.transform =CGAffineTransformScale(sender.transform, BUTTON_ANIMATION_SCALE, BUTTON_ANIMATION_SCALE);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
//                sender.transform=CGAffineTransformIdentity;
//            }];
//        }];
//    }
}



@end
