//
//  PromoDetailViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/12/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "PromoDetailViewController.h"
#import "AppDelegate.h"

@interface PromoDetailViewController () {
    NSMutableArray *_proDetailArray;
}

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblIssueDate;
@property (strong, nonatomic) IBOutlet UILabel *lblExpDate;

@end

@implementation PromoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.db queryDB:[NSString stringWithFormat:@"select title, detail, issue_date, exp_date, image from promotion where title = '%@'",_PromoTitle] numOfColumns:5];
    _proDetailArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];
    
    self.lblTitle.text = _PromoTitle;
    self.lblDetail.text = _proDetailArray[0][1];
    self.lblIssueDate.text = _proDetailArray[0][2];
    self.lblExpDate.text = _proDetailArray[0][3];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    UIImageView *ivbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    ivbg.image = [UIImage imageNamed:@"qdrjbg.jpg"];
    ivbg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:ivbg];
    [self.view sendSubviewToBack:ivbg];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
