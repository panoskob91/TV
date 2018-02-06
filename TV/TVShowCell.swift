//
//  TVShowCell.swift
//  TV
//
//  Created by Paagiotis  Kompotis  on 05/02/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import UIKit

class TVShowCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
