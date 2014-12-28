//
//  QCSlideSwitchView.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//

#define kButtonsTagBase 100
#define kBadgeViewsTagBase 200
#define kBadgeViewSpaceWithText 0.0f

#import "QCSlideSwitchViewChanged.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin = 0.0f;
static const CGFloat kFontSizeOfTabButton = 17.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation QCSlideSwitchViewChanged
{
    NSMutableArray *_titleTextSizes;//记录title文字的sizes
    NSMutableArray *_badgeViewsArr;
    BOOL _hasBadgeView;
}

#pragma mark - 初始化参数

- (void)initValues
{
    //因为SB是以320的宽度来设计的，因此一开始self.bounds.size.width是320，但是实际的屏幕不一定是这个宽度，在这里先调整self.bounds.size为实际屏幕的self.bounds.size
    if (SCREEN_WIDTH != self.bounds.size.width) {
        self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    //    _topScrollView = [[UIScrollView alloc] init];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _boarderView = [[UIView alloc] initWithFrame:CGRectMake(0,kHeightOfTopScrollView - 1, self.bounds.size.width, 1)];
    _boarderView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [_topScrollView addSubview:_boarderView];
    [self addSubview:_topScrollView];
    _topPanelView = [[UIView alloc] init];
    _topPanelView.backgroundColor = [UIColor blueColor];
    //    [_topScrollView addSubview:_topPanelView];
    
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _hasBadgeView = NO;
    _isBuildUI = NO;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
    
}

#pragma mark - 创建控件

- (void)layoutSubviews
{
    //    NSLog(@"screen width:%f",SCREEN_WIDTH);//-layoutSubviews的行为在iOS7和iOS8上不一样，这里的SCREEN_WIDTH在iOS7运行时不会变为横屏的width，在iOS8上面会主动变为横屏的width
    //    NSLog(@"self.bounds.size.width: %f",self.bounds.size.width);//iOS7上虽然SCREEN_WIDTH不会变，但是self.bounds.size.width会变成横屏的width
    [super layoutSubviews];
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        //更新_topScrollView上btns的宽度
        _widthDelta = self.bounds.size.width - _topScrollViewContentWidth;
        _additionWidth = _widthDelta / [_viewArray count];
        CGFloat xOffset = kWidthOfButtonMargin;
        CGFloat btnWidth = 0.0;
        for (int i = 0; i < [_viewArray count]; i++) {
            UIButton *btn = (UIButton *)[_topScrollView viewWithTag:i + kButtonsTagBase];
            btnWidth = [[_btnsContentWidthArr objectAtIndex:i] CGSizeValue].width + _additionWidth;
            btn.frame = CGRectMake(xOffset, 0, btnWidth, kHeightOfTopScrollView);
            xOffset += btnWidth + kWidthOfButtonMargin;
        }
//
//        //添加BadgeView
//        NSNumber *num = [NSNumber numberWithInt:i];
//        if ([indexArr containsObject:num]) {
//            NSValue *sizeValue = [_titleTextSizes objectAtIndex:i];
//            CGSize textSize = [sizeValue CGSizeValue];
//            CGPoint offset = CGPointMake((-1) * (button.frame.size.width/2.0 - textSize.width/2.0 - 15), button.frame.size.height/2.0);
//            [self addBageViewToButton:button posOffset:offset];
//            //                [self addBageViewToButton:button posOffset:CGPointMake(-50, 45)];
//        }
        
        //修改选择按钮阴影红条的frame
        UIButton *selectedBtn = (UIButton*)[self viewWithTag:_userSelectedChannelID];
        _shadowImageView.frame = CGRectMake(selectedBtn.frame.origin.x, 0, btnWidth, _shadowImage.size.height);
        
        //修改分割线的frame
        _boarderView.frame = CGRectMake(0,kHeightOfTopScrollView - 1, self.bounds.size.width, 1);
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);//在ios7上运行时，这句话会引起断言失败导致程序崩溃，因为这里的self.bounds.size.width变为横屏的width了，不知道为什么会导致重新布局不成功，如果这里保持一开始的SCREEN_WIDTH就不会有布局错误。而在iOS7上SCREEN_WIDTH在此时的确还没有变到横屏的width，还保持着竖屏的width，所以用下面这个语句就不会出现布局错误导致的程序崩溃，但是这样的话就无法达到横屏想要的效果了
        //        _rootScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

//当横竖屏切换时可通过此方法调整布局
//- (void)layoutSubviews
//{
//    NSLog(@"screen width:%f",SCREEN_WIDTH);
//    [super layoutSubviews];//LKZ:（2014-10-17）：不写这句话在iOS7上运行会出现assertion failure错误导致程序崩溃
//    //创建完子视图UI才需要调整布局
//    if (_isBuildUI) {
//        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
//        if (self.rigthSideButton.bounds.size.width > 0) {
//            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
//                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
//
//            _topScrollView.frame = CGRectMake(0, 0,
//                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
//        }
//
//        //更新主视图的总宽度
//        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
//
//        //更新主视图各个子视图的宽度
//        for (int i = 0; i < [_viewArray count]; i++) {
//            UIViewController *listVC = _viewArray[i];
//            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
//                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
//        }
//
//        //滚动到选中的视图
//        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
//
//        //调整顶部滚动视图选中按钮位置
//        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
//        [self adjustScrollViewContentX:button];
//    }
//}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
//        NSLog(@"%@",[vc.view class]);
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    //创建完子视图UI才需要调整布局
    //    if (_isBuildUI) {//加了自动布局约束后，针对iOS7,if(_isBuildUI){}部分要现在这里执行一下，否则会出现布局断言失败。iOS8不用。
    //        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
    //        if (self.rigthSideButton.bounds.size.width > 0) {
    //            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
    //                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
    //
    //            _topScrollView.frame = CGRectMake(0, 0,
    //                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
    //        }
    //
    //        //更新主视图的总宽度
    //        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
    //
    //        //更新主视图各个子视图的宽度
    //        for (int i = 0; i < [_viewArray count]; i++) {
    //            UIViewController *listVC = _viewArray[i];
    //            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
    //                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
    //        }
    //
    //        //滚动到选中的视图
    //        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
    //
    //        //调整顶部滚动视图选中按钮位置
    //        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
    //        [self adjustScrollViewContentX:button];
    //    }
    [self setNeedsLayout];
}

- (void)buildUIWithBadgeViewOnButtons:(NSArray *)indexArr
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
        //        NSLog(@"%@",[vc.view class]);
    }
//    [self createNameButtons];
    [self createNameButtonsWithBadgeViewOnButtons:indexArr];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;

    [self setNeedsLayout];
}

- (void)createNameButtonsWithBadgeViewOnButtons:(NSArray *)indexArr
{
    _btnsContentWidthArr = [[NSMutableArray alloc] init];
    _btnViewsDic = [[NSMutableDictionary alloc] init];
    _titleTextSizes = [[NSMutableArray alloc] init];
    _badgeViewsArr = [[NSMutableArray alloc] init];
    _hasBadgeView = YES;
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    //    [_topPanelView addSubview:_shadowImageView];
    
    //顶部tabbar的总长度
    _topScrollViewContentWidth = kWidthOfButtonMargin;
    
    //计算并判断所有btns的内容长度加上btns所有间隔的长度是否足够填满_topScrollView的width，如果不够，则拉伸每一个btn的长度以使其填满
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        [_btnsContentWidthArr addObject:[NSValue valueWithCGSize:textSize]];
        //记录每个btn的title的text的size，后面加badgeView，设置位置时要参考
        [_titleTextSizes addObject:[NSValue valueWithCGSize:textSize]];
        //累计每个tab文字的长度
        _topScrollViewContentWidth += kWidthOfButtonMargin+textSize.width;
    }
    _widthDelta = self.bounds.size.width - _topScrollViewContentWidth;
    
    if (_widthDelta > 0) {//填不满，则为每个btn的宽度增加widthDelta/[_viewArray count]的长度
        _additionWidth = _widthDelta / [_viewArray count];
        //每个tab偏移量
        CGFloat xOffset = kWidthOfButtonMargin;
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *vc = _viewArray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //btn最终width等于其内容的width加上为了填满_topScrollView而需要拉伸的additionWidth
            float btnWidth = [[_btnsContentWidthArr objectAtIndex:i] CGSizeValue].width + _additionWidth;
            //设置按钮尺寸
            [button setFrame:CGRectMake(xOffset,0,btnWidth, kHeightOfTopScrollView)];
            //计算下一个tab的x偏移量
            xOffset += btnWidth + kWidthOfButtonMargin;
            [button setTag:i + kButtonsTagBase];
            if (i == 0) {//设置红条一开始的frame
                _shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, 0, btnWidth, _shadowImage.size.height);
                button.selected = YES;
            }
            [button setTitle:vc.title forState:UIControlStateNormal];
//            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
            button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
            [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
            [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
            
            //添加BadgeView
            NSNumber *num = [NSNumber numberWithInt:i];
            if ([indexArr containsObject:num]) {
                NSValue *sizeValue = [_titleTextSizes objectAtIndex:i];
                CGSize textSize = [sizeValue CGSizeValue];
                CGPoint offset = CGPointMake((-1) * (button.frame.size.width/2.0 - textSize.width/2.0 - 15 - kBadgeViewSpaceWithText), button.frame.size.height/2.0);//我本来预期btn的size的1/2减去title的text的1/2（title居中）就是badgeView紧贴着文字所需要的向左的偏移量，但不知道为什么，这里要多减去15才能达到这个需求
//                [self addBageViewToButton:button posOffset:CGPointMake(-50, 45)];
            }
            
            
            [_topScrollView addSubview:button];
            //        [_topPanelView addSubview:button];
            //        button.translatesAutoresizingMaskIntoConstraints = NO;//如果撤销自动布局约束后，这里要注释掉，否则按钮会挤在一团
            
            //为btns的自动布局约束准备viewsDic
            NSString *kName = [NSString stringWithFormat:@"button%d",i];
            [_btnViewsDic setObject:button forKey:kName];
        }
    }else{
        
    }
    
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(MAX(_topScrollViewContentWidth,self.bounds.size.width), kHeightOfTopScrollView);
    

}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    _btnsContentWidthArr = [[NSMutableArray alloc] init];
    _btnViewsDic = [[NSMutableDictionary alloc] init];
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    //    [_topPanelView addSubview:_shadowImageView];
    
    //顶部tabbar的总长度
    _topScrollViewContentWidth = kWidthOfButtonMargin;
    
    //计算并判断所有btns的内容长度加上btns所有间隔的长度是否足够填满_topScrollView的width，如果不够，则拉伸每一个btn的长度以使其填满
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        [_btnsContentWidthArr addObject:[NSValue valueWithCGSize:textSize]];
        //累计每个tab文字的长度
        _topScrollViewContentWidth += kWidthOfButtonMargin+textSize.width;
    }
    _widthDelta = self.bounds.size.width - _topScrollViewContentWidth;
    
    if (_widthDelta > 0) {//填不满，则为每个btn的宽度增加widthDelta/[_viewArray count]的长度
        _additionWidth = _widthDelta / [_viewArray count];
        //每个tab偏移量
        CGFloat xOffset = kWidthOfButtonMargin;
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *vc = _viewArray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //btn最终width等于其内容的width加上为了填满_topScrollView而需要拉伸的additionWidth
            float btnWidth = [[_btnsContentWidthArr objectAtIndex:i] CGSizeValue].width + _additionWidth;
            //设置按钮尺寸
            [button setFrame:CGRectMake(xOffset,0,btnWidth, kHeightOfTopScrollView)];
            //计算下一个tab的x偏移量
            xOffset += btnWidth + kWidthOfButtonMargin;
            [button setTag:i + kButtonsTagBase];
            if (i == 0) {//设置红条一开始的frame
                _shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, 0, btnWidth, _shadowImage.size.height);
                button.selected = YES;
            }
            [button setTitle:vc.title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
            [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
            [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
            [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
            [_topScrollView addSubview:button];
            //        [_topPanelView addSubview:button];
            //        button.translatesAutoresizingMaskIntoConstraints = NO;//如果撤销自动布局约束后，这里要注释掉，否则按钮会挤在一团
            
            //为btns的自动布局约束准备viewsDic
            NSString *kName = [NSString stringWithFormat:@"button%d",i];
            [_btnViewsDic setObject:button forKey:kName];
        }
    }else{
        
    }
    
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(MAX(_topScrollViewContentWidth,self.bounds.size.width), kHeightOfTopScrollView);
    
    //    //为_topScrollView增加自动布局约束
    //    _topScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(_topScrollView);
    //    NSDictionary *metricsDic = @{@"left":@(0),@"top":@(0),@"right":@(0),@"height":@(44)};
    //    NSArray *scrollViewHCons = [NSLayoutConstraint constraintsWithVisualFormat:@"|-left-[_topScrollView]-right-|" options:0 metrics:metricsDic views:viewsDic];
    //    NSArray *scrollViewVCons = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_topScrollView(==height)]" options:0 metrics:metricsDic views:viewsDic];
    //    [self addConstraints:scrollViewHCons];
    //    [self addConstraints:scrollViewVCons];
    //
    //    //为panelView增加自动布局约束
    //    _topPanelView.translatesAutoresizingMaskIntoConstraints = NO;
    //    NSDictionary *viewsDic1 = NSDictionaryOfVariableBindings(_topPanelView);
    //    //panelView的宽度用SCREEN_WIDTH来确定，因为无论是用self.bounds.size.width还是_topScrollView.bounds.size.width都不符合效果，取到的都是storyboard初始是的width而不是设备实际的width
    //    NSDictionary *metricsDic1 = @{@"left":@(0),@"top":@(0),@"right":@(0),@"bottom":@(0),@"width":@(SCREEN_WIDTH),@"height":@(kHeightOfTopScrollView)};
    ////    NSLog(@"screen width:%f",SCREEN_WIDTH);
    //    _panelViewHCons = [NSLayoutConstraint constraintsWithVisualFormat:@"|-left-[_topPanelView(==width)]-right-|" options:0 metrics:metricsDic1 views:viewsDic1];
    //    NSArray *panelViewVCons = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_topPanelView(==height)]" options:0 metrics:metricsDic1 views:viewsDic1];
    //    [_topScrollView addConstraints:_panelViewHCons];
    //    [_topScrollView addConstraints:panelViewVCons];
    //
    //    //为btns增加自动布局约束
    //    NSInteger viewCount = [_viewArray count];
    //    //btn的width要依赖于panelView的width，panelView的width依赖于SCREEN_WIDTH来计算，所以btn的width也依赖它
    //    float btnWidth = (SCREEN_WIDTH - (viewCount + 1) * kWidthOfButtonMargin) / viewCount;
    //    NSDictionary *metricsDic2 = @{@"top":@(0),@"btnMargin":@(kWidthOfButtonMargin),@"btnWidth":@(btnWidth),@"btnHeight":@(kHeightOfTopScrollView),@"bottom":@(0)};
    //    NSMutableString *btnsHorizonalConsStr = [[NSMutableString alloc] initWithString:@"|"];
    //    //拼接标题按钮水平和垂直的自动布局约束字符串并将约束添加到panelView
    //    for(int i = 0; i < viewCount; i++){
    //        if (i == 0) {
    //            //因为直到这里才能确定btn的宽度，因此直到这里才能确定选择阴影图片首次出现时的frame
    //            _shadowImageView.frame = CGRectMake(kWidthOfButtonMargin, 0, btnWidth, _shadowImage.size.height);
    //        }
    //        NSString *vConStr = [NSString stringWithFormat:@"V:|-top-[button%d]-bottom-|",i];
    //        NSArray *btnVCons = [NSLayoutConstraint constraintsWithVisualFormat:vConStr options:0 metrics:metricsDic2 views:_btnViewsDic];
    //        [_topPanelView addConstraints:btnVCons];
    //        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    //            [btnsHorizonalConsStr appendFormat:@"-btnMargin-[button%d(==btnWidth)]",i];
    //        }else{
    //            [btnsHorizonalConsStr appendFormat:@"-btnMargin-[button%d]",i];
    //        }
    //        if (i == viewCount - 1) {
    //            [btnsHorizonalConsStr appendString:@"-btnMargin-|"];
    //            _btnHCons = [NSLayoutConstraint constraintsWithVisualFormat:btnsHorizonalConsStr options:0 metrics:metricsDic2 views:_btnViewsDic];
    //            [_topPanelView addConstraints:_btnHCons];
    //        }
    //    }
    
    
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, _shadowImage.size.height)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - kButtonsTagBase)*self.bounds.size.width, 0) animated:YES];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (_topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width + kButtonsTagBase;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end

