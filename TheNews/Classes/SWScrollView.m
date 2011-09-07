////  SWScrollView.m//  SWGameLib//////  Copyright (c) 2010 Sangwoo Im////  Permission is hereby granted, free of charge, to any person obtaining a copy//  of this software and associated documentation files (the "Software"), to deal//  in the Software without restriction, including without limitation the rights//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell//  copies of the Software, and to permit persons to whom the Software is//  furnished to do so, subject to the following conditions:////  The above copyright notice and this permission notice shall be included in//  all copies or substantial portions of the Software.////  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN//  THE SOFTWARE.//  //  Created by Sangwoo Im on 6/3/10.//  Copyright 2010 Sangwoo Im. All rights reserved.//#import "SWScrollView.h"#import "CCActionInterval.h"#import "CCActionTween.h"#import "CCActionInstant.h"#import "CGPointExtension.h"#import "CCTouchDispatcher.h"#import "CCGrid.h"#import "CCDirector.h"#import "CCNode+Autolayout.h"#define SCROLL_DEACCEL_RATE  0.95f#define SCROLL_DEACCEL_DIST  1.0f#define BOUNCE_DURATION      0.35f#define INSET_RATIO          0.3f@interface SWScrollView()/** * container is a protected property */@property (nonatomic, retain) CCNode  *container_;/** * initial touch point */@property (nonatomic, assign) CGPoint touchPoint_;/** * determines whether touch is moved after begin phase */@property (nonatomic, assign) BOOL    touchMoved_;@end@interface SWScrollView (Private)/** * Init this object with a given size to clip its content. * * @param size view size * @return initialized scroll view object */-(id)initWithViewSize:(CGSize)size;/** * Relocates the container at the proper offset, in bounds of max/min offsets. * * @param animated If YES, relocation is animated */-(void)relocateContainer:(BOOL)animated;/** * implements auto-scrolling behavior. change SCROLL_DEACCEL_RATE as needed to choose * deacceleration speed. it must be less than 1.0f. * * @param dt delta */-(void)deaccelerateScrolling:(ccTime)dt;/** * This method makes sure auto scrolling causes delegate to invoke its method */-(void)performedAnimatedScroll:(ccTime)dt;/** * Expire animated scroll delegate calls */-(void)stoppedAnimatedScroll:(CCNode *)node;/** * clip this view so that outside of the visible bounds can be hidden. */-(void)beforeDraw;/** * retract what's done in beforeDraw so that there's no side effect to * other nodes. */-(void)afterDraw;/** * Zoom handling */-(void)handleZoom;/** * Computes inset for bouncing */-(void)computeInsets;@end@implementation SWScrollView@synthesize direction     = direction_;@synthesize clipsToBounds  = clipsToBounds_;@synthesize viewSize      = viewSize_;@synthesize bounces       = bounces_;@synthesize isDragging    = isDragging_;@synthesize delegate      = delegate_;@synthesize touchPoint_;@synthesize touchMoved_;@synthesize container_;@synthesize maxZoomScale = maxScale_;@synthesize minZoomScale = minScale_;@dynamic zoomScale;@dynamic contentOffset;#pragma mark -#pragma mark init+(id)viewWithViewSize:(CGSize)size {    return [[[self alloc] initWithViewSize:size] autorelease];}+(id)viewWithViewSize:(CGSize)size container:(CCNode *)container {    return [[[self alloc] initWithViewSize:size container:container] autorelease];}-(id)initWithViewSize:(CGSize)size {    return [self initWithViewSize:size container:nil];}-(id)initWithViewSize:(CGSize)size container:(CCNode *)container {    if ((self = [super init])) {        self.container_ = container;        self.viewSize   = size;                if (!self.container_) {            self.container_ = [CCLayer node];        }        self.isTouchEnabled    = YES;        touches_               = [NSMutableArray new];        delegate_              = nil;        bounces_               = YES;        clipsToBounds_          = YES;        container_.contentSize = CGSizeZero;        direction_             = SWScrollViewDirectionBoth;        container_.position    = ccp(0.0f, 0.0f);        touchLength_           = 0.0f;                [self addChild:container_];        minScale_ = maxScale_ = 1.0f;    }    return self;}-(id)init {    NSAssert(NO, @"SWScrollView: DO NOT initialize SWScrollview directly.");    return nil;}-(void)dealloc {    [touches_ release];    [container_ release];    [super dealloc];}-(void)registerWithTouchDispatcher {    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];}-(BOOL)isNodeVisible:(CCNode *)node {    const CGPoint offset = [self contentOffset];    const CGSize  size   = [self viewSize];    const float   scale  = [self zoomScale];        CGRect viewRect;        viewRect = CGRectMake(-offset.x/scale, -offset.y/scale, size.width/scale, size.height/scale);         return CGRectIntersectsRect(viewRect, [node boundingBox]);}-(void)pause:(id)sender {    id child;    [container_ pauseSchedulerAndActions];    CCARRAY_FOREACH(container_.children, child) {        if ([child respondsToSelector:@selector(pause:)]) {            [child performSelector:@selector(pause:) withObject:sender];        }    }}-(void)resume:(id)sender {    id child;    CCARRAY_FOREACH(container_.children, child) {        if ([child respondsToSelector:@selector(resume:)]) {            [child performSelector:@selector(resume:) withObject:sender];        }    }    [container_ resumeSchedulerAndActions];}#pragma mark -#pragma mark Properties-(void)setIsTouchEnabled:(BOOL)e {    [super setIsTouchEnabled:e];    if (!e) {        isDragging_ = NO;        touchMoved_ = NO;        [touches_ removeAllObjects];    }}-(void)setContentOffset:(CGPoint)offset {    [self setContentOffset:offset animated:NO];}-(void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {    if (animated) { //animate scrolling        [self setContentOffset:offset animatedInDuration:BOUNCE_DURATION];    } else { //set the container position directly        if (!bounces_) {            const CGPoint minOffset = [self minContainerOffset];            const CGPoint maxOffset = [self maxContainerOffset];                        offset.x = MAX(minOffset.x, MIN(maxOffset.x, offset.x));            offset.y = MAX(minOffset.y, MIN(maxOffset.y, offset.y));        }        container_.position = offset;        if([delegate_ respondsToSelector:@selector(scrollViewDidScroll:)]) {            [delegate_ scrollViewDidScroll:self];           }    }}-(void)setContentOffset:(CGPoint)offset animatedInDuration:(ccTime)dt {    CCFiniteTimeAction *scroll, *expire;        scroll = [CCMoveTo actionWithDuration:dt position:offset];    expire = [CCCallFunc actionWithTarget:self selector:@selector(stoppedAnimatedScroll:)];    [container_ runAction:[CCSequence actions:scroll, expire, nil]];    [self schedule:@selector(performedAnimatedScroll:)];}-(CGPoint)contentOffset {    return container_.position;}-(void)setZoomScale:(float)s {    if (container_.scale != s) {        CGPoint oldCenter, newCenter;        CGPoint center;                if (touchLength_ == 0.0f) {            center = ccp(viewSize_.width*0.5f, viewSize_.height*0.5f);            center = [self convertToWorldSpace:center];        } else {            center = touchPoint_;        }                oldCenter = [container_ convertToNodeSpace:center];        container_.scale = MAX(minScale_, MIN(maxScale_, s));        newCenter = [container_ convertToWorldSpace:oldCenter];                const CGPoint offset = ccpSub(center, newCenter);        if ([delegate_ respondsToSelector:@selector(scrollViewDidZoom:)]) {            [delegate_ scrollViewDidZoom:self];        }				[self computeInsets];        [self setContentOffset:ccpAdd(container_.position,offset)];    }}-(CGFloat)zoomScale {    return container_.scale;}-(void)setZoomScale:(float)s animated:(BOOL)animated {    if (animated) {        [self setZoomScale:s animatedInDuration:BOUNCE_DURATION];    } else {        [self setZoomScale:s];    }}-(void)setZoomScale:(float)s animatedInDuration:(ccTime)dt {    if (dt > 0) {        if (container_.scale != s) {            CCActionTween *scaleAction;            scaleAction = [CCActionTween actionWithDuration:dt                                                        key:@"zoomScale"                                                       from:container_.scale                                                         to:s];            [self runAction:scaleAction];        }    } else {        [self setZoomScale:s];    }}-(void)setViewSize:(CGSize)size {    if (!CGSizeEqualToSize(viewSize_, size)) {        viewSize_ = size;		[self computeInsets];    }}#pragma mark -#pragma mark Private-(void)computeInsets {	maxInset_ = [self maxContainerOffset];	maxInset_ = ccp(maxInset_.x + viewSize_.width * INSET_RATIO,					maxInset_.y + viewSize_.height * INSET_RATIO);	minInset_ = [self minContainerOffset];	minInset_ = ccp(minInset_.x - viewSize_.width * INSET_RATIO,					minInset_.y - viewSize_.height * INSET_RATIO);}-(void)relocateContainer:(BOOL)animated {    CGPoint oldPoint, min, max;    CGFloat newX, newY;        min = [self minContainerOffset];    max = [self maxContainerOffset];        oldPoint = container_.position;    newX     = oldPoint.x;    newY     = oldPoint.y;    if (direction_ == SWScrollViewDirectionBoth || direction_ == SWScrollViewDirectionHorizontal) {        newX     = MIN(newX, max.x);        newX     = MAX(newX, min.x);    }    if (direction_ == SWScrollViewDirectionBoth || direction_ == SWScrollViewDirectionVertical) {        newY     = MIN(newY, max.y);        newY     = MAX(newY, min.y);    }    if (newY != oldPoint.y || newX != oldPoint.x) {        [self setContentOffset:ccp(newX, newY) animated:animated];    }}-(CGPoint)maxContainerOffset {    return ccp(0.0f, 0.0f);}-(CGPoint)minContainerOffset {    return ccp(viewSize_.width - container_.contentSize.width*container_.scaleX,                viewSize_.height - container_.contentSize.height*container_.scaleY);}-(void)deaccelerateScrolling:(ccTime)dt {    if (isDragging_) {        [self unschedule:@selector(deaccelerateScrolling:)];        return;    }        CGFloat newX, newY;    CGPoint maxInset, minInset;        container_.position = ccpAdd(container_.position, scrollDistance_);        if (bounces_) {        maxInset = maxInset_;        minInset = minInset_;    } else {        maxInset = [self maxContainerOffset];        minInset = [self minContainerOffset];    }        //check to see if offset lies within the inset bounds    newX     = MIN(container_.position.x, maxInset.x);    newX     = MAX(newX, minInset.x);    newY     = MIN(container_.position.y, maxInset.y);    newY     = MAX(newY, minInset.y);        scrollDistance_     = ccpSub(scrollDistance_, ccp(newX - container_.position.x, newY - container_.position.y));    scrollDistance_     = ccpMult(scrollDistance_, SCROLL_DEACCEL_RATE);    [self setContentOffset:ccp(newX,newY)];        if (ccpLengthSQ(scrollDistance_) <= SCROLL_DEACCEL_DIST*SCROLL_DEACCEL_DIST ||        newX == maxInset.x || newX == minInset.x ||        newY == maxInset.y || newY == minInset.y) {        [self unschedule:@selector(deaccelerateScrolling:)];        [self relocateContainer:YES];    }}-(void)stoppedAnimatedScroll:(CCNode *)node {    [self unschedule:@selector(performedAnimatedScroll:)];}-(void)performedAnimatedScroll:(ccTime)dt {    if (isDragging_) {        [self unschedule:@selector(performedAnimatedScroll:)];        return;    }    if ([delegate_ respondsToSelector:@selector(scrollViewDidScroll:)]) {        [delegate_ scrollViewDidScroll:self];    }}#pragma mark -#pragma mark overriden-(void)setAnchorPoint:(CGPoint)anchorPoint {	CCLOG(@"The current implementation doesn't support anchor point change");}-(void)layoutChildren {	[self relocateContainer:NO];}-(CGSize)contentSize {    return CGSizeMake(container_.contentSize.width, container_.contentSize.height); }-(void)setContentSize:(CGSize)size {    container_.contentSize = size;    maxInset_ = [self maxContainerOffset];    maxInset_ = ccp(maxInset_.x + viewSize_.width * INSET_RATIO,                    maxInset_.y + viewSize_.height * INSET_RATIO);    minInset_ = [self minContainerOffset];    minInset_ = ccp(minInset_.x - viewSize_.width * INSET_RATIO,                    minInset_.y - viewSize_.height * INSET_RATIO);}/** * make sure all children go to the container */-(void)addChild:(CCNode *)node  z:(int)z tag:(int)aTag {    node.isRelativeAnchorPoint = YES;    node.anchorPoint           = ccp(0.0f, 0.0f);    if (container_ != node) {        [container_ addChild:node z:z tag:aTag];    } else {        [super addChild:node z:z tag:aTag];    }}/** * clip this view so that outside of the visible bounds can be hidden. *///-(void)beforeDraw {//    if (clipsToBounds_) {//        glEnable(GL_SCISSOR_TEST);//        const CGFloat s = [[CCDirector sharedDirector] contentScaleFactor];//        glScissor(self.position.x, self.position.y, viewSize_.width*s, viewSize_.height*s);//    }//}/** * retract what's done in beforeDraw so that there's no side effect to * other nodes. */-(void)afterDraw {    if (clipsToBounds_) {        glDisable(GL_SCISSOR_TEST);    }}#pragma mark -#pragma mark touch events-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    if (!self.visible) {        return NO;    }    CGRect frame;        frame = CGRectMake(self.position.x, self.position.y, viewSize_.width, viewSize_.height);    //dispatcher does not know about clipping. reject touches outside visible bounds.    if ([touches_ count] > 2 ||        touchMoved_          ||        !CGRectContainsPoint(frame, [container_ convertToWorldSpace:[container_ convertTouchToNodeSpace:touch]])) {        return NO;    }	    if (![touches_ containsObject:touch]) {        [touches_ addObject:touch];    }    if ([touches_ count] == 1) { // scrolling        touchPoint_     = [self convertTouchToNodeSpace:touch];        touchMoved_     = NO;        isDragging_     = YES; //dragging started        scrollDistance_ = ccp(0.0f, 0.0f);        touchLength_    = 0.0f;    } else if ([touches_ count] == 2) {        touchPoint_  = ccpMidpoint([self convertTouchToNodeSpace:[touches_ objectAtIndex:0]],                                   [self convertTouchToNodeSpace:[touches_ objectAtIndex:1]]);        touchLength_ = ccpDistance([container_ convertTouchToNodeSpace:[touches_ objectAtIndex:0]],                                   [container_ convertTouchToNodeSpace:[touches_ objectAtIndex:1]]);        isDragging_  = NO;    }     return YES;}-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {    if (!self.visible) {        return;    }    if ([touches_ containsObject:touch]) {        if ([touches_ count] == 1 && isDragging_) { // scrolling            CGPoint moveDistance, newPoint;            CGRect  frame;            CGFloat newX, newY;                        touchMoved_  = YES;            frame        = CGRectMake(self.position.x, self.position.y, viewSize_.width, viewSize_.height);            newPoint     = [self convertTouchToNodeSpace:[touches_ objectAtIndex:0]];            moveDistance = ccpSub(newPoint, touchPoint_);            touchPoint_  = newPoint;                        if (CGRectContainsPoint(frame, [self convertToWorldSpace:newPoint])) {                switch (direction_) {                    case SWScrollViewDirectionVertical:                        moveDistance = ccp(0.0f, moveDistance.y);                        break;                    case SWScrollViewDirectionHorizontal:                        moveDistance = ccp(moveDistance.x, 0.0f);                        break;                    default:                        break;                }                container_.position = ccpAdd(container_.position, moveDistance);                                //check to see if offset lies within the inset bounds                newX     = MIN(container_.position.x, maxInset_.x);                newX     = MAX(newX, minInset_.x);                newY     = MIN(container_.position.y, maxInset_.y);                newY     = MAX(newY, minInset_.y);                                scrollDistance_     = ccpSub(moveDistance, ccp(newX - container_.position.x, newY - container_.position.y));                [self setContentOffset:ccp(newX, newY)];            }        } else if ([touches_ count] == 2 && !isDragging_) {			touchMoved_ = YES;            const CGFloat len = ccpDistance([container_ convertTouchToNodeSpace:[touches_ objectAtIndex:0]],                                            [container_ convertTouchToNodeSpace:[touches_ objectAtIndex:1]]);            [self setZoomScale:self.zoomScale*len/touchLength_];        }    }}-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {    if (!self.visible) {        return;    }    if ([touches_ containsObject:touch]) {        if (touchMoved_) {            [self schedule:@selector(deaccelerateScrolling:)];        }        [touches_ removeObject:touch];    }     if ([touches_ count] == 0) {        isDragging_ = NO;            touchMoved_ = NO;    }}-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {    if (!self.visible) {        return;    }    [touches_ removeObject:touch];     if ([touches_ count] == 0) {        isDragging_ = NO;            touchMoved_ = NO;    }}@end