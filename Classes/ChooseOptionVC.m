//
//  ChooseOptionVC.m
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import "ChooseOptionVC.h"
#import "MapViewController.h"
#import "DetailsVC.h"

@interface ChooseOptionVC ()

@end

@implementation ChooseOptionVC

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
    self.view.backgroundColor = [UIColor blackColor];
       
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)btnPressed:(UIButton*)sender {
    
    DetailsVC *detailsVC	= [[DetailsVC alloc] initWithNibName:@"DetailsVC" bundle:nil];
	[self.navigationController pushViewController:detailsVC animated:YES];
	[detailsVC release];
    
    /*
    MapViewController *mapVC	= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	[self.navigationController pushViewController:mapVC animated:YES];
	[mapVC release];
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
