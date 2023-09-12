//
//  Dice.m
//  OBJ-C-LAB6
//
//  Created by Ts SaM on 11/9/2023.
//

#import "Dice.h"

@implementation Dice

- (instancetype)init {
    self = [super init];
    if (self) {
        [self randomizeValue];
    }
    return self;
}

- (void)randomizeValue {
    self.currentValue = arc4random_uniform(6) + 1;
}


@end
