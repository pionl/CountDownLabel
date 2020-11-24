//
//  CountDownFormatProtocol.swift
//  CountDownLabel
//
//  Created by Martin Kluska on 30.05.16.
//  Copyright © 2016 iMakers, s.r.o. All rights reserved.
//

import Foundation

public protocol CountDownFormatProtocol: class {
    
    /**
     Formates the given components into the string
     
     - parameter components:
     
     - returns:
     */
    func format(components: DateComponents) -> String
    
    /**
     Returns the desired date components
     
     - returns:
     */
    func dateComponents() -> Set<Calendar.Component>
    
}
