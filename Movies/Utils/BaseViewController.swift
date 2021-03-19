import UIKit
import Alamofire
import Moya

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//    
//    func getRequest(url: String, tag: String){
//        AF.request("\(MoviesUrl.BASE_URL)\(url)",
//                   method: .get,
//                   parameters: nil,
//                   encoding: JSONEncoding.default).responseData { response in
//                    debugPrint(response)
//                    switch response.result {
//                        case .success(let data):
//                            self.onSuccess(data: data, tag: tag)
//                            break
//                        case .failure(_):
//                            self.onFailed(tag: tag)
//                            break
//                        }
//                   }
//    }
    
    func getRequest(tag: String) {
        let provider = MoyaProvider<MovieApi>()
        provider.request(.genre(apikey: "API_KEY")) { (result) in
            switch result {
            case .success(let response):
                print(response.statusCode)
                //self.onSuccess(data: data, tag: tag)
            case .failure(let error):
               // self.onFailed(tag: tag)
                print(error.errorDescription ?? "")

            }
        }
    }
    
//    func getRequest2(tag: String) {
//        let provider = MoyaProvider<MovieApi>()
//        provider.request(.function2(params: "4567")) { (result) in
//            switch result {
//            case .success(let response):
//                break
//                //self.onSuccess(data: data, tag: tag)
//            case .failure(let error):
//                self.onFailed(tag: tag)
//            }
//        }
//    }
    
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

extension UIViewController {

func showToast(message: String, font: UIFont) {
    let toastLabel = UILabel()
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = .white
    toastLabel.font = font
    toastLabel.textAlignment = .center
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10
    toastLabel.clipsToBounds = true
    
    let maxWidthPercentage: CGFloat = 0.8
    let maxTitleSize = CGSize(width: view.bounds.size.width * maxWidthPercentage, height: view.bounds.size.height * maxWidthPercentage)
    var titleSize = toastLabel.sizeThatFits(maxTitleSize)
    titleSize.width += 20
    titleSize.height += 10
    toastLabel.frame = CGRect(x: view.frame.size.width / 2 - titleSize.width / 2, y: view.frame.size.height - 50, width: titleSize.width, height: titleSize.height)
    
    view.addSubview(toastLabel)
    
    UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: { _ in
        toastLabel.removeFromSuperview()
    })
}
}



