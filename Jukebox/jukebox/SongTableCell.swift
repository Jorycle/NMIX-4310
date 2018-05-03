//
//  SongTableCell.swift
//  Jukebox
//
//  Created by Joseph Clements on 4/5/18.
//  Copyright © 2018 Joseph Clements. All rights reserved.
//

import UIKit

class SongTableCell: UITableViewCell {

    @IBOutlet weak var ArtistAlbum: UILabel!
    @IBOutlet weak var SongName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
