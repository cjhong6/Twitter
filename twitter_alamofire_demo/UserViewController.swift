//
//  UserViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chengjiu Hong on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getCurrentAccount { (user: User?, error: Error?) in
            if let  error = error {
                print("Error: \(error.localizedDescription)")
            } else if let user = user {
               self.profileImageView.af_setImage(withURL: user.profileURLPath)
                self.tweetCountLabel.text = String(user.tweet_count)
                self.followerCountLabel.text = String(user.followers_count)
                self.followingCountLabel.text = String(user.following_count)
                self.nameLabel.text = user.name
            }
        }
    }

}
