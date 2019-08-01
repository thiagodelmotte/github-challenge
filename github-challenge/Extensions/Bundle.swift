
import Foundation

extension Bundle {
    
    var endpointBase: URL {
        let endpoint = self.object(forInfoDictionaryKey: "ENDPOINT_BASE") as! String
        return URL(string: endpoint)!
    }
    
}
