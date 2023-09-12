//
//  main.m
//  OBJ-C-LAB6
//
//  Created by Ts SaM on 11/9/2023.
//

#import <Foundation/Foundation.h>
#import "GameController.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        GameController *gameController = [[GameController alloc] init];
        [gameController createDiceInstances];
        
        while (1) {
            [gameController displayDiceValuesAndScore];
            
            NSLog(@"Rolls Left: %ld", (long)(5 - gameController.rollsSinceLastReset));
        
            NSLog(@"\nType 'roll' to roll the dice,\n'hold' to hold/unhold dice,\n'reset' to reset held dice,\n'exit' to quit: \n");
            char input[255];
            fgets(input, 255, stdin);
            NSString *inputString = [[NSString stringWithUTF8String:input] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([inputString isEqualToString:@"exit"]) {
                break;
            } else if ([inputString isEqualToString:@"roll"]) {
                [gameController rollDice];
            } else if ([inputString isEqualToString:@"hold"]) {
                NSLog(@"Enter the indexes of dice to hold/unhold (e.g., 1 2 3):");
                char indexInput[255];
                fgets(indexInput, 255, stdin);
                NSString *indexesString = [[NSString stringWithUTF8String:indexInput] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSArray<NSString *> *indexes = [indexesString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                for (NSString *indexStr in indexes) {
                    NSUInteger index = [indexStr integerValue] - 1;
                    if (index < gameController.diceArray.count) {
                        [gameController toggleHoldDie:index];
                    } else {
                        NSLog(@"Invalid dice index: %@", indexStr);
                    }
                }
            } else if ([inputString isEqualToString:@"reset"]) {
                [gameController resetDice];
            } else {
                NSLog(@"Invalid input. Type 'roll', 'hold', 'reset' or 'exit'.");
            }
            
            if (gameController.rollsSinceLastReset == 5 || gameController.heldDiceArray.count == gameController.diceArray.count) {
                [gameController holdAllDice];
                [gameController displayDiceValuesAndScore];
                NSInteger finalScore = [gameController calculateCurrentScore];
                NSLog(@"Final Total Score: %ld", (long)finalScore);
                break;
            }
        }
        
    }
    return 0;
}
