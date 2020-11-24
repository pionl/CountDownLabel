//
//  CountDown.swift
//  CountDownLabel
//
//  Created by Martin Kluska on 30.05.16.
//  Copyright © 2016 iMakers, s.r.o. All rights reserved.
//

import Foundation

/**
 The error for any countdown settings/runtime
 
 - NotSet:
 */
public enum CountDownError: Error {
    case propertyNotSet(message: String)
}

/**
 Represents the logic how the countdown is treated.
 
 - Static: Show only current time diff in selected format
 - CountDown: Count downs to the end date
 - Automatic: Supports future/past diff times
 */
public enum CountDownLogic: String {
    case Static = "static"
    case CountDown = "countdown"
    case Automatic = "automatic"
}

public class CountDown {
    
    /// Desired date for internal usage
    private var _date: NSDate?
    
    /// The final date to count down. When fully prepared and the autostart
    /// is set to true, it will start the countdown
    public var date: NSDate? {
        set(date) {
            _date = date
            
            if isFullyPrepared() {
                if timer != nil {
                    updateCountDown()
                } else if autoStartOnDate {
                    start()
                }
            }
        }
        get {
            return _date
        }
    }
    
    /// Desired time interval to trigger the timer
    public var timeInterval: TimeInterval = 1.0
    
    /// Autostart when the date is set
    public var autoStartOnDate: Bool = true
    
    /// Desired formatter for the date
    public var formatter: CountDownFormatProtocol
    
    /// Delegeate that will receive the date format
    public weak var delegate: CountDownProtocol?
    
    /// The logic for the countdown
    public var logic: CountDownLogic = .CountDown
    
    /// Indicates if the countdown has finished
    private(set) public var hasFinished: Bool = false
    
    /// The finished message on countdown logic
    public var finishedMessage: String = CountDownBundle.localizedString(key: "countdown_finished")
    
    // MARK: INIT
    
    
    /**
     Creates the countdown with delegate and the formatter
     
     - parameter aDelegate: the delegate that will listen to the states
     - parameter aFormatter: a used fomratter, the base formatter is used on nil
     
     - returns:
     */
    public init(aDelegate: CountDownProtocol? = nil, aFormatter: CountDownFormatProtocol? = nil) {
        delegate = aDelegate
        formatter = aFormatter == nil ? CountDownBaseFormatter() : aFormatter!
    }
    
    deinit {
        stop()
    }
    
    // MARL: Start
    
    /**
     Starts the countdown or updates it
     */
    public func start() {
        if isFullyPrepared() {
            
            hasFinished = false
            
            // enable automatic timer for the countdown
            if logic != .Static {
            // start sheduler
                timer = Timer.scheduledTimer(
                    timeInterval: timeInterval,
                    target: self,
                    selector: #selector(CountDown.onTimer(_timer:)),
                    userInfo: nil, repeats: true)
            }
            
            // update the starting value
            updateCountDown()
        }
    }
    
    /**
     Stops the countdown
     */
    public func stop() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    // MARK: Timer
    
    /// The timer used to update the countdown
    private var timer: Timer?
    
    /**
     Triggered via timer
     
     - parameter _timer:
     */
    @objc private func onTimer(_timer: Timer) {
        if isFullyPrepared() {
            updateCountDown()
        }
    }
    
    // MARK: Format
    
    /**
     Returns the current format for the date. Must be fully setted
     
     - returns:
     */
    public func currentFormat() -> String {
        // prepare dates for components
        let now = Date()
        var fromDate: Date?
        var toDate: Date?
        
        // check which way to count the diff of dates
        let dateInPast = now.timeIntervalSinceNow <= date!.timeIntervalSinceNow
        
        // add support to future and past coundtown
        if dateInPast {
            fromDate = now
            toDate = date as! Date
        } else {
            
            // if we have countdown and the current date is not in the current state
            // we must finish the timer
            if (logic == .CountDown) {
                // stop the timer and update the delegate
                stop()
                delegate?.countDownFinished(countDown: self)
                
                // the countdown has finished
                hasFinished = true
                
                // formates the finished date
                return formatFinishedState()
            }
            
            // turn the dates to enable up increase of the date
            fromDate = date as! Date
            toDate = now
        }
        
        // get the date components
        let dateComponents = Calendar.current.dateComponents(
            formatter.dateComponents(),
            from: fromDate!,
            to: toDate!
        )
        
        // build the format
        return formatter.format(components: dateComponents)
    }
    
    /**
     Formates the finished state
     */
    func formatFinishedState() -> String {
        return finishedMessage;
    }
    
    /**
     Updates the countdown delegate with new formated string. Must be fully setted
     */
    public func updateCountDown() {
        let formatedString = currentFormat()
        
        // tell the delegate that we have new format
        delegate?.countDownChanged(countDown: self, format: formatedString)
    }
    
    // MARK: Helpers
    
    /**
     Checks if all the properties are set. Prints debug errors
     
     - returns:
     */
    private func isFullyPrepared() -> Bool {
        do {
            try testRequiredProperty(value: delegate, description: "delegate to update your UI")
            try testRequiredProperty(value: date, description: "starting date")
            try testRequiredProperty(value: formatter, description: "formatter you want to use")
            
            return true
        } catch CountDownError.propertyNotSet(let message) {
            debugPrint("CountDown: \(message)")
        } catch {
            debugPrint("CountDown: raised unknown error")
        }
        
        return false
    }
    
    /**
     Checks if the property values is not nil
     
     - parameter value:
     - parameter description:
     
     - throws:
     */
    private func testRequiredProperty(value: Any?, description: String) throws {
        guard value != nil else {
            throw CountDownError.propertyNotSet(message: "You must set a \(description)")
        }
    }
}
