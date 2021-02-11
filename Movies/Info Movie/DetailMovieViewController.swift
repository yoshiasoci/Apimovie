//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 10/02/21.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialCards

class DetailMovieViewController: BaseViewController {

    @IBOutlet weak var releasedateLabel: UILabel!
    //@IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var contentView: MDCCard!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var trailerButton: UIButton!
    
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
            self.statusLabel.text = detailModel.status

           // self.revenueLabel.text = String(detailModel.revenue)
            self.releasedateLabel.text = detailModel.releaseDate
            self.overviewText.text = detailModel.overview
            
           }catch{
               print(error.localizedDescription)
           }
         
    }
    override func onFailed(tag: String) {
        showToast(message: "Data Not Found, Try Again Later!", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func backButton(_ sender: Any) { self.dismiss(animated: true, completion: nil)
    }
    @IBAction func reviewButton(_ sender: Any) {
        
        let changePass = ReviewMovieViewController()
            changePass.movie_id = movie_id
            changePass.modalPresentationStyle = .fullScreen
            self.present(changePass, animated: true, completion: nil)
        
    }
    
    @IBAction func trailerButton(_ sender: Any) {
        let changePass = TrailerViewController()
            changePass.movie_id = movie_id
            changePass.modalPresentationStyle = .fullScreen
            self.present(changePass, animated: true, completion: nil)
        
    }
    
//    let listDetail = DetailTapGesture(target: self, action: #selector(DetailMovieViewController.openDetail))
//    self.contentView.isUserInteractionEnabled = true
//    listDetail.details = String(detailModel.id)
//    self.contentView.addGestureRecognizer(listDetail)
//
//    @objc func openDetail(sender: DetailTapGesture){
//        let changePass = ReviewMovieViewController()
//        changePass.movie_id = sender.details
//        changePass.modalPresentationStyle = .fullScreen
//        self.present(changePass, animated: true, completion: nil)
    }


