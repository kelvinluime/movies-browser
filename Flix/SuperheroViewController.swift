//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Kelvin Lui on 2/10/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    func fetchMovies() {
        //        activityIndicator.startAnimating()
        //        activityIndicator.isHidden = false
        //        for case let cell as! PosterCell in collectionView.visibleCells {
        //            cell.posterImageView.image = UIImage(named: "now_playing_tabbar_item")
        //        }
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=691c5b632bbc96d6fa9724c296db22bf&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let _ = error {
                //                let alert = UIAlertController(title: "Network Error", message: "Unable to load data. Please connect to the Internet and try again.", preferredStyle: .alert)
                //                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in self.fetchMovies() }))
                //                self.present(alert, animated: true)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                
                self.collectionView.reloadData()
                //                self.refreshControl.endRefreshing()
            }
        }
        
        // Intentionally extend activity indicator animation period to illustrate it on the screen
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        //            self.activityIndicator.stopAnimating()
        //        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        
        self.title = "Superhero"
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let widthPerCell = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: widthPerCell, height: widthPerCell * 3 / 2)
        
        fetchMovies()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPathList = collectionView.indexPathsForSelectedItems {
            let movie = movies[indexPathList[0].item]
            let detailViewContoller = segue.destination as! DetailViewController
            detailViewContoller.movie = movie
        }
        
    }
}
