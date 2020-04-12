#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    int initialNumber = [(NSNumber*) number intValue];
    return [self decomposeNumberRec:initialNumber leftSpace:pow(initialNumber, 2)];
}

- (NSMutableArray <NSNumber*>*)decomposeNumberRec:(int)initialNumber
                                 leftSpace:(long) leftSpace {
    int maximalClosestNumber = initialNumber - 1;
    NSMutableArray *res = [[NSMutableArray alloc] init];
    if (leftSpace == 0) {
        return res;
    }
    while (maximalClosestNumber > 0) {
        int leftSpaceAfterSubtraction = leftSpace - pow(maximalClosestNumber, 2);
        if (leftSpaceAfterSubtraction >= 0) {
            res = [self decomposeNumberRec:maximalClosestNumber
                                 leftSpace:leftSpaceAfterSubtraction];
            if (res != nil) {
                [res addObject:@(maximalClosestNumber)];
                return res;
            }
        }
        maximalClosestNumber--;
    }
    return nil;
}

@end
