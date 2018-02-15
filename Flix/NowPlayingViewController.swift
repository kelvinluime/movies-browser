//
//  NowPlayingViewController.swift
//  flix_demo_03
//
//  Created by Kelvin Lui on 1/30/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Now Playing"
        
        // Setup activity indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        
        self.view.addSubview(activityIndicator)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        //tableView.rowHeight = 148.0
        
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    func fetchMovies() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        for case let cell as MovieCell in tableView.visibleCells {
            cell.posterImageView.image = UIImage(named: "now_playing_tabbar_item")
        }
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=691c5b632bbc96d6fa9724c296db22bf&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let _ = error {
                let alert = UIAlertController(title: "Network Error", message: "Unable to load data. Please connect to the Internet and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in self.fetchMovies() }))
                self.present(alert, animated: true)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        // Intentionally extend activity indicator animation period to illustrate it on the screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.activityIndicator.stopAnimating()
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
}




































