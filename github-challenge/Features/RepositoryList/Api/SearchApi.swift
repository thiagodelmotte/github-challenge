
import Foundation

class SearchApi: Api {
    
    typealias searchSuccess = (_ search: Search) -> Void
    typealias searchFailure = (_ statusCode: Int?, _ error: Error?, _ response: Any?) -> Void
    
    class func fetch(_ page: Int, success: @escaping searchSuccess, failure: @escaping searchFailure) {
        var components = super.apiComponents()
        components.path += "/search/repositories"
        
        let querySearch = URLQueryItem(name: "q", value: "language:swift")
        let querySort = URLQueryItem(name: "sort", value: "stars")
        let queryPage = URLQueryItem(name: "page", value: "\(page)")
        components.queryItems = [querySearch, querySort, queryPage]
        
        guard let url = components.url else {
            failure(nil, nil, nil)
            return
        }
        
        super.request(.get, url: url, parameters: nil, success: { (statusCode, response) in
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: response, options: []) {
                if let search = try? JSONDecoder().decode(Search.self, from: jsonData) {
                    success(search)
                } else {
                    failure(statusCode, nil, nil)
                }
            }
            
        }) { (statusCode, response, error) in
            failure(statusCode, error, response)
        }
    }
    
}
