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
    func setShadowj() {
        self.layer.cornerRadius  = 15
        self.layer.shadowOpacity = 0.20
        self.layer.shadowRadius  = 3.0
        self.layer.shadowColor   = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: 2)
        self.layer.masksToBounds = false
    }
}

extension UIButton {
    func setShadow() {
        self.layer.cornerRadius  = 15
        self.layer.shadowOpacity = 0.30
        self.layer.shadowRadius  = 3.0
        self.layer.shadowColor   = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: 2)
        self.layer.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0).cgColor
        self.layer.masksToBounds = false
    }
}

extension UITextView {
    func setShadow() {
        self.layer.cornerRadius  = 15
        self.layer.shadowOpacity = 0.30
        self.layer.shadowRadius  = 3.0
        self.layer.shadowColor   = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: 2)
        self.layer.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0).cgColor
        self.layer.masksToBounds = false
    }
}
