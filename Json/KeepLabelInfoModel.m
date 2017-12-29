//
//  KeepLabelInfoModel.m
//  Json
//
//  Created by zhaohang on 2017/12/28.
//  Copyright © 2017年 HangZhao. All rights reserved.
//

#import "KeepLabelInfoModel.h"

@implementation KeepLabelInfoModel

+(KeepLabelInfoModel *)getInstance{
    static dispatch_once_t pred;
    static KeepLabelInfoModel *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[KeepLabelInfoModel alloc] init];
    });
    return instance;
}

-(void)dealloc{
    _infoArray = nil;
    _error = nil;
    _modelObject = nil;
}

-(void)addObject:(UILabel *)anObject{
    if (_infoArray == nil) {
        _infoArray = [NSMutableArray array];
    }
    if (anObject == nil || [anObject isKindOfClass:[UILabel class]] == NO) {
        return;
    }
    NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
    [tempDictionary setObject:anObject.text forKey:@"text"];
    [tempDictionary setObject:NSStringFromCGRect(anObject.frame) forKey:@"frame"];
    [tempDictionary setObject:NSStringFromCGAffineTransform(anObject.transform) forKey:@"tranform"];
    [tempDictionary setObject:[self getHSBStringByColor:anObject.textColor] forKey:@"textColor"];
    [tempDictionary setObject:[self getHSBStringByColor:anObject.backgroundColor] forKey:@"backgroundColor"];
    [_infoArray addObject:tempDictionary];
}

-(NSString *)JSONString{
    if (_infoArray == nil) {
        return nil;
    }
    NSError *tempError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_infoArray options:NSJSONWritingPrettyPrinted error:&tempError];
    if (tempError == nil) {
        NSString *jsonstring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonstring;
    }
    self.error = tempError;
    return nil;
}

-(NSData *)JSONData{
    if (_infoArray == nil) {
        return nil;
    }
    NSError *tempError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_infoArray options:NSJSONWritingPrettyPrinted error:&tempError];
    if (tempError == nil) {
        return jsonData;
    }
    self.error = tempError;
    return nil;
}

-(void)modelObjectWithJSONData:(NSData *)jsonData{
    if (jsonData == nil) {
        return;
    }
    NSError *tempError = nil;
    NSArray *temparr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&tempError];
    if (tempError) {
        self.error = tempError;
        return;
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *tempDictionary in temparr) {
        UILabel *tempLabel = [[UILabel alloc] init];
        NSString *tempText = tempDictionary[@"text"];
        if (tempText && [tempText isKindOfClass:[NSString class]]) {
            tempLabel.text = tempText;
        }
        NSString *tempFrame = tempDictionary[@"frame"];
        if (tempFrame && [tempFrame isKindOfClass:[NSString class]]) {
            tempLabel.frame = CGRectFromString(tempFrame);
        }
        NSString *tempTransform = tempDictionary[@"transform"];
        if (tempTransform && [tempTransform isKindOfClass:[NSString class]]) {
            tempLabel.transform = CGAffineTransformFromString(tempTransform);
        }
        NSString *tempTextColor = tempDictionary[@"textColor"];
        if (tempTextColor && [tempTextColor isKindOfClass:[NSString class]]) {
            tempLabel.textColor = [self colorWithRGBAString:tempTextColor];
        }
        NSString *tempBackGroundColor = tempDictionary[@"backgroundColor"];
        if (tempBackGroundColor && [tempBackGroundColor isKindOfClass:[NSString class]]) {
            tempLabel.backgroundColor = [self colorWithRGBAString:tempBackGroundColor];
        }
        [tempArray addObject:tempLabel];
    }
    _modelObject = tempArray;
}

-(void)modelObjectsWithJSONString:(NSString *)jsonString{
    if (jsonString == nil) {
        return;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [self modelObjectWithJSONData:jsonData];
}

-(NSString *)getHSBStringByColor:(UIColor *)originColor{
    CGFloat r=0,g=0,b=0,a=0;
    if ([originColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    return [NSString stringWithFormat:@"(%0.2f,%0.2f,%0.2f,%0.2f)",r,g,b,a];
}


-(UIColor *)colorWithRGBAString:(NSString *)aColorString{
    if (aColorString == nil) {
        return nil;
    }
   
    NSString *tempString = [aColorString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *tempArray = [tempString componentsSeparatedByString:@","];

    if (tempArray && tempArray.count == 4) {
        NSLog(@"%f",[tempArray[0] floatValue]);
        return [UIColor colorWithRed:[tempArray[0] floatValue] green:[tempArray[1] floatValue] blue:[tempArray[2] floatValue] alpha:[tempArray[3] floatValue]];
    }
    return nil;
}

@end
