//
//  DetailcVCViewController.m
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import "DetailsVC.h"
#import "MapViewController.h"

@interface DetailsVC ()

@end

@implementation DetailsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor darkGrayColor];
    
    _imageContainer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detailRoute.png"]]];
    _imageContainer.center = CGPointMake(_imageContainer.center.x, _imageContainer.center.y - 50);
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_imageContainer];
    
    _scrollView.contentSize = CGSizeMake(_imageContainer.frame.size.width, _imageContainer.frame.size.height+40);
    
    
    UIImage *image = [UIImage imageNamed:@"ViewMap.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage: image  forState:UIControlStateNormal];
    //[button setBackgroundImage: [[UIImage imageNamed: @"right_clicked.png"] stretchableImageWithLeftCapWidth:7.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    button.frame= CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    
    [button addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height) ];
    
    [v addSubview:button];
    
    UIBarButtonItem *forward = [[UIBarButtonItem alloc] initWithCustomView:v];
    
    self.navigationItem.rightBarButtonItem= forward;
    
    [v release];
    [image release];
    
    [self addLabels];
     
}


- (void)goToMap {
    MapViewController *mapVC	= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
    [mapVC release];
}

- (void)addLabels {
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:10];
    UIColor *color = [UIColor clearColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(38, 245, 40, 20)];
    label1.text = [dateFormatter stringFromDate:[self getCurrentDatePlusMinutes:6]];
    label1.backgroundColor = color;
    label1.font = font;
    [_imageContainer addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(38, 677, 40, 20)];
    label2.text = [dateFormatter stringFromDate:[self getCurrentDatePlusMinutes:20]];
    label2.backgroundColor = color;
    label2.font = font;
    [_imageContainer addSubview:label2];
    

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(38, 835, 40, 20)];
    label3.text = [dateFormatter stringFromDate:[self getCurrentDatePlusMinutes:28]];
    label3.backgroundColor = color;
    label3.font = font;
    [_imageContainer addSubview:label3];

    


}

- (NSDate *)getCurrentDatePlusMinutes:(NSInteger)minutes {
    NSDate *laterDate = [[NSDate alloc] initWithTimeIntervalSinceNow:minutes*60];

    return [laterDate autorelease];
}

@end
