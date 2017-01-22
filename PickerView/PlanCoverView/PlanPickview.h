//
//  PlanPickview.h
//  PickerView
//
//  Created by 薛林 on 17/1/22.
//  Copyright © 2017年 xuelin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlanViewDelegate <NSObject>
@optional
/**
 *  设置计划
 */
- (void)learnPalnRateOneDay:(NSString *)planNum;

@end
@interface PlanPickview : UIView

@property (nonatomic, weak) id<PlanViewDelegate> delegate;
@end
