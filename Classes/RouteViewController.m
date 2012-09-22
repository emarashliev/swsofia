//
//  SBMapWithRouteViewController.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RouteViewController.h"
#import "MapViewController.h"

@interface RouteViewController(Private)
-(void)releaseAllViews;
-(void)customInitialization;
@end

@implementation RouteViewController(Private)
-(void)releaseAllViews
{
	//Release All views that are retained by this class.. Both Views retained from nib and views added programatically
	//eg:
	//self.mMyTextField = nil
	self.sourceCity			= nil;
	self.destinationCity1	= nil;
	self.loadDirection		= nil;
}

-(void)customInitialization
{
	// do the initialization of class variables here..
}

@end

@implementation RouteViewController

@synthesize sourceCity		= mSourceCity;
@synthesize destinationCity1 = mDestinationCity;
@synthesize loadDirection	= mLoadDirection;
@synthesize DestinationCityArray;

//Invoked when the class is instantiated in XIB
-(id)initWithCoder:(NSCoder*)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if( self)
	{
		[self customInitialization];
	}
	return self;
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[self customInitialization];
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Home";
	
}

#pragma mark ButtonAction

-(IBAction)showGoogleMap:(id)sender
{
	[mSourceCity resignFirstResponder];
	[mDestinationCity resignFirstResponder];
	
	MapViewController *_Controller	= [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	
	_Controller.startPoint		= mSourceCity.text;
	self.DestinationCityArray = [[NSMutableArray alloc]init];
	if (mDestinationCity.text != NULL ) {
		[DestinationCityArray addObject:mDestinationCity.text];
		
	}
	
	_Controller.destination = DestinationCityArray;
    _Controller.travelMode	= UICGTravelModeDriving;

	[self.navigationController pushViewController:_Controller animated:YES];
	[_Controller release];
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	//self.destinationCity.text = nil;
//	self.destinationCity2.text = nil;
//	self.sourceCity.text = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[self releaseAllViews];
}

- (void)getCurrentLocation:(UIButton*)sender {
    NSLog(@"BTN PRESSED");
}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ( textField == mSourceCity) {
		[mSourceCity resignFirstResponder];
		[mDestinationCity becomeFirstResponder];
	}
	if ( textField == mDestinationCity) {
		[mDestinationCity resignFirstResponder];
	}
	return YES;
}

- (void)dealloc {
	[self releaseAllViews];
    [super dealloc];
}

@end