//
//  GenreTableViewCell.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 09/02/21.
//

import UIKit
import MaterialComponents.MaterialCards

class GenreTableViewCell: UITableViewCell {


    @IBOutlet weak var detailGenre: MDCCard!
    @IBOutlet weak var genreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
