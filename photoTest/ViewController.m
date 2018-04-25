//
//  ViewController.m
//  photoTest
//
//  Created by Star J on 2018/4/25.
//  Copyright © 2018年 Star J. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "ZZH_PHRootViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic , strong)NSMutableArray *collectionArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _collectionArray = [[NSMutableArray alloc]init];
    
    
}

- (IBAction)getPhoto:(UIButton *)sender {
//    [self getphotoInformation];
    ZZH_PHRootViewController *rootVC = [[ZZH_PHRootViewController alloc]init];
    rootVC.maxIndex = 10;
    [self presentViewController:rootVC animated:YES completion:^{
        
    }];
}
- (IBAction)getCollectionPhoto:(UIButton *)sender {
    
    
}


-(void)getphotoInformation{
    PHFetchResult<PHAssetCollection *> *assetCollectionsSystem = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    //    NSInteger index = [assetCollections countOfAssetsWithMediaType:PHAssetMediaTypeAudio];
    //    NSLog(@"index --- %ld",(long)index);
    
    //array
    NSMutableArray *listArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *collectionArray =[[NSMutableArray alloc]init];
    
    for (PHAssetCollection *assetCollection in assetCollectionsSystem) {
        [collectionArray addObject:assetCollection];
        
        NSLog(@"asset.name -- %@",assetCollection.localizedTitle);
        
        NSLog(@"collection.coiunt --- %@",assetCollection.localizedLocationNames);
        [_collectionArray addObject:assetCollection];
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        NSLog(@"assets.count --- %lu",(unsigned long)assets.count);
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.networkAccessAllowed = YES;
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:assets.lastObject targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"image --- %@",result);
        }];
        
        
        
    }
    
    
    
    
}

//////////////////////////////////////////////////////////////////
-(void)getCurrentPhoto:(PHAssetCollection*)collection{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
//    NSLog(@"asset.localIdentifier --- %@",asset.localIdentifier);
    // 是否要原图
    CGSize size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    // 从asset中获得图片
//    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:
//     PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary *
//                                                               _Nullable info)
//     {
//         NSLog(@"%@ ---- info ----- ", result);
//     }];
    
}




//////////////////////////////////////////////////////////////////
- (void)get_Aphoto:(PHAsset *)asset original:(BOOL)original withReturnBlock:(void(^)(UIImage  *returnImage))returnBlock{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    NSLog(@"asset.localIdentifier --- %@",asset.localIdentifier);
    // 是否要原图
    CGSize size = original ? CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) : CGSizeZero;
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:
     PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary *
                                                               _Nullable info)
     {
         NSLog(@"%@ ---- info ----- ", result);
         returnBlock(result);
     }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
