
import Alamofire

typealias completionApiSuccess = (_ statusCode: Int, _ response: Any?) -> Void
typealias completionApiFailure = (_ statusCode: Int, _ response: Any?, _ error: Error?) -> Void

typealias completionRequestSuccess = (_ statusCode: Int, _ response: [String : Any]) -> Void
typealias completionRequestFailure = (_ statusCode: Int, _ response: Any?, _ error: Error?) -> Void

class Api {
    
    enum httpVerbs: String {
        case get, post, put, patch, delete
    }
    
    enum statusCodes: Int {
        case disconnected = 12163
    }
    
    private class func requestAlamofire(_ method: httpVerbs, url: URL, parameters: [String : Any]?, success: @escaping completionApiSuccess, failure: @escaping completionApiFailure) -> ApiRequest? {
        
        guard Reachability.isConnected() else {
            failure(statusCodes.disconnected.rawValue, nil, nil)
            return nil
        }
        
        let alamofireMethod = Alamofire.HTTPMethod(rawValue: method.rawValue.uppercased())!
        
        let request = Alamofire.request(url, method: alamofireMethod, parameters: parameters, encoding: URLEncoding())
            .validate(contentType: ["application/json"])
            .responseData(completionHandler: { data in
                
                let value = data.result.value
                
                guard let code = data.response?.statusCode else {
                    failure(statusCodes.disconnected.rawValue, nil, nil)
                    return
                }
                
                switch data.result {
                case .success:
                    if (200..<300).contains(code) {
                        success(code, value)
                    } else {
                        failure(code, value, nil)
                    }
                case .failure(let error):
                    failure(code, nil, error)
                }
                
            })
        
        return ApiRequest(request)
        
    }
    
    @discardableResult class func request(_ method: httpVerbs, url: URL, parameters: [String : Any]?, success: @escaping completionRequestSuccess, failure: @escaping completionRequestFailure) -> ApiRequest? {
        
        return self.requestAlamofire(method, url: url, parameters: parameters, success: { (statusCode, response) in
            guard let value = response else {
                failure(statusCode, response, nil)
                return
            }
            success(statusCode, self.response(value))
        }) { (statusCode, response, error) in
            failure(statusCode, response, nil)
        }
        
    }
    
    class func apiComponents() -> URLComponents {
        return URLComponents(url: Bundle.main.endpointBase, resolvingAgainstBaseURL: true)!
    }
    
    class func response(_ value: Any) -> [String : Any] {
        guard let data = value as? Data else {
            return [String : Any]()
        }
        guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return [String : Any]()
        }
        guard let jsonDic = jsonObj as? [String : Any] else {
            return [String : Any]()
        }
        
        return jsonDic
    }
    
}
