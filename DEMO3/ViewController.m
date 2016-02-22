//
//  ViewController.m
//  DEMO3
//
//  Created by Ralf Mauk on 1/27/16.
//  Copyright © 2016 Rasia. All rights reserved.
//

#import "ViewController.h"
#import "pagaDetail.h"
#import "sqlite3.h"
@interface ViewController ()

@end


@implementation NSString (MD5)

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
   CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end

@implementation ViewController

UIAlertView *loGin;
NSString *usrName;
NSString *usrPW;



- (void)viewDidLoad {

    [super viewDidLoad];
    loGin = [[UIAlertView alloc] initWithTitle:@"LOGIN" message:@"type your user name and password" delegate:self cancelButtonTitle:@"Canel" otherButtonTitles:@"Login", nil];
    loGin.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [loGin show];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) alertView: (UIAlertView *) loGin didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        usrName = [loGin textFieldAtIndex:0].text;
        usrPW = [loGin textFieldAtIndex:1].text;
        if ([self userID:usrName password:usrPW]) {
            NSLog(@"Login Success");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            pagaDetail *dest = [storyboard instantiateViewControllerWithIdentifier:@"pageDetail"];
            //[self presentViewController:dest animated:YES completion:nil];
            [self.navigationController pushViewController:dest animated:YES];
            
        } else {
            NSLog(@"Login Fail");
            [loGin show];

        }
    } else {
        [self xxx];
    }
    
}

- (void) exitApp {
    exit(5000);
}

- (void) xxx {
    UIAlertView *exitApp = [[UIAlertView alloc] initWithTitle:@"Goodbye!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [exitApp show];
    [self performSelector:@selector(exitApp) withObject:nil afterDelay:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)userID:(NSString *)usrID password:(NSString *)password{
    //    NSBundle *mainBundle = [NSBundle mainBundle];
    //    NSString *databasePath = [mainBundle pathForResource: @"DataDemo3" ofType: @"sqlite"];
    NSString *databaseName = @"anhminhhucau2.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success=[fileManager fileExistsAtPath:databasePath];
    if (!success) {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
    
    sqlite3 *contactDB;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &contactDB)==SQLITE_OK){
        NSLog(@"Connected Database Successfull");
        static sqlite3_stmt *statement;
        NSString *sql = [NSString stringWithFormat:@"SELECT Password FROM accusr WHERE ID = '%@'",usrID];
        const char *query_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, nil)==SQLITE_OK){
            while(sqlite3_step(statement)==SQLITE_ROW){
                NSString *hoten = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                if ([password isEqualToString:hoten]) {
                    return YES;
                }
                else
                {
                    return NO;
                }
            }
            sqlite3_finalize(statement);
        } else {
            return NO;
        }
    }
    return NO;
}


@end
