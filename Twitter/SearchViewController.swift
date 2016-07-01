//
//  SearchViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/30/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [User] = []
    
    var screenName: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Search"
        
        let customTabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search-7"), selectedImage: UIImage(named: "search-7"))
        self.tabBarItem = customTabBarItem
        


        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
        
        let row = indexPath.row
        
        let user = users[row]
        
       cell.nameLabel.text = user.name
        
       cell.profPic.setImageWithURL(user.profileUrl!)
        
        cell.profPic.layer.cornerRadius = 15
        cell.profPic.layer.masksToBounds = true
        

        
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        TwitterClient.sharedInstance.search(searchText, success: { (users: [User]) -> () in
            
            self.users = users
            
            self.tableView.reloadData()
            
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("hi")
        let indexPathDetail = tableView.indexPathForCell(sender as! SearchCell)
        
        let profViewController = segue.destinationViewController as! UserProfileViewController
        
        var row: Int!
        
        row = indexPathDetail?.row
        
        let user = users[row!]

        
        screenName = user.screenName!
        
        profViewController.screenName = self.screenName

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
