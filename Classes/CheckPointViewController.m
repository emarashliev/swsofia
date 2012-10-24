//
//  SBCheckPoints.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 28/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckPointViewController.h"


@interface CheckPointViewController(Private)
-(void)releaseAllViews;
-(void)customInitialization;
@end

@implementation CheckPointViewController
@synthesize mTable;
@synthesize mCheckPoints;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mCheckPoints = [[NSMutableArray alloc]init];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [mCheckPoints count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"%@",mCheckPoints[indexPath.row]];
	cell.textLabel.numberOfLines = 3;
	cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
	return cell;	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
}



- (void)dealloc {
    
	[mCheckPoints release];
    [super dealloc];
}


@end
