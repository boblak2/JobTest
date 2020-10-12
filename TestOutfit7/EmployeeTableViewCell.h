//
//  EmployeeTableViewCell.h
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelId;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDateOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelSalary;

@end

NS_ASSUME_NONNULL_END
