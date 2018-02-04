//
//  MovitTimeTableViewCell.swift
//  Flix
//
//  Created by Kelvin Lui on 2/4/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MovieTimeCell: UITableViewCell {

    @IBOutlet weak var movieTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sizeToFit()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
