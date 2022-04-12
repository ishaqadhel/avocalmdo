//
//  Extension.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import Foundation
import UIKit

extension UITextField {
    func changeTextfield() {
        self.backgroundColor = UIColor.systemRed
    }
}

extension UITextView {
    func setBackgroundShadow() {
        self.layer.cornerRadius = 14
       // self.layer.shadowColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
    }
}

/**
 * Function View For Styling
 */
extension UIView {
    func setRounded(cornerRadiusSize: CGFloat = 13) {
        self.layer.cornerRadius = cornerRadiusSize
        self.layer.cornerCurve = .continuous // make corner more smooth
    }
}
