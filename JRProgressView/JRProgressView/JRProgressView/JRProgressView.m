//
//  JRProgressView.m
//  JRProgressView
//
//  Created by jackfrow on 2021/5/24.
//


#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

#import "JRProgressView.h"
#import "UIColor+Hex.h"

@implementation JRProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
        [self setupViews];
        [self setupContrails];
    }
    return self;
}


-(void)configure{
    
    self.bounds = CGRectMake(20, 0, SWIDTH - 40 , 10);
    self.backgroundColor = [UIColor colorWithHexString:@"1F1928"];
    self.clipsToBounds = true;
    self.layer.cornerRadius = 100;
    
}

-(void)setupViews{
    
}

-(void)setupContrails{

}

@end
