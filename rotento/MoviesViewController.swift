//
//  MoviesViewController.swift
//  rotento
//
//  Created by Vaibhav Krishna on 4/18/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var movies: [NSDictionary]?
    

    @IBOutlet weak var nErrView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nErrView.hidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        self.fetchMovies()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func onRefresh() {
            self.fetchMovies()
            self.refreshControl?.endRefreshing()
    }
    
    func fetchMovies(){
        let YourApiKey = "dagqdghwaq3e3mxyrp7kmmj5"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + YourApiKey
        
        let url = NSURL(string: RottenTomatoesURLString)
        let request = NSURLRequest(URL: url!)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil

            if let data = data {
                 let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as? NSDictionary
                if let dict = dictionary{
                    self.movies = dict["movies"] as? [NSDictionary]
                }

            }
            else{
                self.tableView.hidden = true
                self.nErrView.hidden = false
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
        })

    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("moviecell", forIndexPath: indexPath) as! MovieCell
        let movie = self.movies![indexPath.row]
        if movie.valueForKeyPath("ratings.critics_score") as! Int > 50{
            cell.backgroundColor = UIColor(red: 0.13, green: 0.99, blue: 0.28, alpha: 0.1)
        }
        else{
            cell.backgroundColor = UIColor(red: 0.91, green: 0.29, blue: 0.22, alpha: 0.1)
        }
        
        cell.titleLable.text = movie["title"] as? String
        cell.synLabel.text = movie["synopsis"] as? String
        
        let thumb = movie.valueForKeyPath("posters.thumbnail") as! String
        let url = NSURL(string: thumb)!
        
        cell.imageLabel.setImageWithURL(url)
        println(movie["title"])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.movies?.count{
            return count
        }
        else{
            return 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let index = tableView.indexPathForCell(cell)!
        
        let movieAtRow = movies![index.row]
        
        let movieDetailsViewContr = segue.destinationViewController as! MovieDetailViewController
        
        movieDetailsViewContr.movie = movieAtRow

        
    }


}
