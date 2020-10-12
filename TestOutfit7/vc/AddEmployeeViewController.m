//
//  AddEmployeeViewController.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "AddEmployeeViewController.h"
#import "Employee.h"
#import "DBHandler.h"
#import "Common.h"

@interface AddEmployeeViewController (){
    
    UITextField *tfName;
    UITextField *tfDateOfBirth;
    UISwitch *theSwitch;
    UILabel *labelGender;
    UITextField *tfSalary;
    
    DBHandler *dbHandler;
    
}

@end

@implementation AddEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    float screenWidth = self.view.frame.size.width;
    //float screenHeight = self.view.frame.size.height;
    
    dbHandler = [DBHandler getInstance];
    
    float marginX = 20;
    float marginY = 25;
    
    UIView *viewPaddingName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    UIView *viewPaddingDoB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    UIView *viewPaddingSalary = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
    
    tfName = [[UITextField alloc] init];
    tfName.frame = CGRectMake(marginX, 110, screenWidth - 2*marginX, 34);
    tfName.layer.cornerRadius = 10;
    tfName.layer.masksToBounds = YES;
    tfName.layer.borderColor = [UIColor grayColor].CGColor;
    tfName.layer.borderWidth = 1;
    tfName.placeholder = @"Name and surname";
    tfName.leftView = viewPaddingName;
    tfName.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:tfName];
    
    
    tfDateOfBirth = [[UITextField alloc] init];
    tfDateOfBirth.frame = CGRectMake(marginX, tfName.frame.origin.y + tfName.frame.size.height + marginY, screenWidth - 2*marginX, 34);
    tfDateOfBirth.layer.cornerRadius = 10;
    tfDateOfBirth.layer.masksToBounds = YES;
    tfDateOfBirth.layer.borderColor = [UIColor grayColor].CGColor;
    tfDateOfBirth.layer.borderWidth = 1;
    tfDateOfBirth.placeholder = @"Date of birth  d.M.yyyy";
    tfDateOfBirth.leftView = viewPaddingDoB;
    tfDateOfBirth.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:tfDateOfBirth];
    
    theSwitch = [[UISwitch alloc] init];
    theSwitch.frame = CGRectMake(marginX, tfDateOfBirth.frame.origin.y + tfDateOfBirth.frame.size.height + marginY, 49, 31);
    [theSwitch setOn:YES];
    [theSwitch setOnTintColor:[UIColor blueColor]];
    [theSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:theSwitch];
    
    labelGender = [[UILabel alloc] init];
    labelGender.frame = CGRectMake(theSwitch.frame.origin.x + theSwitch.frame.size.width + marginX, theSwitch.frame.origin.y, 100, theSwitch.frame.size.height);
    labelGender.text = @"Male";
    [self.view addSubview:labelGender];
    
    
    tfSalary = [[UITextField alloc] init];
    tfSalary.frame = CGRectMake(marginX, theSwitch.frame.origin.y + theSwitch.frame.size.height + marginY, screenWidth - 2*marginX, 34);
    tfSalary.layer.cornerRadius = 10;
    tfSalary.layer.masksToBounds = YES;
    tfSalary.layer.borderColor = [UIColor grayColor].CGColor;
    tfSalary.layer.borderWidth = 1;
    tfSalary.placeholder = @"Salary";
    tfSalary.leftView = viewPaddingSalary;
    tfSalary.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:tfSalary];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)switchValueChanged:(UISwitch *)sender{
    
    NSLog(@"%@", sender.isOn ? @"ON" : @"OFF");
    
    if (sender.isOn) {
        labelGender.text = @"Male";
    }else{
        labelGender.text = @"Female";
    }
    
}

- (IBAction)didPressBtnSave:(id)sender {
    
    BOOL isDataMissing = NO;
    
    if (tfName && tfName.text.length > 0) {
        tfName.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        tfName.layer.borderColor = [UIColor redColor].CGColor;
        isDataMissing = YES;
    }
    
    if (tfDateOfBirth && tfDateOfBirth.text.length > 0 && [Common isDateCorrect:tfDateOfBirth.text]) {
        tfDateOfBirth.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        tfDateOfBirth.layer.borderColor = [UIColor redColor].CGColor;
        isDataMissing = YES;
    }
    
    if (tfSalary && tfSalary.text.length > 0 && [Common isNumber:tfSalary.text]) {
        tfSalary.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        tfSalary.layer.borderColor = [UIColor redColor].CGColor;
        isDataMissing = YES;
    }
    
    if (isDataMissing) {
        NSLog(@"Alert");
    }else{
        [self saveEmployee];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)saveEmployee{
    
    Employee *employee = [[Employee alloc] init];
    employee.name = tfName.text;
    employee.dateOfBirth = tfDateOfBirth.text;
    employee.isMale = theSwitch.isOn;
    employee.salary = [tfSalary.text doubleValue];
    
    [dbHandler addEmployee:employee];
    
}

@end
