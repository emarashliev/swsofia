//
//  ChooseOptionVC.m
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import "ChooseOptionVC.h"
#import "MapViewController.h"

@interface ChooseOptionVC ()

@end

@implementation ChooseOptionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _locations = [[NSMutableDictionary alloc] init];
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)btnPressed:(UIButton*)sender {
    
    MapViewController *mapVC	= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];

    
    //SET destinations for the search on the map
    NSMutableArray *CityArray = [[NSMutableArray alloc] init];
    
    mapVC.startPoint = [_locations objectForKey:@"start"];
   
    NSString *endPoint = [_locations objectForKey:@"end"];
    if (endPoint != NULL ) {
        [CityArray addObject:endPoint];
    }
    
    mapVC.destination = CityArray;
	[self.navigationController pushViewController:mapVC animated:YES];
	[mapVC release];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
