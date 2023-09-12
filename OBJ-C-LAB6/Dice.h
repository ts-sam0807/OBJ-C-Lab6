//
//  Dice.h
//  OBJ-C-LAB6
//
//  Created by Ts SaM on 11/9/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dice : NSObject

@property (nonatomic) NSInteger currentValue;

- (void)randomizeValue;


@end

NS_ASSUME_NONNULL_END
