//
//  RoundView.swift
//  NoneAttm
//
//  Created by Daniel Senga on 2020/08/06.
//  Copyright © 2020 Daniel Senga. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {
    
    @IBInspectable
    var bColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        layer.cornerRadius = 26
        layer.borderWidth = 9.3
        layer.borderColor = bColor.cgColor
    }
    
}


