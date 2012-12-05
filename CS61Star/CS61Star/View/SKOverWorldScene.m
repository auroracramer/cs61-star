//
//  SKOverWorldScene.m
//  CS61Star
//
//  Created by Jason Cramer on 11/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SKOverWorldScene.h"
#import "SKOverWorldLayer.h"


@implementation SKOverWorldScene

-(id)init
{
    self = [super init];
    
    if(self)
    {
        currentMap = [[CCTMXTiledMap alloc] initWithTMXFile:@"testmap.tmx"];
        [self addChild:currentMap];
        hud = [[SKOverworldHUDLayer alloc] init];
        [self addChild:hud];
        
    }
    
    return self;
}

-(id)initWithMap: (CCTMXTiledMap*) map
{
    self = [super init];
    if(self)
    {
        self.layer = [[SKOverWorldLayer alloc] initWithMap: map];
        [self addChild: _layer];
    }
    return self;
}

-(void)draw
{
    // Render this scene
}

-(id)changeMap:(CCTMXTiledMap *)newMap
{
    [self.layer changeMap:newMap];
}

-(void)dealloc
{
    [self.layer dealloc];
    
    [super dealloc];
}

@end
