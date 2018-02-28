//
//  TYNewsCell.m
//  GitPeep
//
//  Created by IGEN-TECH on 2018/2/26.
//  Copyright © 2018年 tianyao. All rights reserved.
//

#import "TYNewsCell.h"

#import "TYNewsItemViewModel.h"

@interface TYNewsCell ()

@property (nonatomic, strong) TYNewsItemViewModel *viewModel;

@end

@implementation TYNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *avatarButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 68, 68)];
        avatarButton.backgroundColor = [UIColor redColor];
        avatarButton.layer.cornerRadius = 3.f;
        avatarButton.layer.masksToBounds = YES;
        [self.contentView addSubview:avatarButton];
        
        [avatarButton addTarget:self action:@selector(didClickAvatarButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.top = 10;
        detailLabel.left = avatarButton.right + 5;
        detailLabel.width = SCREEN_WIDTH - 10 - 68 - 5 - 10;
        detailLabel.height = 48;
        detailLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:detailLabel];
        
//        YYLabel *detailLabel = [[YYLabel alloc] init];
//        detailLabel.top = 10;
//        detailLabel.left = avatarButton.right + 5;
//        detailLabel.width = SCREEN_WIDTH - 10 - 68 - 5 - 10;
//        detailLabel.displaysAsynchronously = YES;
//        detailLabel.ignoreCommonProperties = YES;
//        [self.contentView addSubview:detailLabel];
//
//        @weakify(self);
//        detailLabel.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            @strongify(self);
//
//            text = [text attributedSubstringFromRange:range];
//
//            NSDictionary *attributes = [text attributesAtIndex:0 effectiveRange:NULL];
//            NSURL *url = attributes[@"1"];
//
//            [self.viewModel.didClickLinkCommand execute:url];
//        } ;
        
//        UILabel *attrLabel = [UILabel labelWithText:@"xxxxxx" frame:CGRectMake(10, 5, 100, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
//        self.attrLabel = attrLabel;
//        [self.contentView addSubview:attrLabel];
//
//        UILabel *timeLabel = [UILabel labelWithText:@"2000.1.14" frame:CGRectMake(120, 5, 60, 40) font:[UIFont systemFontOfSize:15.f] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
//        self.timeLabel = timeLabel;
//        [self.contentView addSubview:timeLabel];
        
//        RAC(attrLabel, text) = RACObserve(self.viewModel, title);
//        RAC(timeLabel, text) = RACObserve(self.viewModel, time);
    }
    return self;
}

- (void)bindViewModel:(TYNewsItemViewModel *)viewModel {
    
    self.viewModel = viewModel;
    // 处理其他
}

- (IBAction)didClickAvatarButton:(id)sender {
    
    [self.viewModel.didClickLinkCommand execute:[NSURL URLWithString:@"2"]];
}

@end
