//
//  PublicProfileViewController.h
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/12/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublicProfileViewController : UIViewController

@property(nonatomic, weak) Employee *employeeDetail;

@end

NS_ASSUME_NONNULL_END
