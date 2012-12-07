//
//  SKPlayer.m
//  CS61Star
//
//  Created by Jason Cramer on 11/17/12.
//
//

#import "SKPlayer.h"

@implementation SKPlayer

@synthesize controllable;
@synthesize python = _python;
@synthesize walkUpAction = _walkUpAction;
@synthesize walkDownAction = _walkDownAction;
@synthesize walkLeftAction = _walkLeftAction;
@synthesize walkRightAction = _walkRightAction;
@synthesize battleAction = _battleAction;
@synthesize spriteSheet = _spriteSheet;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        // Cache the sprite frames and texture
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"zwoppythonsheet_default.plist" textureFilename:@"zwoppythonsheet_default.png"];
        
        // Create a sprite batch node
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"zwoppythonsheet_default.png"];
        
        // Gather the list of frames for each animation
        NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 2; ++i) {
            [walkDownAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pythonwalkforward %d.png", i]]];
        }
        
        NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 2; ++i) {
            [walkUpAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pythonwalkback %d.png", i]]];
        }
        
        NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 4; ++i) {
            [walkLeftAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pythonwalkleft %d.png", i]]];
        }
        
        NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 4; ++i) {
            [walkRightAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"pythonwalkright %d.png", i]]];
        }
        
        NSMutableArray *battleAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 2; ++i) {
            [battleAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"battlepython %d.png", i]]];
        }
        
        // Create the animation object
        CCAnimation *walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.3f];
        CCAnimation *walkUpAnim = [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.3f];
        CCAnimation *walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.3f];
        CCAnimation *walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.3f];
        CCAnimation *battleAnim = [CCAnimation animationWithSpriteFrames:battleAnimFrames delay:.3f];
        
        // Create the sprite and set up the animation objects
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        self.python = [CCSprite spriteWithSpriteFrameName:@"pythonwalkforward 1.png"];
        _python.position = ccp(winSize.width/2, winSize.height/2);
        
        self.walkDownAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnim]];
        self.walkUpAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnim]];
        self.walkLeftAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnim]];
        self.walkRightAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkRightAnim]];
        self.battleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:battleAnim]];
        
        // Stop antialiasing
        [[_spriteSheet texture] setAliasTexParameters];
        [[_python texture] setAliasTexParameters];
        
        
        [_python runAction:_walkDownAction];
        [_spriteSheet addChild:_python];

    }
    
    return self;
}

-(CCSpriteBatchNode*)getSpriteSheet
{
    return _spriteSheet;
}

-(void)changeDirection: (Direction)direction
{
    [_python stopAllActions];
    switch (direction) {
        case LEFT:
            [_python runAction:_walkLeftAction];
            break;
        case RIGHT:
            [_python runAction:_walkRightAction];
            break;
        case UP:
            [_python runAction:_walkUpAction];
            break;
        default:
            [_python runAction:_walkDownAction];
            break;
    }
}

-(void)move:(CGPoint)directionOffset withDirection:(Direction)direction
{
    CGPoint pythonPosition = [_python position];
    float newXPosition = pythonPosition.x + directionOffset.x;
    float newYPosition = pythonPosition.y + directionOffset.y;
    
    [_python setPosition:ccp(newXPosition,newYPosition)];
    [self changeDirection: direction];
}

-(void) runBattleAnimation
{
    [_python stopAllActions];
    [_python runAction:_battleAction];
}

-(CGPoint)getMovePosition:(CGPoint)directionOffset
{
    CGPoint pythonPosition = [_python position];
    float newXPosition = pythonPosition.x + directionOffset.x;
    float newYPosition = pythonPosition.y + directionOffset.y;
    
    return ccp(newXPosition,newYPosition);
}

-(void) dealloc
{
    [self.python release];
    [self.walkUpAction release];
    [self.walkDownAction release];
    [self.walkRightAction release];
    [self.walkLeftAction release];
    
    self.python = nil;
    self.walkUpAction = nil;
    self.walkDownAction = nil;
    self.walkLeftAction = nil;
    self.walkRightAction = nil;
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    
    [super dealloc];
}

@end
