#import "ArrayCalculator.h"

@implementation ArrayCalculator

+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSArray<NSNumber*>* numbersArray = [self getSortedNumbersArray:array];
    if (numberOfItems == 0 || numbersArray.count == 0) {
        return 0;
    }
    
    if (numberOfItems >= numbersArray.count) {
        return [ArrayCalculator getProductOfNumbersArray:numbersArray];
    }
    
    NSMutableArray *positiveNumbers = [NSMutableArray new];
    NSMutableArray *negativeNumbers = [NSMutableArray new];
    
    for (NSNumber *number in numbersArray) {
        if ([number intValue] < 0) {
            [negativeNumbers addObject:number];
        } else {
            [positiveNumbers addObject:number];
        }
    }
    
    NSArray *positiveNumberDescending = [[[positiveNumbers sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
    NSArray *highestPositiveNumbersDescending = [positiveNumberDescending subarrayWithRange:NSMakeRange(0, numberOfItems > positiveNumbers.count ?  positiveNumbers.count : numberOfItems)];
    
    NSMutableArray *numbersToMultiply = [[[highestPositiveNumbersDescending reverseObjectEnumerator] allObjects] mutableCopy];

    if (negativeNumbers.count > 1) {
        NSMutableArray *negativeNumbersDescending = [[negativeNumbers sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
        
        for (int i = 0; i < (negativeNumbersDescending.count / 2); i++) {
            NSNumber *firstNegative = negativeNumbersDescending[i];
            NSNumber *secondNegative = negativeNumbersDescending[i + 1];
            
            NSNumber *first = numbersToMultiply[i];
            NSNumber *second = numbersToMultiply[i + 1];
            
            int positiveProduct = [first intValue] * [second intValue];
            int negativeProduct = [firstNegative intValue] * [secondNegative intValue];
            
            if (negativeProduct > positiveProduct) {
                [numbersToMultiply replaceObjectAtIndex:i withObject:firstNegative];
                [numbersToMultiply replaceObjectAtIndex:(i + 1) withObject:secondNegative];
            }
        }
    }
    
    return [ArrayCalculator getProductOfNumbersArray:numbersToMultiply];
}

+ (NSInteger)getProductOfNumbersArray:(NSArray *)array {
    NSInteger result = 1;
    for (id number in array) {
        result *= [number intValue];
    }
    return result;
}

+ (NSArray<NSNumber*>*) getSortedNumbersArray:(NSArray*)array {
    NSMutableArray<NSNumber*>* numbersArray = [NSMutableArray new];
    for (int i = 0; i < array.count ; i++) {
        if([array[i] isKindOfClass:[NSNumber class]]) {
            [numbersArray addObject:array[i]];
        }
    }
    return [numbersArray copy];
}

@end
