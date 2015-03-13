//
//  Cat.m
//  CatsLaw
//
//  Created by Jenny Lin on 2/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cat.h"



@implementation Cat {
    int speed;
    BOOL isClinging;
    BOOL isKnocking;
    CCAnimationManager* animationManager;
}

@synthesize canCling;

- (id) init {
    if (self = [super init]) {
        speed = 30;
        isClinging = NO;
        isKnocking = NO;
    }
    return self;
}

/*
 * Called when this file is loaded from CCB.
 */
- (void)didLoadFromCCB {
    animationManager = self.animationManager;
    self.scaleX = 0.3;
    self.scaleY = 0.3;
    canCling = YES;
}

/*
 * Checks cat velocity to see if it's nyooming
 * Threshold dependent on current movement
 */
- (BOOL) isNyooming {
    return (sqrt(pow(self.physicsBody.velocity.x,2) + pow(self.physicsBody.velocity.y,2)) > speed + 10);
}

//Tries to make the cat cling
- (void) tryToCling {
    if (canCling) {
        isClinging = YES;
        //cling animation here
        [self cling];
    }
}

//Stop the cat from clinging
- (void) endCling {
    if (isClinging){
        isClinging = NO;
        [self walk];
    }
}

//A method to move the cat, requires an orientation to determine right way to move
//Operates under assumption that orientation is always 0, 90, 180 or 270
- (void) moveCat:(CCTime)delta directionOfGravity:(int)orientation {
    if (isClinging || isKnocking) {
        //CCLOG(@"tryin to cling");
        return;
    }
    self.rotation = orientation;
    if (orientation == 0) {
        self.position = ccp(self.position.x + delta*speed, self.position.y);
    }
    else if (orientation == 90) {
        self.position = ccp(self.position.x, self.position.y - delta*speed);
    }
    else if (orientation == 180) {
        self.position = ccp(self.position.x - delta*speed, self.position.y);
    }
    else if (orientation == 270) {
        self.position = ccp(self.position.x, self.position.y + delta*speed);
    }
}

- (void)setIsKnocking: (BOOL)set {
    isKnocking = set;
}

//------------------ animations

- (void)blink {
    [animationManager runAnimationsForSequenceNamed:@"hover"];
}

- (void)walk {
    [animationManager runAnimationsForSequenceNamed:@"walk"];
}

- (void)cling {
    [animationManager runAnimationsForSequenceNamed:@"cling"];
}

- (void)knock {
    isKnocking=YES;
    [animationManager runAnimationsForSequenceNamed:@"knock"];
}

- (void)stand {
    [animationManager runAnimationsForSequenceNamed:@"stand"];
}

- (void)sit {
    [animationManager runAnimationsForSequenceNamed:@"sit"];
}


@end
