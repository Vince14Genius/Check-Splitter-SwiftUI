//
//  Amount.swift
//  Check Splitter
//
//  Created by Vincent C. on 7/3/20.
//

import Foundation

public struct Amount {
   
    private let value: Double
    
    private var hundredths: Int {
        return Int(round(value * 100))
    }
    
    public var rounded: Amount {
        return Amount(round(value * 100) / 100)
    }
    
    private init(hundredths: Int) {
        self.value = Double(hundredths) / 100
    }
    
    public static func + (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(lhs.value + rhs.value)
    }
    
    public static func - (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(lhs.value - rhs.value)
    }
    
    public static func * (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(lhs.value * rhs.value)
    }
    
    public static func / (_ lhs: Amount, _ rhs: Amount) -> Double {
        return lhs.value / rhs.value
    }
}

extension Amount: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    
    public init(_ value: Double) {
        self.init(floatLiteral: value)
    }
    
    public init(floatLiteral value: Double) {
        self.value = value
    }
}

extension Amount: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self.value = Double(value)
    }
}

extension Amount: Comparable {
    public static func < (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.hundredths < rhs.hundredths
    }
    
    public static func == (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.hundredths == rhs.hundredths
    }
}

extension Amount: CustomStringConvertible {
    public var description: String {
        let hundredthsAfterDecimalPoint = hundredths % 100
        let wholeNumber = (hundredths - hundredthsAfterDecimalPoint) / 100
        if hundredthsAfterDecimalPoint < 10 {
            return "\(wholeNumber).0\(hundredthsAfterDecimalPoint)"
        } else {
            return "\(wholeNumber).\(hundredthsAfterDecimalPoint)"
        }
    }
}
