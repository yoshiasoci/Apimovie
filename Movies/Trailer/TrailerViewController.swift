//
//  TrailerViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 11/02/21.
//

import UIKit
import Moya
import Alamofire


class TrailerViewController: BaseViewController {

    @IBOutlet weak var listTrailer: UITableView!
    
    var trailerModel : TrailerModel!
    var movie_id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTrailer.delegate = self
        listTrailer.dataSource = self
        
//        getRequest(url: "/movie/\(movie_id ?? "")/videos?api_key=\(MoviesUrl.API_KEY)", tag: "trailer")
        let nibClass = UINib(nibName: "TrailerTableViewCell", bundle: nil)
        listTrailer.register(nibClass, forCellReuseIdentifier: "trailerIdentifier")
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<MovieApi>(plugins: [networkLogger])
        provider.request(.trailer(movieId: movie_id)) { [self] (result) in
            switch result {
            case .success(let response):
                do{
                    let trailers: TrailerModel = try response.map(TrailerModel.self)
                    self.trailerModel = trailers
                    self.listTrailer.reloadData()
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
//    override func onSuccess(data: Data, tag: String) {
//        do{
//            let decoder = JSONDecoder()
//            self.trailerModel = try decoder.decode(TrailerModel.self, from:data)
//            self.listTrailer.reloadData()
//
//        }catch{
//            print(error.localizedDescription)
//        }
//    }
//    override func onFailed(tag: String) {
//        showToast(message: "Data Not Found, Try Again Later!", font: .systemFont(ofSize: 12.0))
//    }
    @IBAction func backButton(_ sender: Any) { self.dismiss(animated: true, completion: nil)
    }
}

    extension TrailerViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trailerModel?.results.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = listTrailer.dequeueReusableCell(withIdentifier: "trailerIdentifier") as! TrailerTableViewCell
            
            let trailer: TrailerDetailModel = (trailerModel?.results[indexPath.row])!
            cell.trailerMovie.load(withVideoId: trailer.key)
            debugPrint(trailer.key)

            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
    }
