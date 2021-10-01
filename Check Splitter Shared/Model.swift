//
//  Model.swift
//  Check Splitter
//
//  Created by Vincent C. on 7/3/20.
//

import Foundation

public typealias PayerName = String
public typealias SplitResult = (result: [PayerWithAmount], remainder: Amount)

public struct Item: Identifiable {
    public var name: String
    public var cost: Amount
    public var multiplier: Int = 1
    public var divisor: Int = 1
    public let id = UUID()
    
    public var costAfterMultiplyingByFraction: Amount {
        Amount(self.cost * Amount(integerLiteral: self.multiplier) / Amount(integerLiteral: self.divisor))
    }
    
    public var hasNonIdentityFraction: Bool {
        return !(self.multiplier == 1 && self.divisor == 1)
    }
    
    public var multiplyByFractionText: String {
        return self.hasNonIdentityFraction ? "× \(String(describing: self.multiplier))/\(String(describing: self.divisor))" : ""
    }
}

public struct PayerWithItems: Identifiable {
    public var name: PayerName
    public var items: [Item]
    public let id = UUID()
}

public struct PayerWithAmount {
    public var name: PayerName
    public var amount: Amount
    public var id: UUID
}

/**
 - returns: the sum of payment amounts for the given `Array<PayerWithAmount>`
 */
public func sumOfAmounts(payers: [PayerWithAmount]) -> Amount {
    return payers.reduce(0) { $0 + $1.amount }
}

/**
 - returns: the sum of prices for the given `Array<Item>`
 */
fileprivate func payerSubtotal(_ rawAmount: [Item]) -> Amount {
    return rawAmount.reduce(0) { $0 + $1.costAfterMultiplyingByFraction }
}

/**
 Reduce lists of items into subtotals for each payer
 */
fileprivate func payerSubtotals(payers: [PayerWithItems]) -> [PayerWithAmount] {
    return payers.map { .init(name: $0.name, amount: payerSubtotal($0.items), id: $0.id) }
}

/**
 Calculate proportions from each payer's share in the subtotal for the entire group
 */
fileprivate func payerProportions(payers: [PayerWithAmount]) -> [(name: PayerName, proportion: Double, id: UUID)] {
    let total = sumOfAmounts(payers: payers)
    return payers.map { (name: $0.name, proportion: $0.amount / total, id: $0.id) }
}

/**
 Call this function to split the check.
 
 - parameters:
    - totalPayment: the total payment to divide from
    - payers: a `Dictionary` consisting of the subtotals assigned to each payer
 
 - returns: a `Dictionary` consisting of shares of the total payment assigned to each payer, based on the proportions of each payer's subtotal in relation to the sum of subtotals
 */
public func splitCheck(totalPayment: Amount, payers: [PayerWithItems]) -> SplitResult {
    let proportions = payerProportions(payers: payerSubtotals(payers: payers))
    let result = proportions.map {
        PayerWithAmount(name: $0.name, amount: Amount($0.proportion) * totalPayment, id: $0.id)
    }
    return (
        result: result,
        remainder: totalPayment - sumOfAmounts(payers: result).rounded
    )
}

/**
 - returns: the subtotal for the entire list of payers
 */
public func sumOfSubtotals(payers: [PayerWithItems]) -> Amount {
    return sumOfAmounts(payers: payerSubtotals(payers: payers))
}
