
import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func load(_ url: URL?) {
        guard let url = url else { return }
        
        self.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: false, completion: nil)
    }
    
}
