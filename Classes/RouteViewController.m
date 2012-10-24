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
#import "Consts.h"

//NDK location
#define k_CoordinatesDefault CLLocationCoordinate2DMake(42.686182, 23.318406);

@implementation RouteViewController

@synthesize sourceCity          = txtFieldFrom;
@synthesize destinationCity1    = txtFieldTo;
@synthesize loadDirection       = mLoadDirection;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    [nc addObserver:self selector:@selector(updateCurrentLocation) name:kNotificationGeocoderChanged object:nil];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];

    //Start Location services
    storageObject = [StorageObject sharedStorageObject];
    
    
    NSLog(@"New location: %f, %f",
          storageObject.lastLocation.coordinate.latitude,
          storageObject.lastLocation.coordinate.longitude);
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [_activityIndicator startAnimating];
}

- (void)viewDidAppear:(BOOL)animated   {
    [self askForGeocoderUpdate];
}

- (IBAction)askForGeocoderUpdate {
    [storageObject updateGoecoderFromCurrentLocation];
}

- (void)updateCurrentLocation {
    txtFieldFrom.text = storageObject.streetName;
    [_activityIndicator stopAnimating];
}

#pragma mark ButtonAction
-(IBAction)showGoogleMap:(id)sender
{
	[txtFieldFrom resignFirstResponder];
	[txtFieldTo resignFirstResponder];
	
    storageObject.startPoint = txtFieldFrom.text;
    storageObject.endPoint = txtFieldTo.text;
    
    ChooseOptionVC *optionsVC = [[ChooseOptionVC alloc] initWithNibName:@"ChooseOptionVC" bundle:nil];
	[self.navigationController pushViewController:optionsVC animated:YES];
	[optionsVC release];
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

/*
-(IBAction)callPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:029999999"]];
}
 */

- (void)dealloc {
    [super dealloc];
}


- (void)hideKeyboard {
    [txtFieldFrom resignFirstResponder];
    [txtFieldTo resignFirstResponder];
}


- (void)keyboardWillShow:(NSNotification *)notification {

    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    //Move the logo image
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 130);
        _imgLogo.frame = CGRectMake(30, 105, _imgLogo.frame.size.width, _imgLogo.frame.size.height);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *) notification {
	
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //Move the logo image
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
        _imgLogo.frame = CGRectMake(58, 86, _imgLogo.frame.size.width, _imgLogo.frame.size.height);
    }];
     
    
}



@end
