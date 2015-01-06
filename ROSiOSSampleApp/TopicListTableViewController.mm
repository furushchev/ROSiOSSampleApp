//
//  TopicListTableViewController.m
//  ROSiOSSampleApp
//
//  Created by FurutaYuki on 12/27/14.
//  Copyright (c) 2014 JSK Lab. All rights reserved.
//

#import "TopicListTableViewController.h"
#import "TopicListTableViewCell.h"
#import <ros/master.h>

#define kTopicListTableViewCellIdentifier @"topicListTableViewCellIdentifier"

@interface TopicListTableViewController ()

@property (nonatomic, strong) NSMutableArray *topicNames;
@property (nonatomic, strong) NSMutableArray *dataTypes;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TopicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topicNames = [NSMutableArray array];
    self.dataTypes = [NSMutableArray array];
    [self getTopics];
}

- (void)getTopics
{
    ros::master::V_TopicInfo topicsInfo;
    ros::master::getTopics(topicsInfo);
    
    for (NSInteger i = 0; i < topicsInfo.size(); ++i) {
        [self.topicNames addObject:[NSString stringWithUTF8String:topicsInfo[i].name.c_str()]];
        [self.dataTypes addObject:[NSString stringWithUTF8String:topicsInfo[i].datatype.c_str()]];
    }
    
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.topicNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"tableView: %@", [tableView description]);
    
    TopicListTableViewCell *cell = (TopicListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kTopicListTableViewCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[TopicListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTopicListTableViewCellIdentifier];
    }
    
    cell.topicName.text = self.topicNames[[indexPath row]];
    cell.dataType.text = self.dataTypes[[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

@end
