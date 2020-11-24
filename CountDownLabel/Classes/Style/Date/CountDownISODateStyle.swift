//
//  CountDownISODateStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// Formates the date to ISO style
class CountDownISODateStyle: CountDownStyleProtocol {
    
    // @todo: add a enum with the prefered iso style
    
    /**
     Sets the time separator
     
     - parameter formatter:
     */
    func setup(formatter: CountDownBaseFormatter) {
        
        // ensure the correct time separator
        formatter.dateSeparator = "/"
    }
    
    /**
     All values can be returned for a time
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool {
        return true
    }
    
    /**
     Formates the value into 2 digits string
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func format(component: CountDownFormatComponent, value: Int) -> String {
        var format: String
        
        // format the correct digits (expect the year)
        if (component == .year) {
            format = "%d"
        } else {
            format = "%02d"
        }
        
        return String(format: format, value)
    }
}
