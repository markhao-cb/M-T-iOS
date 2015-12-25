//
//  CategoryDetailTableViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "CategoryDetailTableViewController.h"
#import "AppDelegate.h"
#import "CategoryDetailTableViewCell.h"
#import "DishViewController.h"

@interface CategoryDetailTableViewController () {
    NSMutableArray *_dishesArray;
    CGRect frame_first;
    UIImageView *fullImageView;
}

@end

@implementation CategoryDetailTableViewController

-(void)initData {
    if ([_categoryName isEqualToString:@"liangcai"]) [self setTitle:@"凉菜 Cold Dishes"];
    else if ([_categoryName isEqualToString:@"recai"]) [self setTitle:@"热菜 Hot Dishes"];
    else if ([_categoryName isEqualToString:@"tang"]) [self setTitle:@"汤 Soups"];
    else if ([_categoryName isEqualToString:@"zhushi"]) [self setTitle:@"主食 Staple food"];
    else if ([_categoryName isEqualToString:@"ganguo"]) [self setTitle:@"干锅 Griddle Cooked Dishes"];
    else if ([_categoryName isEqualToString:@"shaokao"]) [self setTitle:@"烧烤 BBQ"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.db queryDB:[NSString stringWithFormat:@"select name, ename, price, info from %@",_categoryName] numOfColumns:4];
    _dishesArray = [NSMutableArray arrayWithArray:appDelegate.db.rs];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dishesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailTableViewCell *cell = (CategoryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryDetailTableViewCell"];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_dishesArray[indexPath.row][0]]];
    //[image drawInRect:CGRectMake(0, 0, screenWidth/4 , image.size.height * screenWidth/4/image.size.width)];

    cell.lblName.text = _dishesArray[indexPath.row][0];
    cell.lblEname.text=_dishesArray[indexPath.row][1];
    cell.lblPrice.text=[NSString stringWithFormat:@"$%@",_dishesArray[indexPath.row][2]];
    cell.ivPhoto.image = image;
    cell.ivPhoto.userInteractionEnabled = YES;
    [cell.ivPhoto addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)]];
    //cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccessoryType:UITableViewCellAccessoryNone];
//    CGRect spFrame = CGRectMake(screenWidth-80*screenWidth/375, 0, 60, 45);
//    cell.ivSpecial.frame = spFrame;

    if (image == nil) {
        cell.ivPhoto.image = [UIImage imageNamed:@"empty.png"];
        cell.ivPhoto.userInteractionEnabled = NO;
    }
    //cell.ivSpecial.image = [UIImage imageNamed:@"special2.png"];
        //cell.ivSpecial.frame = CGRectMake(screenWidth-40, 0, 60, 45);
    
//    UIImageView *ivSpecial = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-80, 0, 60, 50)];
//    ivSpecial.tag = 999;
    if (![_dishesArray[indexPath.row][3] isEqualToString:@""]) {
        
        //[cell addSubview:ivSpecial];
        cell.userInteractionEnabled = YES;
        cell.ivSpecial.hidden = NO;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    else {
//        for (UIView *v in cell.subviews) {
//            if ([v isKindOfClass:[UIImageView class]] && v.tag == 999)
//                [v removeFromSuperview];
//        }
        
        cell.ivSpecial.hidden = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}


-(void)actionTap:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *) [self.tableView cellForRowAtIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:666];
    frame_first = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y +imageView.frame.origin.y - self.tableView.contentOffset.y , imageView.frame.size.width, imageView.frame.size.height);
    
    fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
//    fullImageView.autoresizingMask=(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth);
    fullImageView.backgroundColor = [UIColor blackColor];
    fullImageView.userInteractionEnabled = YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
    
    if (![fullImageView superview]) {
        
        fullImageView.image=imageView.image;
        
        [self.view.window addSubview:fullImageView];
        fullImageView.frame=frame_first;
        [UIView animateWithDuration:0.2 animations:^{
            
            fullImageView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [UIApplication sharedApplication].statusBarHidden=YES;
            
        }];
    }

}

-(void)actionTap2:(UITapGestureRecognizer *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        fullImageView.frame=frame_first;
        
    } completion:^(BOOL finished) {
        
        [fullImageView removeFromSuperview];
        
    }];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dishesArray[indexPath.row][3] isEqualToString:@""]) {
        return nil;
    }
    else return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_dishesArray[indexPath.row][3] isEqualToString:@""]) {
        return;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    UITableView *tableView = (id)[self.view viewWithTag:530];
    NSIndexPath * indexPath = [tableView indexPathForSelectedRow];
    if (![_dishesArray[indexPath.row][3] isEqualToString:@""]) {
        DishViewController *dVC = segue.destinationViewController;
        dVC.dishName = _dishesArray[indexPath.row][0];
        dVC.categoryName=_categoryName;
    }
    else return;
}


@end
