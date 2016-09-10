//
//  ColorGameView.m
//  色差游戏
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ColorGameView.h"

@interface ColorGameView () <UICollectionViewDataSource, UICollectionViewDelegate> {

    UICollectionViewFlowLayout *_layout;
    UICollectionView *_collectionView;
    NSInteger _num;
    float _alpha;
    float _colorFactorR;
    float _colorFactorG;
    float _colorFactorB;
    NSInteger _happenNum;

}



@end

@implementation ColorGameView

- (instancetype)initWithFrame:(CGRect)frame {

    CGRect rect = CGRectMake(0, (667-375)/2, 375, 375);
    self = [super initWithFrame:rect];
    if (self != nil) {
        _alpha = 0.6;
        _count = 0;
        _num = 4;
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 375) collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.cornerRadius = 10;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        [self addSubview:_collectionView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:@"start"
                                                   object:nil];
    }
    return self;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _colorFactorR = arc4random()%10*0.1;
    _colorFactorG = arc4random()%10*0.1;
    _colorFactorB = arc4random()%10*0.1;
    _happenNum = arc4random()%_num;
    _alpha += 0.01;
    if (_alpha >= 0.95) {
        _alpha = 0.95;
    }
    if (_count == 0) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/2-10, self.frame.size.height/2-10);
        _count++;
        _num = 4;
        return 4;
    } else if (_count == 1) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/3-10, self.frame.size.height/3-10);
        _count++;
        _num = 9;
        return 9;
    } else if (_count == 2) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/4-10, self.frame.size.height/4-10);
        _count++;
        _num = 16;
        return 16;
    } else if (_count == 3 | _count == 4) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/5-10, self.frame.size.height/5-10);
        _count++;
        _num = 25;
        return 25;
    } else if (_count == 5 | _count == 6) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/6-10, self.frame.size.height/6-10);
        _count++;
        _num = 36;
        return 36;
    } else if (_count == 7 | _count == 8 | _count == 9) {
        _layout.itemSize = CGSizeMake(self.frame.size.height/7-10, self.frame.size.height/7-10);
        _count++;
        _num = 49;
        return 49;
    } else {
        _layout.itemSize = CGSizeMake(self.frame.size.height/8-10, self.frame.size.height/8-10);
        _count++;
        _num = 64;
        return 64;
    }
    

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = [UIColor colorWithRed:_colorFactorR green:_colorFactorG blue:_colorFactorB alpha:1];
    if (indexPath.item == _happenNum) {
        cell.backgroundColor = [UIColor colorWithRed:_colorFactorR green:_colorFactorG blue:_colorFactorB alpha:_alpha];
    }
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == _happenNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"count" object:[NSString stringWithFormat:@"%ld", _count]];
        [_collectionView reloadData];
    } else {
        //点错了就终止游戏
        //self.userInteractionEnabled = NO;
        
    }

}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(5, 0, 0, 0);

}

- (void)receiveNotification:(NSNotification *)notification {
    //设置为初始状态
    _alpha = 0.6;
    _count = 0;
    _num = 4;
    [_collectionView reloadData];
}

































@end
