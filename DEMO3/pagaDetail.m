//
//  pagaDetail.m
//  DEMO3
//
//  Created by Ralf Mauk on 1/27/16.
//  Copyright © 2016 Rasia. All rights reserved.
//

#import "pagaDetail.h"
#import <CoreText/CoreText.h>
#import <sqlite3.h>
@implementation pagaDetail
-(void) viewDidLoad {
//     NSMutableArray *list = [[NSMutableArray alloc]init];
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSString *databasePath = [mainBundle pathForResource: @"DataDemo3" ofType: @"sqlite"];
//    [self _usrName:nil _usrFirstName:nil _usrEmail:nil _usrAdres:nil];
//    [self Query:list];
    [self usrName:_usrName usrFirstName:_usrFirstName usrEmail:_usrEmail usrAdres:_usrAddress];
//      _viewWait = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _viewWait.hidesWhenStopped = YES;
//    _viewWait.center = CGPointMake(160, 240);
//    NSString *showText = [NSString stringWithFormat:@"%@",[usrInfo valueForKey:@"email"]];
    //_textInfo.text = [self Showview:list];
}

-(void) usrName:(UILabel *)usrName usrFirstName:(UILabel *)usrFirstName usrEmail:(UILabel *)usrEmail usrAdres:(UITextView *)usrAddress  {
    usrName.text = nil;
    usrFirstName.text = nil;
    usrEmail.text = nil;
    usrAddress.text = nil;
}

-(NSString *)Showview:(NSMutableArray *) list {
    NSString *s = @"";
    for (int index = 0; index < [list count]; index++ ) {

        s = [s stringByAppendingString:[[list objectAtIndex:index] objectForKey:@"Name"]];
    }
    return s;
}

//-(void)Query:(NSMutableArray *)list {
//    NSString *databaseName = @"DataDemo3.sqlite";
//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [documentPaths objectAtIndex:0];
//    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL success=[fileManager fileExistsAtPath:databasePath];
//    if (!success) {
//        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
//        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
//    }
//
//    NSMutableDictionary *staff;
//    sqlite3 *contactDB;
//    const char *dbpath = [databasePath UTF8String];
//    if(sqlite3_open(dbpath, &contactDB)==SQLITE_OK){
//        NSLog(@"Connected Database Successfull");
//        static sqlite3_stmt *statement;
//        NSString *sql = @"SELECT * FROM Employer";
//        const char *query_stmt = [sql UTF8String];
//        if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, nil)==SQLITE_OK){
//            while(sqlite3_step(statement)==SQLITE_ROW){
//                //int idN =sqlite3_column_int(statement, 0);
//                NSString *hoten = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
//                NSString *diachi = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
//                NSString *congty = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 3)];
//                NSInteger tuoi = sqlite3_column_int(statement, 4);
//                NSInteger luong = sqlite3_column_int(statement, 5);
//                staff = [NSMutableDictionary dictionaryWithDictionary:@{
//                                                                        @"Name":hoten,
//                                                                        @"Address":diachi,
//                                                                        @"Company":congty,
//                                                                        @"Age":[NSNumber numberWithInteger:tuoi],
//                                                                        @"Salary":[NSNumber numberWithInteger:luong]}];
//                [list addObject:staff];
//                //                NSString *hoten = [NSString stringWithFormat:@"%i - %@ %@", idN, ho, ten];
//                
//                NSLog(@"%@",staff);
//            }
//            sqlite3_finalize(statement);
//        } else {
//            NSLog(@"Query Failed");
//        }
//        
//        
//    }else{
//        NSLog(@"Có lỗi xảy ra");
//    }
//    
//}

- (void)writeJsonToFile : (NSString *)idNumber
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *stringURL = [NSString stringWithFormat:@"http://dbtravel.rasia.wiki/index.cfm/api/getUserInfo?verifyCode=1111-1111-1111-%@",idNumber];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if (urlData)
    {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"user.json"];
        [urlData writeToFile:filePath atomically:YES];
    }
    else
    {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"user.json"];
        
        NSString *json = [ [NSBundle mainBundle] pathForResource:@"user" ofType:@"json" inDirectory:@"html/data" ];
        NSData *jsonData = [NSData dataWithContentsOfFile:json options:kNilOptions error:nil];
        
        [jsonData writeToFile:filePath atomically:YES];
    }
}
-(NSMutableDictionary *)parseJson
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError *jsonError = nil;
    NSString *jsonFilePath1 = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"user.json"];
    NSData *jsonData1 = [NSData dataWithContentsOfFile:jsonFilePath1 options:kNilOptions error:&jsonError ];
    NSMutableDictionary *parseResult = [NSJSONSerialization JSONObjectWithData:jsonData1 options:NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"%@",parseResult);
    return parseResult;
}
- (IBAction)getIDNumber:(id)sender {
//    [_viewWait startAnimating];
    NSString *idNumber = _idNumber.text;
    [self writeJsonToFile:idNumber];
    NSMutableDictionary *accInfomation = [NSMutableDictionary alloc];
    accInfomation = [self parseJson];
//    [_viewWait stopAnimating];
    if (accInfomation == nil) {
        [self usrName:_usrName usrFirstName:_usrFirstName usrEmail:_usrEmail usrAdres:_usrAddress];
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Wrong ID" message:@"Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [error show];
    } else {
    _usrName.text = [accInfomation objectForKey:@"name"];
    _usrFirstName.text = [accInfomation objectForKey:@"firstname"];
    _usrEmail.text = [accInfomation objectForKey:@"email"];
    _usrAddress.text = [NSString stringWithFormat:@"%@/%@\n%@/%@",
                        [[[accInfomation objectForKey:@"mainHouseNo"]componentsSeparatedByString:@";;"] objectAtIndex:0],
                        [[[accInfomation objectForKey:@"mainStreet"] componentsSeparatedByString:@";;"] objectAtIndex:0],
                        [[[accInfomation objectForKey:@"mainPlace"] componentsSeparatedByString:@";;"] objectAtIndex:0],
                        [[[accInfomation objectForKey:@"mainCountry"] componentsSeparatedByString:@";;"] objectAtIndex:0]];
    }
    
}
- (IBAction)saveToPDF:(id)sender {
    
}

-(void)setUpFDFFileWithName : (NSString *)name Width:(float) width Height:(float)height {
    CGSize pageSize = CGSizeMake(width, height);
    NSString *pdfFileName = [NSString stringWithFormat:@"%@.pdf",name];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:pdfFileName];
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
    
}


@end
