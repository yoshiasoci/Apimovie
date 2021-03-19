//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 10/02/21.
//

import UIKit
import Moya
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
        
       // getRequest(url: "/movie/\(movie_id ?? "")?api_key=\(MoviesUrl.API_KEY)", tag: "movie")
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        
        let provider = MoyaProvider<MovieApi>(plugins: [networkLogger])
        provider.request(.detail(movieId: movie_id)) { [self] (result) in
            switch result {
            case .success(let response):
                do{
                    let details: DetailModel = try response.map(DetailModel.self)
                    self.detailModel = details
                    self.releasedateLabel.text = detailModel.releaseDate
                    self.overviewText.text = detailModel.overview
                    self.statusLabel.text = detailModel.status
                    //testttttcommit
                }
                catch {
                    debugPrint("error")
                }
                break
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
        
    }
//           // self.revenueLabel.text = String(detailModel.revenue)
//            self.releasedateLabel.text = detailModel.releaseDate
//            self.overviewText.text = detailModel.overview
//
//           }catch{
//               print(error.localizedDescription)
//           }
         



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


