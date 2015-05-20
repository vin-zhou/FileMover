//
//  main.m
//  FileMover
//
//  Created by Zhou, Wenshan on 5/20/15.
//  Copyright (c) 2015 MicroStrategy. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    @autoreleasepool
    {
        NSFileManager* fManager = [NSFileManager defaultManager];
        NSString* fileListPath = @"";
        NSString* fileListConent = [NSString stringWithContentsOfFile:fileListPath encoding:NSUTF8StringEncoding error:nil];
        NSMutableDictionary* sourceFilesDic = [[NSMutableDictionary alloc] init];
        for (NSString* line in [fileListPath componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]])
        {
            NSString* fileName = [line lastPathComponent];
            if (![sourceFilesDic doesContain:fileName])
            {
                [sourceFilesDic setObject:[NSString stringWithFormat:@"/%@", line] forKey:fileName];
            }
        }
        
        // search then replace
        

        
        
        
        
    }
    return 0;
}
