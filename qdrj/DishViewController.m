//
//  DishViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/9/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "DishViewController.h"
#import "AppDelegate.h"

@interface DishViewController () {
    NSMutableArray *_dishArray;
}

@property (strong, nonatomic) IBOutlet UIImageView *ivDish;

@end

@implementation DishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:_dishName];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu.png"]]];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.db queryDB:[NSString stringWithFormat:@"select name, ename, price, info from %@ where name = '%@'",_categoryName,_dishName] numOfColumns:4];
    _dishArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//    [self.view addSubview:scrollView];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_dishArray[0][0]]];
    self.ivDish.image = image;
    self.ivDish.frame = CGRectMake(self.ivDish.frame.origin.x, self.ivDish.frame.origin.y+40*screenHeight/667, screenWidth, screenHeight/2);
    self.ivDish.contentMode = UIViewContentModeScaleAspectFit;
    //self.ivDish.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(20*screenWidth/375, self.ivDish.frame.size.height, screenWidth-40*screenHeight/667, screenHeight/2)];
    lblInfo.text = _dishArray[0][3];
    lblInfo.numberOfLines = 0;
    lblInfo.font = [UIFont systemFontOfSize:15];
    lblInfo.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lblInfo];
    
    UIImageView *ivbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.ivDish.frame.size.height, screenWidth, screenHeight-self.ivDish.frame.size.height)];
    ivbg.image = [UIImage imageNamed:@"qdrjbg.jpg"];
    ivbg.contentMode = UIViewContentModeScaleAspectFit;
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
