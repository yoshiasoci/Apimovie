//
//  GenreViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 09/02/21.
//

import UIKit
import Alamofire
import Moya

class GenreViewController: BaseViewController {
    
    @IBOutlet weak var listGenre: UITableView!
    
    var genreModel : GenreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        listGenre.delegate = self
        listGenre.dataSource = self
        
        //getRequest(url: "/genre/movie/list?api_key=\(MoviesUrl.API_KEY)", tag: "genre")
        let nibClass = UINib(nibName: "GenreTableViewCell", bundle: nil)
        listGenre.register(nibClass, forCellReuseIdentifier: "genreIdentifier")
       
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<MovieApi>(plugins: [networkLogger])
        provider.request(.genre(apikey: "API_KEY")) { (result) in
            switch result {
            case .success(let response):
                do{
                    let genres: GenreModel = try response.map(GenreModel.self)
                    self.genreModel = genres
                    self.listGenre.reloadData()
                    
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
    //            self.genreModel = try decoder.decode(GenreModel.self, from:data)
    //            debugPrint(self.genreModel)
    //            self.listGenre.reloadData()
    //        }catch{
    //            print(error.localizedDescription)
    //        }
    //    }
}

extension GenreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreModel?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listGenre.dequeueReusableCell(withIdentifier: "genreIdentifier") as! GenreTableViewCell
        
        let genresModel: Genre = (genreModel?.genres[indexPath.row])!
        cell.genreLabel.text = genresModel.name
        
        
        let genreMovie = GenreTapGesture(target: self, action: #selector(GenreViewController.openMovie))
        cell.detailGenre.isUserInteractionEnabled = true
        genreMovie.genre = String(genresModel.id)
        cell.detailGenre.addGestureRecognizer(genreMovie)
        return cell
    }
    
    @objc func openMovie(sender: GenreTapGesture){
        let changePass = MovieViewController()
        changePass.genre_ids = sender.genre
        changePass.modalPresentationStyle = .fullScreen
        self.present(changePass, animated: true, completion: nil)
    }
}


