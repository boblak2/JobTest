//
//  PublicProfileViewController.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/12/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "PublicProfileViewController.h"
#import "TFHpple.h"
#import "Common.h"

@interface PublicProfileViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *theTableView;
    float screenWidth;
    float screenHeight;
    NSMutableArray *dataArr;
    
}

@end

@implementation PublicProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    
    dataArr = [NSMutableArray array];
    
    
    if (![Common connected]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
        actionWithTitle:@"OK"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    //Handle your yes please button action here
                }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    float margin=10;
    theTableView = [[UITableView alloc] initWithFrame:CGRectMake(margin, margin, screenWidth - 2*margin, screenHeight - 2*margin) style:UITableViewStylePlain];
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [self.view addSubview:theTableView];
    
    
    dispatch_async(dispatch_queue_create("bgQue", NULL), ^{
        
        [self doInBackground];
        
    });
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//Work in background thread
-(void)doInBackground{
    
    NSString *sUrl = [NSString stringWithFormat:@"https://www.google.com/search?q=%@",
                      [Common urlEncode:_employeeDetail.name]];
    NSURL *url = [NSURL URLWithString:sUrl];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    TFHpple *doc = [TFHpple hppleWithHTMLData:data];
    
    NSArray * elements  = [doc searchWithXPathQuery:@"//div[@class='PpBGzd YcUVQe MUxGbd v0nnCb']"];
    
    int counter=0;
    
    for (TFHppleElement *el in elements) {
        
        NSString *content = [el content];
        
        if (content && content.length > 0) {
            NSLog(@"%@", content);
            [dataArr addObject:content];
            
            counter++;
            if (counter > 4) {
                break;
            }
        }
        
        
    }
    
    //Refresh on main Thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->theTableView reloadData];
    });
    
}

#pragma mark UITableView Delegate, DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifire = @"CellGoogle";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        
    }
    
    NSString *content = [dataArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = content;
    
    return cell;
    
}

@end
