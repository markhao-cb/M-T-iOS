//
//  CategoryDetailTableViewCell.h
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *lblName;
@property(weak, nonatomic) IBOutlet UILabel *lblEname;
@property(weak, nonatomic) IBOutlet UILabel *lblPrice;
@property(weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@property(weak, nonatomic) IBOutlet UIImageView *ivSpecial;
@end
