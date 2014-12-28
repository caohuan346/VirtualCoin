//
//  QCSlideSwitchView.h
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol QCSlideSwitchViewDelegate;
@interface QCSlideSwitchViewChanged : UIView<UIScrollViewDelegate>
{
    UIScrollView *_rootScrollView;                  //主视图
    UIScrollView *_topScrollView;                   //顶部页签视图
    
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    
    UIImageView *_shadowImageView;
    UIImage *_shadowImage;
    
    UIColor *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIButton *_rigthSideButton;                     //右侧按钮
    UIView *_boarderView;                           //tabbar下面的分割线
    
    __weak id<QCSlideSwitchViewDelegate> _slideSwitchViewDelegate;
    
    NSMutableArray *_btnsContentWidthArr;           //缓存btns的内容长度
    float _widthDelta;                              //用来判断按钮是放不完还是挤不满
    float _additionWidth;                           //填不满，则为每个btn的宽度增加widthDelta/[_viewArray count]的长度
    CGFloat _topScrollViewContentWidth;             //记录tabbar所有btns间隔加上btns内容宽度的总宽度
    
    NSMutableDictionary *_btnViewsDic;              //存放btns供创建btns自动布局约束用
    NSArray *_panelViewHCons;                       //_topPanelView的水平方向的约束
    NSArray *_btnHCons;                             //btns的水平方向的约束
}

@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIView *topPanelView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, weak) IBOutlet id<QCSlideSwitchViewDelegate> slideSwitchViewDelegate;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) IBOutlet UIButton *rigthSideButton;
@property (nonatomic, strong) NSArray *badgeViewColorsArr;

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI;

/*!
 * @method 创建带BadgeView的子视图UI
 * @abstract
 * @discussion
 * @param 需要带BadgeView的button的index：0，1，2...
 * @result
 */
- (void)buildUIWithBadgeViewOnButtons:(NSArray *)indexArr;

/*!
 * @method 设置某个button上BadgeView的值
 * @abstract
 * @discussion
 * @param 
 * @result
 */
- (void)setBadgeViewIndex:(NSInteger)index value:(NSInteger)value;

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

@protocol QCSlideSwitchViewDelegate <NSObject>

@required

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(QCSlideSwitchViewChanged *)view;

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(QCSlideSwitchViewChanged *)view viewOfTab:(NSUInteger)number;

@optional

/*!
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(QCSlideSwitchViewChanged *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(QCSlideSwitchViewChanged *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result
 */
- (void)slideSwitchView:(QCSlideSwitchViewChanged *)view didselectTab:(NSUInteger)number;

@end

