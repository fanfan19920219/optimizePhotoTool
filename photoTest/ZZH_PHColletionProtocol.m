//
//  ZZH_PHColletionProtocol.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHColletionProtocol.h"
#import <Photos/Photos.h>

@implementation ZZH_PHColletionProtocol
#pragma mark - collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView.tag;
}

//collection的代理方法
- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    PHAsset *asset = [self.asstes objectAtIndex:indexPath.item];
    [ZZHPHOTOTOOL get_Aphoto:asset withPhotoSize:CGSizeMake(100, 100) withReturnBlock:^(UIImage *returnImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ZZH_PHCellImageView *imageView = [[ZZH_PHCellImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            [imageView setSelectButtonFrame];
            imageView.tag = indexPath.item;
            imageView.delegate = self;
            imageView.image = returnImage;
            imageView.asset = asset;
            [cell.contentView addSubview:imageView];
            for(ZZH_PHCellImageView *cacheImageView in self.cacheArray){
                if([cacheImageView.asset.localIdentifier isEqual:asset.localIdentifier]){
                    imageView.selectButton.selected = YES;
                    imageView.showNumLabel.text = [NSString stringWithFormat:@"%lu",[self.cacheArray indexOfObject:cacheImageView]+1];
                    break;
                }
            }
        });
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showWithStatus:@"加载照片中"];
    PHAsset *currentAssets = [self.asstes objectAtIndex:indexPath.item];
    [[ZZH_PH_GetAssetObject Default]get_Aphoto:currentAssets original:YES withReturnBlock:^(UIImage *returnImage) {
        @try {
            ZZH_PHShowPhotoController *showPhotoViewController = [[ZZH_PHShowPhotoController alloc]init];
            showPhotoViewController.showImage = returnImage;
            showPhotoViewController.currentIndex = self.cacheArray.count;
            showPhotoViewController.ImageArray = self.cacheArray;
            for(ZZH_PHCellImageView *judgmentView in self.cacheArray){
                if([judgmentView.asset.localIdentifier isEqualToString:currentAssets.localIdentifier]){
                    showPhotoViewController.currentIndex = [self showPhotoViewControllerIndex:judgmentView];
                    break;
                }
            }
            [SVProgressHUD dismiss];
            [self.delegate collectionViewPush:showPhotoViewController withParameter:nil];
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
}

-(NSInteger)showPhotoViewControllerIndex:(ZZH_PHCellImageView*)judgmentImageView{
    NSInteger currentindex = 0;
    for(ZZH_PHCellImageView *ImageView in self.cacheArray){
        if(ImageView.tag>judgmentImageView.tag){
            currentindex++;
        }
    }
    return self.cacheArray.count - currentindex -1;
}

#pragma mark ::::::::::::::::::::selectButtonDelegatemethod:::::::::::::::::::
-(void)cellSelectButtonClick:(UIButton *)sender andZZH_PHCellImageView:(id)imageView andIndex:(NSInteger)index orClick:(BOOL)orClick{
    
    [self.dataSource addOrDelete:sender withObject:imageView AndButton:sender];
    [self.delegate refreshNumLabel];
    if(sender.selected==NO){
        [self.delegate refreshNum];
    }
}


@end
