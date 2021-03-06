//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        getHomeline()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tweets.count
    }
    
    @IBAction func tapCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeViewController", sender: nil)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func getHomeline(){
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
        
    }

    func refreshControlAction(_ refreshControl: UIRefreshControl){
        getHomeline()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSegue"){
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let tweet = tweets[indexPath.row]
                let tweetDeatilViewController = segue.destination as! TweetDetailViewController
                tweetDeatilViewController.tweet = tweet
            }
        }

    }

}
