//
//  PromotionViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/11/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "PromotionViewController.h"
#import "AppDelegate.h"
#import "PromoTableViewCell.h"
#import "PromoDetailViewController.h"

@interface PromotionViewController () {
    NSMutableArray *_promoArray;
}


@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.db queryDB:[NSString stringWithFormat:@"select title, detail, exp_date, image from promotion where exp_date > datetime(CURRENT_TIMESTAMP,'localtime') order by issue_date"] numOfColumns:4];
   _promoArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];
    UITableView *tableView = (id)[self.view viewWithTag:688];
    [tableView reloadData];
    // Do any additional setup after loading the view.
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_promoArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PromoTableViewCell *cell = (PromoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PromoTableViewCell"];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //cell.ivProImage.image = [UIImage imageNamed:@"promo.png"];
    cell.lblProTitle.text = _promoArray[indexPath.row][0];
   
    if ([_seg selectedSegmentIndex] == 0) {
        cell.lblProExpDate.text = [NSString stringWithFormat:@"EXP: %@",_promoArray[indexPath.row][2]];
    }
    else {
        cell.lblProExpDate.text = @"Expired";
    }
    
        return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    PromoTableViewCell *cell = (PromoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PromoTableViewCell"];
//    return cell.lblProTitle.frame.size.height + cell.lblProExpDate.frame.size.height  ;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex]==0) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.db queryDB:[NSString stringWithFormat:@"select title, detail, exp_date, image from promotion where exp_date > datetime(CURRENT_TIMESTAMP,'localtime') order by issue_date"] numOfColumns:4];
        _promoArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];
    }
    else {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.db queryDB:[NSString stringWithFormat:@"select title, detail, exp_date, image from promotion where exp_date < datetime(CURRENT_TIMESTAMP,'localtime') order by issue_date"] numOfColumns:4];
        _promoArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];

    }
    UITableView *tableView = (id)[self.view viewWithTag:688];
    [tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableView *tableView = (id)[self.view viewWithTag:688];
    NSIndexPath * indexPath = [tableView indexPathForSelectedRow];
    PromoDetailViewController *pdVC = segue.destinationViewController;
    pdVC.PromoTitle = _promoArray[indexPath.row][0];
}

@end
