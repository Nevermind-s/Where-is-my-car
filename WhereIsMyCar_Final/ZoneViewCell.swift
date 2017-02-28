//
//  ZoneViewCell.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 17/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

import UIKit

class ZoneViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle ( title:String ) {
        titleLabel.text = title
    }
    
}
