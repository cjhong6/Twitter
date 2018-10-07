//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chengjiu Hong on 10/6/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createDateLaabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet{
            profileImageView.af_setImage(withURL: (tweet.user?.profileURLPath)!)
            userNameLabel.text = "@\(tweet.user!.name)"
            tweetLabel.text = tweet.text
            screenNameLabel.text = tweet.user?.screenName
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount!)
            createDateLaabel.text = tweet.createdAtString
        }

    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        if(!(tweet.favorited!)){
            let image = UIImage(named: "favor-icon-red")
            heartBtn.setImage(image, for: UIControlState.normal)
            tweet.favorited = true
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCountLabel.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "favor-icon")
            heartBtn.setImage(image, for: UIControlState.normal)
            tweet.favorited = false
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unfavorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCountLabel.text = String(count)
                }
            }
        }
    }
    
    @IBAction func tapRetweet(_ sender: Any) {
        if(!(tweet.retweeted!)){
            let image = UIImage(named: "retweet-icon-green")
            retweetBtn.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully retweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCountLabel.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "retweet-icon")
            retweetBtn.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = false
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unretweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCountLabel.text = String(count)
                }
            }
        }
    }
    
    

}
