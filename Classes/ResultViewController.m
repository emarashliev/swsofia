//
//  ResultViewController.m
//  SBMapWithRoute
//
//  Created by Emil Marashliev on 9/22/12.
//
//

#import "ResultViewController.h"
#import "GCSimpleSectionController.h"

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
    
    GCSimpleSectionController* simpleController = [[GCSimpleSectionController alloc] initWithViewController:self];
    
    self.retractableControllers = @[simpleController];
    [simpleController release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = (self.retractableControllers)[section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = (self.retractableControllers)[indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = (self.retractableControllers)[indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

- (void)dealloc
{
    self.retractableControllers = nil;
    
    [_tebleView release];
    [super dealloc];
}

@end
