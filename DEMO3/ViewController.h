//
//  ViewController.h
//  DEMO3
//
//  Created by Ralf Mauk on 1/27/16.
//  Copyright © 2016 Rasia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSString *verifyCode;

@end

@interface NSString (MD5)

- (NSString *)MD5String;

@end

