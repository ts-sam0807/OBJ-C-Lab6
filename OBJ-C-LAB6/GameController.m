//
//  GameController.m
//  OBJ-C-LAB6
//
//  Created by Ts SaM on 11/9/2023.
//

#import "GameController.h"
#import "Dice.h"

@implementation GameController

- (instancetype)init {
    self = [super init];
    if (self) {
        _diceArray = [NSMutableArray arrayWithCapacity: 5];
        _heldDiceArray = [NSMutableArray arrayWithCapacity: 5];
        _rollsSinceLastReset = 1;
    }
    return self;
}

- (void)createDiceInstances {
    for (int i = 0; i < 5; i++) {
        Dice *dice = [[Dice alloc] init];
        [self.diceArray addObject:dice];
    }
}

- (void)rollDice {
    if (self.rollsSinceLastReset >= 5) {
        NSLog(@"You have rolled 5 times without resetting. Please reset before rolling again.");
        return;
    }

    for (Dice *dice in self.diceArray) {
        if (![self.heldDiceArray containsObject:dice]) {
            [dice randomizeValue];
        }
    }
    
    self.rollsSinceLastReset++;
    
    if (self.rollsSinceLastReset == 5) {
        NSInteger finalScore = [self calculateCurrentScore];
        NSLog(@"Final Score: %ld", (long)finalScore);
    }
    
}

- (void)toggleHoldDie:(NSUInteger)index {
    if (index < self.diceArray.count) {
        Dice *diceToToggle = self.diceArray[index];
        if ([self.heldDiceArray containsObject:diceToToggle]) {
            [self.heldDiceArray removeObject:diceToToggle];
        } else {
            [self.heldDiceArray addObject:diceToToggle];
        }
    } else {
        NSLog(@"Invalid dice index.");
    }
}

- (void)resetDice {
    [self.heldDiceArray removeAllObjects];
}

- (NSInteger)calculateCurrentScore {
    NSInteger score = 0;
    for (Dice *dice in self.heldDiceArray) {
        score += dice.currentValue;
    }
    return score;
}

- (void)displayDiceValuesAndScore {
    NSArray<NSString *> *diceValues = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
    
    NSLog(@"Dice Values (H = Held):");
    for (int i = 0; i < self.diceArray.count; i++) {
        Dice *dice = self.diceArray[i];
        NSString *diceValue = diceValues[dice.currentValue - 1];
        NSString *holdState = [self.heldDiceArray containsObject:dice] ? @"[H]" : @"";
        NSLog(@"%d: %@ %@", i + 1, diceValue, holdState);
    }
    
    NSInteger currentScore = [self calculateCurrentScore];
    NSLog(@"Held Dice Score (Held): %ld", (long)currentScore);
}

- (void)holdAllDice {
    [self.heldDiceArray removeAllObjects];
    [self.heldDiceArray addObjectsFromArray:self.diceArray];
}


@end
