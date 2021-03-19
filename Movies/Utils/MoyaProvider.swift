//
//  MoyaProvider.swift
//  Movies
//
//  Created by Anaidyd Alcestfini on 17/03/21.
//

import Foundation
import Moya

enum MovieApi {
    case genre(apikey: String)
    case movie(genreId: String)
    case detail(movieId: String)
    case review(movieId: String)
    case trailer(movieId: String)
    
}
extension MovieApi: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .genre:
            return "genre/movie/list"
        case .movie:
            return "discover/movie"
        case .detail(let movieId):
            return "movie/\(movieId)"
        case .review(let movieId):
            return "movie/\(movieId)/reviews"
        case .trailer(let movieId):
            return "movie/\(movieId)/videos"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .genre:
            return .requestParameters(parameters: ["api_key": MoviesUrl.API_KEY], encoding: URLEncoding.default)
            
        case .movie(let genreId):
            return .requestParameters(parameters: ["with_genres" : genreId, "api_key": MoviesUrl.API_KEY], encoding: URLEncoding.default)
            
        case .detail(let movieId):
            return .requestParameters(parameters: ["api_key": MoviesUrl.API_KEY], encoding: URLEncoding.default)
            
        case .review(let movieId):
            return .requestParameters(parameters: ["api_key": MoviesUrl.API_KEY], encoding: URLEncoding.default)
        
        case .trailer(let movieId):
            return .requestParameters(parameters: ["api_key": MoviesUrl.API_KEY], encoding: URLEncoding.default)
        }
        }
    
    var headers: [String : String]? {
        return nil
    }
}

    
//method
//        switch self {
//        case .genre:
//            return .get
//        case .movie:
//            return .get
//        default:
//            return .post

//extension MovieApi {
//    var parameters: [String: Any] {
//        switch self {
//        case .genre(let params),
//             .movie(let params):
//
//            return ["params": params]
//        }
//    }
//}
