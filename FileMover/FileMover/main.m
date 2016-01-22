//
//  main.m
//  FileMover
//
//  Created by Vin on 5/20/15.
//  Copyright (c) 2015 MicroStrategy. All rights reserved.
//

#import <Foundation/Foundation.h>


BOOL isSuccessReplace(NSString* destFile , NSString* sourceFile)
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:destFile])
    {
        // delete
        BOOL isDelete = [fileManager removeItemAtPath:destFile error:nil]; // delete old one
//        NSLog(@"%@ isDelete  %u", destFile, isDelete);
        // replace
        BOOL isCopy = [fileManager copyItemAtPath: sourceFile toPath:destFile error:nil]; // copy new one
//        NSLog(@"%@ isCopy  %u", sourceFile, isCopy);
        NSLog(@"%u (%u&&%u) = isDelete && isCopy  destFile=%@   sourceFile=%@", isDelete && isCopy, isDelete, isCopy, destFile, sourceFile);
        return YES;
    }
    else
        return NO;
}

//BOOL isSuccessTraverse(NSString* destPath, NSString* fileName, NSString* sourceFilePath)
//{
//    
//    BOOL isSuccess = isSuccessReplace([destPath stringByAppendingFormat:@"/%@", fileName], sourceFilePath);
//    if (isSuccess)
//    {
//        return isSuccess;
//    }
//    else
//    {
//        NSFileManager* fileManager = [NSFileManager defaultManager];
//        NSArray* paths = [fileManager subpathsAtPath:destPath];
//        for (int i = 0; i < paths.count; i++)
//        {
//            isSuccess = isSuccessTraverse(paths[i], fileName, sourceFilePath);
//            if (isSuccess)
//            {
//                break;
//            }
//        }
//        return isSuccess;
//    }
//}


int main(int argc, const char * argv[]) {
    
    @autoreleasepool
    {
        NSString* fileListPath = @"/Users/vin/sourceList.m"; // Contains the source file name list.
        NSString* fileListConent = [NSString stringWithContentsOfFile:fileListPath encoding:NSUTF8StringEncoding error:nil];
        NSMutableDictionary* sourceFilesDic = [[NSMutableDictionary alloc] init];
        for (NSString* line in [fileListConent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]])
        {
            if ([line isEqualToString:@""])
            {
                continue;
            }
            NSString* fileName = [line lastPathComponent];
            if (![sourceFilesDic doesContain:fileName])
            {
                [sourceFilesDic setObject:[NSString stringWithFormat:@"/Users/vin/XX2/%@", line] forKey:fileName]; // The source file full path.
            }
        }
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString* destPath = @"/Users/vin/XX1"; // The destination file folder
        // search then replace
        [sourceFilesDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         {
             NSArray* paths = [fileManager subpathsAtPath:destPath];
             for (int i = 0; i < paths.count; i++)
             {
                 NSString* lFileName = [((NSString*)paths[i]) lastPathComponent]; 
                 if ([lFileName isEqualToString:(NSString *)key]) // same filename
                 {
                     isSuccessReplace([destPath stringByAppendingFormat:@"/%@", paths[i]], (NSString*) obj); // replace the same name file
                 }
                 
             }
             
         }];

        
    }
    return 0;
}
