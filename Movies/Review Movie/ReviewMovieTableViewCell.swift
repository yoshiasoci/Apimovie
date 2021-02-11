//
//  ReviewMovieTableViewCell.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 10/02/21.
//

import UIKit
import MaterialComponents.MaterialCards

class ReviewMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
