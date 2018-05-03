//
//  CardTableViewCell.swift
//  MidtermProject
//
//  Created by Jorycle on 3/9/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
