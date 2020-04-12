#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    NSMutableArray *result = [NSMutableArray new];
    NSArray<NSNumber*>* numbers = [self convertToNumbers:number];
    
    for (int i = 0; i < numbers.count; i++) {
        int val = [numbers[i] intValue];
        if ([number characterAtIndex:i] >= 48 && [number characterAtIndex:i] <= 57){
            NSArray *posibleNumbers = [self neighbors:val];
            for (NSString *string in posibleNumbers) {
                NSString *resultNumber = [number stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:string];
                [result addObject:resultNumber];
            }
        } else {
            return nil;
        }
    }
    
    return [result copy];
}

- (NSArray *)neighbors:(int)number {
    switch (number) {
        case 0:
            return @[@"8"];
        case 1:
            return @[@"2", @"4"];
        case 2:
            return @[@"1", @"3", @"5"];
        case 3:
            return @[@"2", @"6"];
        case 4:
            return @[@"1", @"5", @"7"];
        case 5:
            return @[@"2", @"4", @"6", @"8"];
        case 6:
            return @[@"3", @"5", @"9"];
        case 7:
            return @[@"4", @"8"];
        case 8:
            return @[@"0", @"5", @"7", @"9"];
        case 9:
            return @[@"6", @"8"];
        default:
            return @[];
    }
}

- (NSArray<NSNumber*>*) convertToNumbers:(NSString*)numbers {
    NSMutableArray<NSNumber*>* ret = [NSMutableArray new];
    char charStr[numbers.length];
    strcpy(charStr, [numbers UTF8String]);
    for (int i = 0; i < [numbers length]; i++) {
        char c = charStr[i];
        int val = atoi(&c);
        NSNumber* number = [NSNumber numberWithInt:val];
        [ret addObject:number];
    }
    
    return [ret copy];
}

@end
