//
//  PlanPickview.m
//  PickerView
//
//  Created by 薛林 on 17/1/22.
//  Copyright © 2017年 xuelin. All rights reserved.
//

#import "PlanPickview.h"
#import "StrokeLabel.h"
#import "Masonry.h"

@interface PlanPickview ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIImageView *imgView;//顶部图片
@property (nonatomic, strong) StrokeLabel *titleLabel;//标题
@property (nonatomic, strong) UIImageView *laBaImgView;//喇叭
@property (nonatomic, strong) UILabel *dayCount;//每天练习几关
@property (nonatomic, strong) UIButton *sureBtn;//确定按钮
@property (nonatomic, strong) UIPickerView *pickerView;//滚动关数
@property (nonatomic, strong) NSArray *numbers;//数字数组
@property (nonatomic, strong) UILabel *numLabel;//记录关数的label
@property (nonatomic, assign) NSInteger row;

@end

@implementation PlanPickview
//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - pickerViewDateSource
//几组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.numbers.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.numbers[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //设置数字
    self.numLabel.attributedText = [self addAttribute:self.numbers[row] fontName:@"FZMiaoWuS-GB" fontSize:25];
    self.row = row;
    NSLog(@"每天练习%@关",self.numbers[row]);
}
//更改pickerView字体颜色及大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont fontWithName:@"FZMiaoWuS-GB" size:30];
        pickerLabel.textColor = [UIColor colorWithRed:0.18 green:0.64 blue:0.40 alpha:1.00];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    //去除分割线
    [self removeLine:pickerView];
    return pickerLabel;
}

//取出分割线
- (void)removeLine:(UIPickerView *)pickerView {
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 2) {
            [obj removeFromSuperview];
        }
        
    }];
}


//设置字体及文本形式的内容
- (NSMutableAttributedString *)addAttribute:(NSString *)String fontName:(NSString *)fontName fontSize:(int) fontSize {
    NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:String];
    [atrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:fontSize] range:NSMakeRange(0,atrStr.length)];
    return atrStr;
}

#pragma mark - 点击事件
- (void)setPlanAction {
    if ([self.delegate respondsToSelector:@selector(learnPalnRateOneDay:)]) {
        [self.delegate learnPalnRateOneDay:self.numbers[self.row]];
    }
    
}

//设置UI
- (void)setUpUI {
    self.backgroundColor = [UIColor colorWithRed:0.91 green:1.00 blue:0.95 alpha:1.00];
    //圆角
    self.layer.cornerRadius = 20;
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.laBaImgView];
    [self addSubview:self.sureBtn];
    [self addSubview:self.pickerView];
    [self addSubview:self.dayCount];
    [self addSubview:self.numLabel];
}

//布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-50);
        make.centerX.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.leading.trailing.equalTo(self);
    }];
    [self.laBaImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(45);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-15);
        make.centerX.equalTo(self);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laBaImgView).offset(-50);
        make.leading.equalTo(self.laBaImgView).offset(150);
        make.size.mas_equalTo(CGSizeMake(32, 130));
    }];
    [self.dayCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laBaImgView);
        make.leading.equalTo(self.laBaImgView.mas_trailing).offset(18);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laBaImgView);
        make.leading.equalTo(self.laBaImgView.mas_trailing).offset(120);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
}
#pragma mark - 懒加载
//小熊猫
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kemu_plan_look"]];
        [_imgView sizeToFit];
    }
    return _imgView;
}
//标题
- (StrokeLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[StrokeLabel alloc] initWithFrame:CGRectMake(0, 0, 275, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:@"主银，快来制定学习计划！"];
        //需要设置的位置
        [atrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"FZMiaoWuS-GB" size:23] range:NSMakeRange(0, 3)];
        [atrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"FZMiaoWuS-GB" size:18] range:NSMakeRange(3, 9)];
        _titleLabel.attributedText = atrStr;
        _titleLabel.textColor = [UIColor whiteColor];
        
    }
    return _titleLabel;
}
//小喇叭
- (UIImageView *)laBaImgView {
    if (!_laBaImgView) {
        _laBaImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kemu_plan_laba"]];
        [_laBaImgView sizeToFit];
    }
    return _laBaImgView;
}

//确定
-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        NSString *str = @"朕恩准!";
        NSMutableAttributedString *atrStr = [[NSMutableAttributedString alloc] initWithString:str];
        //需要设置的位置
        [atrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"FZMiaoWuS-GB" size:18] range:NSMakeRange(0, 3)];
        [atrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        [_sureBtn setAttributedTitle:atrStr forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"kemu_plan_sure"] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(setPlanAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
//每天练习标签
- (UILabel *)dayCount {
    if (!_dayCount) {
        _dayCount = [[UILabel alloc] init];
        _dayCount.textColor = [UIColor colorWithRed:0.18 green:0.64 blue:0.40 alpha:1.00];
        _dayCount.textAlignment = NSTextAlignmentCenter;
        _dayCount.attributedText =  [self addAttribute:@"每天练习      关" fontName:@"FZMiaoWuS-GB" fontSize:23];
    }
    return _dayCount;
}

//pickerView
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
//numbers
- (NSArray *)numbers {
    if (!_numbers) {
        _numbers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    }
    return _numbers;
}
//关数
- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.backgroundColor = [UIColor colorWithRed:1.00 green:0.87 blue:0.20 alpha:1.00];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.attributedText = [self addAttribute:@"1" fontName:@"FZMiaoWuS-GB" fontSize:28];
        _numLabel.layer.cornerRadius = 14;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _numLabel.layer.borderWidth = 1;
        _numLabel.userInteractionEnabled = NO;
        
    }
    return _numLabel;
}


@end
