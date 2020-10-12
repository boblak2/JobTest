//
//  ViewController.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "ViewController.h"
#import "EmployeeTableViewCell.h"
#import "Employee.h"
#import "DBHandler.h"
#import "PublicProfileViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *employeesArr;
    DBHandler *dbHandler;
    
}

@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UITableView *labelNoEmployees;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dbHandler = [DBHandler getInstance];
    employeesArr = [NSMutableArray array];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [employeesArr removeAllObjects];
    NSArray *tmpEmployeesArr = [dbHandler employees];
    
    if (tmpEmployeesArr.count > 0) {
        
        _theTableView.hidden = NO;
        _labelNoEmployees.hidden = YES;
        for (Employee *el in tmpEmployeesArr) {
            [employeesArr addObject:el];
        }
        [_theTableView reloadData];
        
    }else{
        
        _theTableView.hidden = YES;
        _labelNoEmployees.hidden = NO;
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return employeesArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmployeeTableViewCell *cell = (EmployeeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];

    Employee *employee = [employeesArr objectAtIndex:indexPath.row];
    
    if (employee.isMale) {
        cell.backgroundColor = [UIColor colorWithRed:153/255.0 green:204/255.0 blue:255/255.0 alpha:1];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:229/255.0 alpha:1];
    }
    
    cell.labelId.text = [NSString stringWithFormat:@"%d", employee.employeeId];
    cell.labelName.text = employee.name;
    cell.labelDateOfBirth.text = employee.dateOfBirth;
    cell.labelGender.text = [NSString stringWithFormat:@"%@", employee.isMale ? @"male" : @"female"];
    cell.labelSalary.text = [NSString stringWithFormat:@"%.1f eur/month", employee.salary];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Employee *employee = [employeesArr objectAtIndex:indexPath.row];
    NSLog(@"%@", employee.name);
    
    //
    [self performSegueWithIdentifier:@"PublicProfileSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"PublicProfileSegue"]) {
        
        NSIndexPath *indexPath = [_theTableView indexPathForSelectedRow];
        
        PublicProfileViewController *vc = (PublicProfileViewController *)segue.destinationViewController;
        vc.employeeDetail = [employeesArr objectAtIndex:indexPath.row];
        
    }
    
}

@end
