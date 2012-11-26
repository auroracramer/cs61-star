//
//  SKControllerEngine.m
//  CS61Star
//
//  Created by Jason Cramer on 11/17/12.
//
//

#import "SKControllerEngine.h"
#import "SKOverWorldState.h"
#import "SKBattleState.h"
#import "SKTitleScreenState.h"
@implementation SKControllerEngine

-(id)init
{
    self = [super init];
    if(self)
    {
        
        [self scheduleUpdate];  // available since v0.99.3
        
        // Get the director
        director = (CCDirectorMac*) [CCDirector sharedDirector];
        
        // For now, automatically load SKOverWorldState
        currState = [[SKOverWorldState alloc] init];
        
        // Since the map is probably the most intensive 'scene', probably would be a good idea
        // to keep the overworld loaded until the game is quit
        
        // When the engine is first inititalized, there is no need to create the data management
        // since we have not necessarily started the game yet. We will leave this to when a new game
        // or a loaded game is started
    }
    
    return self;
}

-(void) update: (ccTime) dt
{
    [currState update: dt];
}


-(void) changeToOverWorld
{
    [currState autorelease];
    currState = [[SKOverWorldState alloc] init];
    [director runWithScene: [currState getCurrentScene]];
}

-(void) changeToBattle
{
    [currState autorelease];
    currState = [[SKBattleState alloc] init];
    [director runWithScene: [currState getCurrentScene]];
}

-(void) changeToTitle
{
    [currState autorelease];
    currState = [[SKTitleScreenState alloc] init];
    [director runWithScene: [currState getCurrentScene]];
}

-(void) startNewGame
{
    // Starts a new game!
}

-(BOOL) loadGameState
{
    // Loads the game state, and populates the relevant models
    
    // Load that shit from the file, aw yeah, just like that
    // Make sure your remember to specify the file path, yo
    NSDictionary* gameSave = [NSDictionary dictionaryWithContentsOfFile: @"File path, like a boss"];
    
    // Populate the model with funness
    
    
    // Return yes if everything went swimmingly.
    return YES;
}

-(BOOL) saveGameState
{
    // Saves game state in a serializable collection
    
    // Fill collection with fun things
    NSDictionary* gameSave = [[NSDictionary alloc] initWithObjectsAndKeys: nil];
    
    // Get current map state from OverWorldState
    
    // Cerealize!~~ ^__^
    // Make sure you specify the file path, yo.
    [gameSave writeToFile: @"File path, like a boss" atomically: YES];
    
    [gameSave release];
    
    
    // Return yes if everything went swimmingly.
    return YES;
    
}

-(CCScene*) getCurrentScene
{
    return [currState getCurrentScene];
}

@end
