//
//  DetailViewController.swift
//  Flix
//
//  Created by Kelvin Lui on 2/4/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var posterURL: URL!
    var overviewText: String!
    var titleText: String!
    var ratingText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        overviewTextLabel.text = overviewText
        posterImageView.af_setImage(withURL: posterURL)
        ratingLabel.text = ratingText
        titleLabel.text = titleText
        
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        overviewTextLabel.sizeToFit()
        overviewTextLabel.numberOfLines = 0
        
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
        
        
    }
 

}
