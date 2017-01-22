//
//  StrokeLabel.h
//  PickerView
//
//  Created by 薛林 on 17/1/22.
//  Copyright © 2017年 xuelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeLabel : UILabel
//重写文字绘制方法，描边文字
- (void)drawTextInRect:(CGRect)rect;
@end
