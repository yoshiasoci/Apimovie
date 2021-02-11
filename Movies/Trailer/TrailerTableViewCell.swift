//
//  TrailerTableViewCell.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 11/02/21.
//

import UIKit
import YoutubePlayer_in_WKWebView

class TrailerTableViewCell: UITableViewCell {

    @IBOutlet weak var trailerMovie: WKYTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
