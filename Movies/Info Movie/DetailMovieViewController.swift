//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 10/02/21.
//

import UIKit
import Alamofire

class DetailMovieViewController: BaseViewController {

    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var overviewText: UITextView!
    
    var detailModel : DetailModel!
    var movie_id : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequest(url: "/movie/\(movie_id ?? "")?api_key=\(MoviesUrl.API_KEY)", tag: "movie")
    }
    override func onSuccess(data: Data, tag: String) {
        do{
            let decoder = JSONDecoder()
            self.detailModel = try decoder.decode(DetailModel.self, from:data)
            self.releasedateLabel.text = detailModel.releaseDate
            self.revenueLabel.text = String(detailModel.revenue)
            self.statusLabel.text = detailModel.status
           // self.overviewText.text = detailModel.overview
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func backButton(_ sender: Any) { self.dismiss(animated: true, completion: nil)
    }
}
