//
//  Amount.swift
//  Check Splitter
//
//  Created by Vincent C. on 7/3/20.
//

import Foundation

public struct Amount: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, CustomStringConvertible, Comparable {
    public var description: String {
        let hundredthsAfterDecimalPoint = hundredths % 100
        let wholeNumber = (hundredths - hundredthsAfterDecimalPoint) / 100
        return "\(wholeNumber).\(hundredthsAfterDecimalPoint)"
    }
    
    private var value: Double {
        return Double(hundredths) / 100
    }
    
    private let hundredths: Int
    
    public typealias FloatLiteralType = Double
    public typealias IntegerLiteralType = Int
    
    public init(_ value: Double) {
        self.init(floatLiteral: value)
    }
    
    public init(floatLiteral value: Double) {
        self.hundredths = Int(round(value * 100))
    }
    
    public init(integerLiteral value: Int) {
        self.hundredths = value * 100
    }
    
    private init(hundredths: Int) {
        self.hundredths = hundredths
    }
    
    public static func + (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(hundredths: lhs.hundredths + rhs.hundredths)
    }
    
    public static func - (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(hundredths: lhs.hundredths - rhs.hundredths)
    }
    
    public static func * (_ lhs: Amount, _ rhs: Amount) -> Amount {
        return Amount(floatLiteral: lhs.value * rhs.value)
    }
    
    public static func / (_ lhs: Amount, _ rhs: Amount) -> Double {
        return lhs.value / rhs.value
    }
    
    public static func < (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.hundredths < rhs.hundredths
    }
    
    public static func == (lhs: Amount, rhs: Amount) -> Bool {
        return lhs.hundredths == rhs.hundredths
    }
}
