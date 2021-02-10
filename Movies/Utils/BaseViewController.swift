//
//  BaseViewController.swift
//  Digitalent
//
//  Created by Teke on 16/10/20.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getRequest(url: String, tag: String){
        AF.request("\(MoviesUrl.BASE_URL)\(url)",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    debugPrint(response)
                    switch response.result {
                        case .success(let data):
                            self.onSuccess(data: data, tag: tag)
                            break
                        case .failure(_):
                            self.onFailed(tag: tag)
                            break
                        }
                   }
    }
    
    func postRequest(url: String, parameters: [String:Any], tag: String){
        
        AF.request("\(MoviesUrl.BASE_URL)\(url)",
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                   debugPrint(response)
                    switch response.result {
                    case .success(let data):
                        self.onSuccess(data: data, tag: tag)
                        break
                    case .failure(_):
                        self.onFailed(tag: tag)
                        break
                    }
        }
    }
    
    func putRequest(url: String, parameters: [String:Any], tag: String){
        
        AF.request("\(MoviesUrl.BASE_URL)\(url)",
                   method: .put,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    
                    switch response.result {
                    case .success(let data):
                        self.onSuccess(data: data, tag: tag)
                        break
                    case .failure(_):
                        self.onFailed(tag: tag)
                        break
                    }
        }
    }
    
    func onSuccess(data: Data, tag: String){}
    
    func onFailed(tag: String){
        debugPrint("Error Get Request \(tag)")
    }

}

extension UIViewController {
    func saveStringPreference(value: String, key: String){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    
    func readStringPreference(key: String) -> String {
        let preferences = UserDefaults.standard
        return preferences.string(forKey: key) ?? ""
    }
    
}




