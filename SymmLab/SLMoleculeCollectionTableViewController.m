//
//  SLMoleculeCollectionTableViewController.m
//  SymmLab
//
//  Created by Yi Qiao on 10/19/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLMoleculeCollectionTableViewController.h"
#import "SLMoleculeViewController.h"
#import "SLViewController.h"

@interface SLMoleculeCollectionTableViewController () {
    NSArray * moleculeFiles;
    NSString * bundlePath;
    NSString * userDocPath;

}

@property (weak, nonatomic) SLViewController *rootViewController;

- (NSArray *)retrieveListOfMolecules;

@end

@implementation SLMoleculeCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor cyanColor];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:166.0f/255.0f green:189.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [self.refreshControl addTarget:self
                        action:@selector(refreshFileList)
                  forControlEvents:UIControlEventValueChanged];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    userDocPath = [paths objectAtIndex:0];
    bundlePath = [[NSBundle mainBundle] resourcePath];
    
    moleculeFiles = [self retrieveListOfMolecules];
    
    // find out the moleculeViewController
    UISplitViewController *rootSplitVC = (UISplitViewController *)self.parentViewController.parentViewController;
    _rootViewController = (SLViewController *) [(UINavigationController *)rootSplitVC.viewControllers[1] viewControllers][0];
    
    if (moleculeFiles.count > 0) {
        _rootViewController.activeFile = [moleculeFiles objectAtIndex:0];
        NSLog(@"setting active file to %@", _rootViewController.activeFile);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshFileList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)retrieveListOfMolecules {
    NSMutableArray *retval = [NSMutableArray array];

    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:userDocPath error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
    }
    else {
        for (NSString *file in files) {
            if ([file.pathExtension compare:@"xyz" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                NSString *fullPath = [userDocPath stringByAppendingPathComponent:file];
                [retval addObject:fullPath];
            }
        }
    }

    files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
    }
    else {
        for (NSString *file in files) {
            if ([file.pathExtension compare:@"xyz" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                NSString *fullPath = [bundlePath stringByAppendingPathComponent:file];
                [retval addObject:fullPath];
            }
        }
    }
    
    return [NSArray arrayWithArray:retval];
}

- (void)refreshFileList {
    moleculeFiles = [self retrieveListOfMolecules];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return moleculeFiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[moleculeFiles objectAtIndex:indexPath.row] lastPathComponent];
    cell.detailTextLabel.text = [(NSString *)[moleculeFiles objectAtIndex:indexPath.row] hasPrefix:bundlePath] ? @"preinstalled" : @"user provided";
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Pull down to refresh";
    }
    return @"undefined section";
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Requesting molecule %@", [moleculeFiles objectAtIndex:indexPath.row]);
    _rootViewController.activeFile = [moleculeFiles objectAtIndex:indexPath.row];
    [_rootViewController.MoleculeVC loadMoleculeWithFilename:[moleculeFiles objectAtIndex:indexPath.row]];

}

@end
