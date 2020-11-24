//
//  CountDownNoStyle.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

class CountDownNoStyle: CountDownStyleProtocol {
    
    /**
     Does nothing
     
     - parameter formatter:
     */
    func setup(formatter: CountDownBaseFormatter) {
        
    }
    
    /**
     Checks if the components value is not null
     
     - parameter compontent:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool {
        return false
    }
    
    /**
     Formates the values into string component with the value
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func format(component: CountDownFormatComponent, value: Int) -> String {
        return ""
    }
}
