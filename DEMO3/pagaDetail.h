//
//  pagaDetail.h
//  DEMO3
//
//  Created by Ralf Mauk on 1/27/16.
//  Copyright © 2016 Rasia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pagaDetail : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *idNumber;
@property (strong, nonatomic) IBOutlet UILabel *usrName;
@property (strong, nonatomic) IBOutlet UILabel *usrFirstName;
@property (strong, nonatomic) IBOutlet UILabel *usrEmail;
//@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *viewWait;
- (IBAction)saveToPDF:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *usrAddress;
- (IBAction)getIDNumber:(id)sender;
@end
