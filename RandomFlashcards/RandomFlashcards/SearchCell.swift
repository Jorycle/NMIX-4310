//
//  SearchCell.swift
//  RandomFlashcards
//
//  Created by Jorycle on 5/1/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var ResultCount: UILabel!
    @IBOutlet weak var ResultName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
