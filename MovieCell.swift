//
//  MovieCell.swift
//  rotento
//
//  Created by Vaibhav Krishna on 4/18/15.
//  Copyright (c) 2015 Vaibhav Krishna. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

 
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var synLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
