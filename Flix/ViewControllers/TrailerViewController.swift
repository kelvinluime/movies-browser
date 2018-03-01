//
//  TrailerViewController.swift
//  Flix
//
//  Created by Kelvin Lui on 2/10/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    
    @IBOutlet var trailerView: WKWebView!
    
    var videoUrl: URL!
    var movieId: Int!
    var videos: [[String: Any]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId!)/videos?api_key=691c5b632bbc96d6fa9724c296db22bf&language=en-US")!
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
                self.videos = dataDictionary["results"] as! [[String: Any]]
                for video in self.videos {
                    if video["type"] as! String == "Trailer" {
                        let myUrl = URL(string: "https://www.youtube.com/watch?v=" + (video["key"] as! String))
                        let myRequest = URLRequest(url: myUrl!)
                        self.trailerView.load(myRequest)
                        break
                    }
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
