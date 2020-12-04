//
//  UITableViewCell+Extensions.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit

public extension UITableViewCell {
    class func defaultIdentifier() -> String {
        return String(describing: self)
    }
}
