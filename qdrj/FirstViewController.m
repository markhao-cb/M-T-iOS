//
//  FirstViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () {
    NSString *_intro;
    UIPageControl *_pageControl;
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) IBOutlet UILabel *lblIntro;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _intro = @"\n      青岛人家于2009年7月正式落户于美国纽约皇后区法拉盛。自开业以来得到中外宾客的一致好评。\n\n      2009年9月以及11月，分别两次荣登纽约时报。世界餐饮的权威刊物<<米其林餐饮指南>> 于2010年、2011年两次报道过，并被米奇林评为二星餐饮。2010年9月3日，美国广播电视ABC7曾报道过青岛人家，盛赞青岛人家菜品“百菜百品”、“真正中国菜”。2010年资深电台NYTV8面向24个国家的华语报道中国的八大菜系之一鲁菜之首青岛菜，并得到美国各大网站及刊物的赞誉。\n\n      而今青岛人家落户于洛杉矶。\n\n      鲁菜是中国八大菜系之一。\n\n    鲁菜分为两答派系：一是鲁西南派系，口味偏咸偏重；二是胶东半岛沿海派系，口味适中，食材以海鲜为主，素来享有＂一菜一格，百菜百味＂之美誉。\n\n    青岛位于胶东半岛的南端，有东方瑞士之美称。此地海产丰富，另有崂山的山珍及绿茶。\n\n      青岛人家在烹饪方法上擅长炒、滑、爆、剪、炸、塌。其自行研制的酱卤制品以及水饺等面食更是有其独到之处。从高级的满汉全席乃至民间的小吃，家常菜更为大众叫绝。在品味上，特别讲究＂色、想、味、意、形＂，兼有南北之长。\n\n      青岛人家以其别具一格的烹饪方法和浓郁的地方风味享誉中外。\n\n     Tsingtao M&T Seafood Restaurant was opened first in Flushing, Queens of New York in July 2009, and it has won great acclaim from all guests since its opening. \n\n      Tsingtao M&T was favorably reported twice by New York Times, in September and November, 2009, respectively. Michelin Red Guide,the world-renewed authoritative restaurant reference guide, book in the world, honorably mentioned Tsingtao M&T twice in 2010 and 2011, and awarded it as two-star restaurant in 2010. Tsingtao M&T was also reported by the American Broadcasting Company (ABC) on September 3, 2010, who praised M&T for its rich set of delicious dishes as truly authentic Chinese Food. In 2010, the well-known NYTV8 reported to the Chinese channels of 24 different countries the Tsingtao style as the top of the Shandong Cuisine, one of the 8 major cuisines in China, leading to high opinion of major US web sites and publishers. \n\n    Now, Tsingtao M&T is coming to Los Angeles. \n\n    Shandong Cuisine is one of the 8 major cuisines of China and there are two different styles of Shandong Cuisine: Southwest, known for its saltier and heavier taste, and Peninsula Seaside, known for its mild taste and use of seafood as its main ingredient. The Seaside style has the long standing reputation as 'one taste for one dish; one hundred tastes for one hundred dishes'. \n\n    Tsingtao or Qingdao is located in the southern tip of Shandong Peninsula,widely known as The Oriental Switzerland. Tsingtao is rich in its seafood and famous for all sorts of delicacies and Green Tea of Laoshan. Tsingtao M&T is expert at Stir-fry, Stewed, Quick-fry, Pan-fry, Fried, and Omelet. Their marinated food and food made of flour such asduare home-made with unique style.M&T can server you a wide variety of food, from the royal feast of complete manchu­ han courses to popular snacks enjoyed by ordinary people. Tsingtao M&T devotes great details to to the color, smell, taste, intent, and look while cooking, integrates the strengths of both southern and northern Chinese food, and is famous for their unique cooking methods and rich local flavor.\n\n";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    // Do any additional setup after loading the view, typically from a nib.
    _imageArray = [[NSArray alloc] initWithObjects:@"image1",@"image2",@"image3",@"image4", nil];
    UIScrollView *scrollView = (id)[self.view viewWithTag:111];
    UIScrollView *mainScrollView = (id)[self.view viewWithTag:398];
    for (int i = 0; i < [_imageArray count]; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:i]];
        
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [_imageArray count], scrollView.frame.size.height);
    //CGPoint bottomOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - scrollView.bounds.size.height);
    self.pageControl.frame = CGRectMake(self.pageControl.frame.origin.x, scrollView.frame.size.height-40, self.pageControl.frame.size.width, self.pageControl.frame.size.height);
    [self.view bringSubviewToFront:self.pageControl];
    
    
    
    UILabel *lblIntro = (id)[self.view viewWithTag:22];
        //lblIntro.font = [UIFont systemFontOfSize:17.0f];
    lblIntro.textAlignment = NSTextAlignmentLeft;
    CGSize labelSize = [_intro sizeWithFont:lblIntro.font constrainedToSize:CGSizeMake(screenWidth-40*screenWidth/375, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [lblIntro setFrame:CGRectMake(20*screenWidth/375, scrollView.bounds.size.height+20*screenHeight/667, screenWidth-40*screenWidth/375, labelSize.height)];
    lblIntro.text = _intro;
    mainScrollView.contentSize =  CGSizeMake(screenWidth, scrollView.bounds.size.height+lblIntro.bounds.size.height);
    mainScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu.png"]]];
    UIImageView *ivBG1 = (id)[self.view viewWithTag:33];
    [ivBG1 setFrame:CGRectMake(0, scrollView.bounds.size.height+20, screenWidth, screenWidth*339/1024)];
    
    UIImageView *ivBG2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, mainScrollView.contentSize.height-124*screenHeight/667, screenWidth, screenWidth*339/1024)];
    ivBG2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    ivBG2.image = [UIImage imageNamed:@"dishes_meitu_1.jpg"];
    [mainScrollView addSubview:ivBG2];
    [mainScrollView sendSubviewToBack:ivBG2];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
