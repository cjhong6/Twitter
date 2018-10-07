//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chengjiu Hong on 10/1/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController:UIViewController,UITextViewDelegate{

    
    @IBOutlet weak var tweetMessage: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetMessage.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapPost(_ sender: Any) {
        if let text = tweetMessage.text{
            APIManager.shared.composeTweet(with: text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
                    print("Compose Tweet Success!")
                    
                }
                
            }
        }
        
        let TimelineViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimelineViewController") as! TimelineViewController
        self.navigationController?.pushViewController(TimelineViewController, animated: true)
    }
    
    //word count
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        let textcnt = (characterLimit - newText.count)
        characterCount.text = String(textcnt)
        return newText.count < characterLimit
    }
    
    func did(post: Tweet) {}
}

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}
