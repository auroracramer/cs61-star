//
//  SKDialogueTreeNode.h
//  CS61Star
//
//  Created by Jason Cramer on 12/4/12.
//
//

#import <Foundation/Foundation.h>

@interface SKDialogueTreeNode : NSObject
{
    NSMutableArray* parents;
    NSMutableArray* children;
}
@end
