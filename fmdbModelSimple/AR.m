//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AR.h"

@implementation AR {

}
@synthesize db;

- (id)init {
    if (self = [super init]) {
        [self connectTo:@"/tmp/tmp.db"];
    }
    return self;
}

+ (AR *)shared {
    static AR *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (BOOL *)connectTo:(NSString *)dbpath {
    self.db = [FMDatabase databaseWithPath:dbpath];
    [self.db open];
    self.db.logsErrors = YES;
    return YES;
}

@end