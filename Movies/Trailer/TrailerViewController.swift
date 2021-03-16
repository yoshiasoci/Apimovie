//
//  TrailerViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 11/02/21.
//

import UIKit
//test
import Alamofire


class TrailerViewController: BaseViewController {

    @IBOutlet weak var listTrailer: UITableView!
    
    var trailerModel : TrailerModel!
    var movie_id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTrailer.delegate = self
        listTrailer.dataSource = self
        
        getRequest(url: "/movie/\(movie_id ?? "")/videos?api_key=\(MoviesUrl.API_KEY)", tag: "trailer")
        let nibClass = UINib(nibName: "TrailerTableViewCell", bundle: nil)
        listTrailer.register(nibClass, forCellReuseIdentifier: "trailerIdentifier")

    }
    override func onSuccess(data: Data, tag: String) {
        do{
            let decoder = JSONDecoder()
            self.trailerModel = try decoder.decode(TrailerModel.self, from:data)
            self.listTrailer.reloadData()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    override func onFailed(tag: String) {
        showToast(message: "Data Not Found, Try Again Later!", font: .systemFont(ofSize: 12.0))
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
