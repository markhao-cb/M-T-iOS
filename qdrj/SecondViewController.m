//
//  SecondViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "CategoryTableViewCell.h"
#import "CategoryDetailTableViewController.h"

@interface SecondViewController () {
    NSArray *_category;
    UIImage *_image;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _category = @[@"liangcai",@"tang",@"recai",@"ganguo",@"shaokao",@"zhushi"];
    UITableView *tableView = (id)[self.view viewWithTag:555];
    //tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_category count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    _image = [UIImage imageNamed:_category[indexPath.row]];
    // [_image drawInRect:CGRectMake(0, 0, screenWidth , _image.size.height * screenWidth/_image.size.width)];
    //cell.lblCategory.text = _category[indexPath.row];
    cell.ivCategory.image = _image;
//    cell.ivCategory.frame = CGRectOffset(cell.frame, 10, 10);
   // [cell.ivCategory setFrame:CGRectMake(0, 0, screenWidth, _image.size.height)];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //UIImageView *imageView = (id)[self.view viewWithTag:700];
    return 262*screenWidth/600 +10  ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableView *tableView = (id)[self.view viewWithTag:555];
    NSIndexPath * indexPath = [tableView indexPathForSelectedRow];
    CategoryDetailTableViewController *cdVC = segue.destinationViewController;
    cdVC.categoryName = _category[indexPath.row];
}




@end
