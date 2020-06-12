#import "FullBinaryTrees.h"

@interface  FullBinaryTrees ()
@property (nonatomic, strong) NSMutableArray * arrayOfTrees;
-(void) buildTree:(NSMutableArray *) initialTree with:(int) nodes upTo:(int) totalNodes;
@end

@implementation FullBinaryTrees

NSString *printTree(NSMutableArray * tree){
    NSString * res = @"[";
    NSString * nullCumul = @"";
    for(int i = 0; i < tree.count; i++){
        NSArray * level = tree[i];
        for(int j = 0; j < level.count; j++){
            NSString * element = level[j];
            if (i > 0 && [tree[i - 1][j / 2] isEqualToString:@"null"] ){
                continue;
            }
            if ([element isEqualToString:@"0"]) {
                res = [res stringByAppendingString:nullCumul];
                nullCumul = @"";
                res = [res stringByAppendingString:element];
                res = [res stringByAppendingString:@","];
            } else {
                nullCumul = [nullCumul stringByAppendingString:element];
                nullCumul = [nullCumul stringByAppendingString:@","];
            }
        }
    }
    res = [res stringByReplacingCharactersInRange:NSMakeRange(res.length-1,1) withString:@"]"];
    return res;
}

- (NSString *) printTrees:(NSMutableArray *)trees {
    NSMutableString * res = [[NSMutableString alloc]initWithString:@"["];
    for(NSMutableArray * tree in trees){
        [res appendString:printTree(tree)];
        [res appendString:@","];
    }
    [res replaceCharactersInRange:NSMakeRange(res.length-1,1) withString:@"]"];
    return [res copy];
}

-(void) buildTree:(NSMutableArray *) sourceTree with:(int) nodes upTo:(int) totalNodes{
    if (totalNodes == nodes) {
        [self.arrayOfTrees addObject:sourceTree];
    } else {
        for(int i = 0; i < sourceTree.count; i++){
            NSArray * level = sourceTree[i];
            for(int j = 0; j < level.count; j++){
                NSString * element = level[j];
                if ([element isEqualToString:@"0"] &&
                    (i == sourceTree.count - 1 || ([sourceTree[i + 1][2 * j] isEqualToString:@"null"]))
                    ){
                    NSMutableArray *newTree = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[NSString class], nil] fromData:[NSKeyedArchiver archivedDataWithRootObject:sourceTree requiringSecureCoding:true error:nil] error:nil];
                    if (i == sourceTree.count - 1){
                        NSMutableArray *newLevel = [NSMutableArray new];
                        for (int u = 0; u < pow(2,sourceTree.count); u++){
                            [newLevel addObject:@"null"];
                        }
                        [newTree addObject:newLevel];
                    }
                    newTree[i + 1][2 * j] = @"0";
                    newTree[i + 1][2 * j + 1] = @"0";
                    [self buildTree:newTree with:(nodes+2) upTo:totalNodes];
                }
            }
        }
    }
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    self.arrayOfTrees = [NSMutableArray new];
    int val = (int)count;
    if (val % 2 > 0) {
        NSMutableArray *core = [@[ @[@"0"] ] mutableCopy];
        [self buildTree:core with:(int)1 upTo:(int)count];
        return [self printTrees:self.arrayOfTrees];
    }
    return @"[]";
}

@end
