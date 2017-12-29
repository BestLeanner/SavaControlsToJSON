//
//  KeepLabelInfoModel.h
//  Json
//
//  Created by zhaohang on 2017/12/28.
//  Copyright © 2017年 HangZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeepLabelInfoModel : NSObject
+(KeepLabelInfoModel *)getInstance;
@property (nonatomic, strong, readonly) NSMutableArray *infoArray;
-(void)addObject:(UILabel *)anObject;

@property (nonatomic, readonly) NSString *JSONString;
@property (nonatomic, readonly) NSData *JSONData;
-(void)modelObjectsWithJSONString:(NSString *)jsonString;
-(void)modelObjectWithJSONData:(NSData *)jsonData;
@property(nonatomic, strong) NSError *error;
//记录所生成的对象
@property (nonatomic, strong, readonly) NSArray *modelObject;
@end
