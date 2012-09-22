//
//  ResultViewController.m
//  SBMapWithRoute
//
//  Created by Emil Marashliev on 9/22/12.
//
//

#import "ResultViewController.h"
#import "GCSimpleSectionController.h"
#import "GCArraySectionController.h"
#import "GCCustomSectionController.h"
#import "GCEmptySectionController.h"

@interface ResultViewController ()

@property (nonatomic, retain) NSArray* retractableControllers;

@end

@implementation ResultViewController

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

    self.title = NSLocalizedString(@"Demo",);
    
    GCSimpleSectionController* simpleController = [[GCSimpleSectionController alloc] initWithViewController:self];
    
    self.retractableControllers = [NSArray arrayWithObjects:simpleController, nil];
    [simpleController release];
;
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.retractableControllers = nil;
    
    [_tebleView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTebleView:nil];
    [super viewDidUnload];
}
@end
