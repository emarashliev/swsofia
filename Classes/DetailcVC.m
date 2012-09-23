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
    _scrollView.backgroundColor = [UIColor blackColor];
    
    _imageContainer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"detailRoute.png"]]];
    _imageContainer.center = CGPointMake(_imageContainer.center.x, _imageContainer.center.y - 40);
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_imageContainer];
    
    _scrollView.contentSize = CGSizeMake(_imageContainer.frame.size.width, _imageContainer.frame.size.height+60);
    
    
    
    
    
  
    
    // Add Go button. Bar Buttons
    UIBarButtonItem *mGoBtn = [[UIBarButtonItem alloc] initWithTitle:nil
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(goToMap)];
    mGoBtn.image = [UIImage imageNamed:@"ViewMap.png"];
    self.navigationItem.rightBarButtonItem = mGoBtn;
    [mGoBtn release];
}


- (void)goToMap {
    MapViewController *mapVC	= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
    [mapVC release];
}

@end
