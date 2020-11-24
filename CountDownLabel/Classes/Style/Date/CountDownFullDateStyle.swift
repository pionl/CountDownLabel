//
//  CountDownFullDateStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// Foramtes the date in full style. Prepared for the full string countdown
class CountDownFullDateStyle: CountDownFullStyle {
    
    /**
     Sets the time separator
     
     - parameter formatter:
     */
    override func setup(formatter: CountDownBaseFormatter) {
        super.setup(formatter: formatter)
        
        // ensure the correct time separator
        formatter.dateSeparator = " "
    }
}
