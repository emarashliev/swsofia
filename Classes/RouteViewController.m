//
//  SBMapWithRouteViewController.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RouteViewController.h"
#import "MapViewController.h"
#import "ChooseOptionVC.h"
#import "StorageObject.h"

#define k_CoordinatesDefault CLLocationCoordinate2DMake(42.686182, 23.318406);

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
    coordinatesFrom = k_CoordinatesDefault;
    coordinatesTo   = k_CoordinatesDefault;
}

@end

@implementation RouteViewController

@synthesize sourceCity		= txtFieldFrom;
@synthesize destinationCity1 = txtFieldTo;
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
        self.view.backgroundColor = [UIColor blackColor];
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];

    
	self.title = @"Home";
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark ButtonAction

-(IBAction)showGoogleMap:(id)sender
{
	[txtFieldFrom resignFirstResponder];
	[txtFieldTo resignFirstResponder];
	
    StorageObject *storageObject = [StorageObject sharedStorageObject];
    storageObject.startPoint = txtFieldFrom.text;
    storageObject.endPoint = txtFieldTo.text;
    
    ChooseOptionVC *optionsVC = [[ChooseOptionVC alloc] initWithNibName:@"ChooseOptionVC" bundle:nil];

	[self.navigationController pushViewController:optionsVC animated:YES];
	[optionsVC release];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[self releaseAllViews];
}

- (void)getCurrentLocation:(UIButton*)sender {
    NSLog(@"BTN PRESSED");
    
    //Use Current location by GPS
    geocoder = [[CLGeocoder alloc] init];
    lm = [[CLLocationManager alloc]init];
    lm.delegate = (id)self;
    [lm startUpdatingLocation];
    
    NSLog(@"geocoder = %@", geocoder);
    NSLog(@"latitude = %f ,longitude = %f", lm.location.coordinate.latitude, lm.location.coordinate.longitude);
    
    //Block address
    [geocoder reverseGeocodeLocation: lm.location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //Get address
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         NSLog(@"Placemark array: %@",placemark.addressDictionary );
         
         //String to address
         NSString *locatedaddress = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         //Print the location in the console
         NSLog(@"Currently address is: %@",locatedaddress);
         
         NSString *streetName = [placemark.addressDictionary objectForKey:@"Street"];
         
         if (sender == _btnGetLocationCurrentFrom) txtFieldFrom.text = streetName;
         else if (sender == _btnGetLocationCurrentTo) txtFieldTo.text = streetName;
         
     }];
}


#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ( textField == txtFieldFrom) {
		[txtFieldFrom resignFirstResponder];
		[txtFieldTo becomeFirstResponder];
	}
	if ( textField == txtFieldTo) {
		[txtFieldTo resignFirstResponder];
	}
	return YES;
}

-(IBAction)callPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:029999999"]];
}

- (void)dealloc {
	[self releaseAllViews];
    [super dealloc];
}


- (void)hideKeyboard {
    [txtFieldFrom resignFirstResponder];
    [txtFieldTo resignFirstResponder];
}


- (void)keyboardWillShow:(NSNotification *)notification {

    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [UIView animateWithDuration:animationDuration animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 130);
        _imgLogo.frame = CGRectMake(30, 105, 62, 70);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *) notification {
	
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
        _imgLogo.frame = CGRectMake(58, 86, 62, 70);
    }];
     
    
}



@end
