//
//  GameController.h
//  OBJ-C-LAB6
//
//  Created by Ts SaM on 11/9/2023.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameController : NSObject

@property (nonatomic, strong) NSMutableArray<Dice *> *diceArray;
@property (nonatomic, strong) NSMutableArray<Dice *> *heldDiceArray;
@property (nonatomic) NSInteger rollsSinceLastReset;

- (void)createDiceInstances;
- (void)rollDice;
- (void)toggleHoldDie:(NSUInteger)index;
- (void)resetDice;
- (NSInteger)calculateCurrentScore;
- (void)displayDiceValuesAndScore;
- (void)holdAllDice;

@end

NS_ASSUME_NONNULL_END
