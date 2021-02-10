//
//  MovieViewController.swift
//  Movies
//
//  Created by Seraphina Tatiana   on 09/02/21.
//

import UIKit
import Alamofire

class MovieViewController: BaseViewController {
    @IBOutlet weak var listMovie: UITableView!
    @IBOutlet weak var backButton:
        UIBarButtonItem!
    
    var movieModel : MovieModel!
    var genreModel : GenreModel!
    
    var genre_ids : String!
    var id : String!
    override func viewDidLoad() {
    super.viewDidLoad()
        listMovie.delegate = self
        listMovie.dataSource = self
        
        getRequest(url: "/discover/movie?api_key=\(MoviesUrl.API_KEY)&with_genres=\(genre_ids!)", tag: "movie")
        let nibClass = UINib(nibName: "MovieTableViewCell", bundle: nil)
        listMovie.register(nibClass, forCellReuseIdentifier: "movieIdentifier")
        
    }
    override func onSuccess(data: Data, tag: String) {
        do{
            let decoder = JSONDecoder()
            self.movieModel = try decoder.decode(MovieModel.self, from:data)
            self.listMovie.reloadData()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

    extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieModel?.results.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = listMovie.dequeueReusableCell(withIdentifier: "movieIdentifier") as! MovieTableViewCell
            
            let moviesModel: Result = (movieModel?.results[indexPath.row])!
            cell.titleMovie.text = moviesModel.title
            cell.overviewMovie.text = moviesModel.overview
            return cell

            
            
            
            
            
            
//            let movie = GenreTapGesture(target: self, action: #selector(MovieViewController.openNews))
//            cell.sourcesView.isUserInteractionEnabled = true
//            sourcesCat.sources = sourcesModel.id
//            cell.sourcesView.addGestureRecognizer(sourcesCat)
        }
        
    }
