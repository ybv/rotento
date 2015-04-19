//
//  MovieDetailViewController.swift
//  rotento
//
//  Created by Vaibhav Krishna on 4/18/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie!["title"] as? String
        synLabel.text = movie!["synopsis"] as? String
        
        
        var imageString = movie?.valueForKeyPath("posters.thumbnail") as! String
        let url = NSURL(string: imageString)!
        posterView.setImageWithURL(url)
        let scrView = self.view.subviews.last as! UIScrollView
        
        scrView.contentSize = CGSizeMake(320, 500);
        
        if movie!.valueForKeyPath("ratings.critics_score") as! Int > 50{
             scrView.backgroundColor = UIColor(red: 0.13, green: 0.99, blue: 0.28, alpha: 0.5)
        }
        else{
             scrView.backgroundColor = UIColor(red: 0.91, green: 0.29, blue: 0.22, alpha: 0.5)
        }

        let range = imageString.rangeOfString(".*cloudfront.net/",
            options: .RegularExpressionSearch)
        if let range = range {
            imageString = imageString.stringByReplacingCharactersInRange(range,
                withString: "https://content6.flixster.com/")
        }
        
        let highRes = NSURL(string: imageString)!
        posterView.setImageWithURL(highRes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
