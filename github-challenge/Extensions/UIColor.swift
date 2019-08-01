
import UIKit

extension UIColor {
    
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    var coreImageColor: CoreImage.CIColor {
        return CoreImage.CIColor(color: self)
    }
    
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: self.coreImageColor.red, green: self.coreImageColor.green, blue: self.coreImageColor.blue, alpha: alpha)
    }
    
    class var black: UIColor {
        return UIColor(0, 0, 0, 1)
    }
    
    class var white: UIColor {
        return UIColor(255, 255, 255, 1)
    }
    
    class var darkBlue: UIColor {
        return UIColor(15, 60, 194, 1)
    }
    
    class var grayDark: UIColor {
        return UIColor(96, 96, 96, 1)
    }
    
    class var grayLight: UIColor {
        return UIColor(138, 138, 138, 1)
    }
    
    class var grayMedium: UIColor {
        return UIColor(226, 226, 226, 1)
    }
    
    class var gray: UIColor {
        return UIColor(166, 166, 166, 1)
    }
    
}
