//
//  CustomEmojiView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomEmojiDelegate;

@interface CustomEmojiView : UIView

@property (nonatomic, weak) id<CustomEmojiDelegate> delegate;

@end

@protocol CustomEmojiDelegate <NSObject>

@optional

- (void)didClickEmojiLabel:(NSString *)emojiStr;

- (void)didClickSendEmojiBtn;

@end

