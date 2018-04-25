//
//  ZZH_PHListCell.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/28.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHListCell.h"
#define IMAGE_SIZE 70.f
#define LABEL_RECT CGRectMake(IMAGE_SIZE + 10 + 20, 30, 180, 20)
#define NUMLABEL_RECT CGRectMake(180, 20,100, 20)

@implementation ZZH_PHListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self){
        self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        self.celImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10)];
        self.AlbumNameLabel  = [[UILabel alloc]init];
        self.numbersLabel      = [[UILabel alloc]init];
        [self.contentView addSubview:self.celImageView];
        [self.contentView addSubview:self.AlbumNameLabel];
//        [self.contentView addSubview:self.numbersLabel];
    }
    return  self;
}

-(void)setImage:(UIImage*)image AndAlbumName:(NSString *)titleString  AndNum:(NSString*)num{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.celImageView.frame = CGRectMake(18, 8, IMAGE_SIZE ,IMAGE_SIZE);
        self.celImageView.image = image;
        self.AlbumNameLabel.frame = LABEL_RECT;
//        self.AlbumNameLabel.backgroundColor = [UIColor redColor];
        self.AlbumNameLabel.textColor = [UIColor darkGrayColor];
        self.AlbumNameLabel.text = [NSString stringWithFormat:@"%@  (%@)",titleString,num];
        self.AlbumNameLabel.center = CGPointMake(self.AlbumNameLabel.center.x, 45);
        self.numbersLabel.frame = NUMLABEL_RECT;
        self.numbersLabel.center = CGPointMake(self.numbersLabel.center.x, 70);
        //self.numbersLabel.text = [NSString stringWithFormat:@"(%@)",num];
        self.numbersLabel.textColor = [UIColor lightGrayColor];
    });
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
