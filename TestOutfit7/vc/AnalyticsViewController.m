//
//  AnalyticsViewController.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/9/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "AnalyticsViewController.h"
#import "DBHandler.h"
#import "Employee.h"

@interface AnalyticsViewController (){
    
    DBHandler *dbHandler;
    NSMutableArray *employeesArr;
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelAverageAge;
@property (weak, nonatomic) IBOutlet UILabel *labelMedianAge;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxSalary;
@property (weak, nonatomic) IBOutlet UILabel *labelMaleFemaleRatio;


@end

@implementation AnalyticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dbHandler = [DBHandler getInstance];
    employeesArr = [dbHandler employees];
    
    
    if (employeesArr.count == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No employees saved!" preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    
    long sum = 0;
    for (Employee *el in employeesArr) {
        sum += el.age;
    }
    
    long averageAge = sum / employeesArr.count;
    
    NSLog(@"averageAge:%ld  %@", averageAge, [Employee dateFromEpoch:averageAge]);
    _labelAverageAge.text = [NSString stringWithFormat:@"%@", [Employee dateFromEpoch:averageAge]];
    
    //Median
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [employeesArr sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    NSString *medianaAge;
    if (employeesArr.count % 2 == 0) {
        
        //Soda Median age is beteween 2 Employes
        NSInteger middleIndex = employeesArr.count / 2;
        Employee *first = [employeesArr objectAtIndex:middleIndex-1];
        Employee *second = [employeesArr objectAtIndex:middleIndex];
        long diff = (second.age + first.age) / 2.0;
        medianaAge = [Employee dateFromEpoch:diff];
        NSLog(@"mediana:%@ %@", medianaAge, @"Nima imena");
        
    }else{
        
        //Liha //Median age is middle Employee
        NSInteger middleIndex = employeesArr.count/2;
        Employee *employeeMiddle = [employeesArr objectAtIndex:middleIndex];
        medianaAge = [Employee dateFromEpoch:employeeMiddle.age];
        NSLog(@"mediana:%@ %@", medianaAge, employeeMiddle.name);
        
    }
    
    if (medianaAge) {
        _labelMedianAge.text = medianaAge;
    }
    
    //Max salary
    double maxSalary = 0;
    for (Employee *el in employeesArr) {
        if (el.salary > maxSalary) {
            maxSalary = el.salary;
        }
    }
    
    NSLog(@"MaxSalary:%f", maxSalary);
    _labelMaxSalary.text = [NSString stringWithFormat:@"%.1f", maxSalary];
 
    //Male vs Female workers ratio
    int male=0;
    int female=0;
    for (Employee *el in employeesArr) {
        if (el.isMale) {
            male++;
        }else{
            female++;
        }
    }
    
    int gcd = getGcd(male, female);
    NSLog(@"gcd:%d", gcd);
    NSLog(@"razmerje je %d:%d", male/gcd, female/gcd);
    _labelMaleFemaleRatio.text = [NSString stringWithFormat:@"%d:%d",
                                  male/gcd,
                                  female/gcd];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


int getGcd (int a, int b){
    int c;
    while ( a != 0 ) {
        c = a; a = b%a; b = c;
    }
    return b;
}

@end
