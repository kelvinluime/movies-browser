//
//  MovieCell.swift
//  Flix
//
//  Created by Kelvin Lui on 2/2/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.white.cgColor
        
        self.overviewLabel.sizeToFit()
        self.overviewLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if(selected) {
            let customView = UIView()
            customView.backgroundColor = UIColor.black
            self.selectedBackgroundView = customView    // Customize cell's background when it is selected
            self.titleLabel.textColor = UIColor.white
            self.overviewLabel.textColor = UIColor.white
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let customView = UIView()
                customView.backgroundColor = UIColor.white
                self.selectedBackgroundView = customView
                self.titleLabel.textColor = UIColor.black
                self.overviewLabel.textColor = UIColor.black
            }
        } else {
            self.titleLabel.textColor = UIColor.black
            self.overviewLabel.textColor = UIColor.black
        }
    }
}
