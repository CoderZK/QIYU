//
//  CustomEmojiView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "CustomEmojiView.h"

@interface CustomEmojiView () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CustomEmojiView
{
    NSArray *emojiArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        emojiArray = [self defaultEmoticons];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(30, 30);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    //每个分区的左右边距
    CGFloat sectionOffset = (ScreenW - 8 * 30 - 7 * 15) / 2;
    //分区内容偏移
    layout.sectionInset = UIEdgeInsetsMake(30, sectionOffset, 30, sectionOffset);
    
    UICollectionView *myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 50) collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    myCollectionView.bounces = NO;
    myCollectionView.pagingEnabled = YES;
    myCollectionView.showsVerticalScrollIndicator = NO;
    myCollectionView.showsHorizontalScrollIndicator = NO;
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"emojiCell"];
    [self addSubview:myCollectionView];
    
    UIView *emojiFooter = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
    emojiFooter.backgroundColor = [UIColor whiteColor];
    [self addSubview:emojiFooter];
    
    UIButton *sendEmojiBtn = [[UIButton alloc]initWithFrame:CGRectMake(emojiFooter.frame.size.width - 70, 0, 70, emojiFooter.frame.size.height)];
    [sendEmojiBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendEmojiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendEmojiBtn.backgroundColor = [UIColor redColor];
    [emojiFooter addSubview:sendEmojiBtn];
    [sendEmojiBtn addTarget:self action:@selector(sendEmoji) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return (emojiArray.count / 24) + (emojiArray.count % 24 == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (((emojiArray.count / 24) + (emojiArray.count % 24 == 0 ? 0 : 1)) != section + 1) {
        return 24;
    }else {
        return emojiArray.count - 24 * section;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"emojiCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc]init];
    }
    
    [self setCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)setCell:(UICollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *emojiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    emojiLabel.text = emojiArray[indexPath.section * 24 + indexPath.row];
    emojiLabel.font = [UIFont systemFontOfSize:25];
    [cell.contentView addSubview:emojiLabel];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *emojiStr = emojiArray[indexPath.section * 24 + indexPath.row];
    //NSLog(@"表情 %@", emojiStr);
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickEmojiLabel:)]) {
        [self.delegate didClickEmojiLabel:emojiStr];
    }
}

//发送表情
- (void)sendEmoji {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSendEmojiBtn)]) {
        [self.delegate didClickSendEmojiBtn];
    }
}

//表情包
- (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0x1F600; i <= 0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}

@end


