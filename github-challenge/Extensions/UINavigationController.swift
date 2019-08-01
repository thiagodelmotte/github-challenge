
import UIKit

extension UINavigationController {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.standard()
    }
    
    func standard() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = .grayMedium
        self.navigationBar.barTintColor = .grayMedium
        self.navigationBar.tintColor = .black
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.medium(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}
