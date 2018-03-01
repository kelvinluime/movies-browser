//
//  DetailViewController.swift
//  Flix
//
//  Created by Kelvin Lui on 2/4/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    enum MovieKeys {
        static let title = "title"
        static let releaseDate = "release"
        static let voteAverage = "vote_average"
        static let posterPath = "poster_path"
        static let voteCount = "vote_count"
        static let backDropPath = "backdrop_path"
        static let id = "id"
    }
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    var movie: Movie!
    var posterURL: URL!
    var backdropURL: URL!
    var overviewText: String!
    var titleText: String!
    var releaseDateText: String!
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
//        overviewText = movie!["overview"] as! String
//        let posterPathString = movie!["poster_path"] as! String
//        let backdropPathString = movie![MovieKeys.backDropPath] as! String
//        posterURL = URL(string: baseURLString + posterPathString)!
//        backdropURL = URL(string: baseURLString + backdropPathString)!
//        releaseDateText = movie!["release_date"] as! String
//        titleText = movie![MovieKeys.title] as! String
        
        overviewTextLabel.text = movie.overview
        if let url = movie.posterUrl {
            posterImageView.af_setImage(withURL: url)
        } else {
            posterImageView.image = #imageLiteral(resourceName: "now_playing_tabbar_item")
        }
        releaseDataLabel.text = movie.releaseDate
        titleLabel.text = movie.title
        backdropImageView.af_setImage(withURL: movie.backDropUrl!)
        
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        overviewTextLabel.sizeToFit()
        overviewTextLabel.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapPoster(_ sender: UITapGestureRecognizer) {
        print("Hello")
        performSegue(withIdentifier: "TrailerViewSegue", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movieId = movie.id
    }
}
