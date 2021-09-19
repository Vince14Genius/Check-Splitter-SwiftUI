//
//  Model.swift
//  Check Splitter
//
//  Created by Vincent C. on 7/3/20.
//

/*
Independent Variables:
- totalPayment : Amount
- rawAmounts : [LabeledAmounts] = [payerAmount1, payerAmount2, ..., payerAmountN]

Structure of LabeledAmounts:
- LabeledAmounts : [ItemName: Amount] = [itemPrice1, itemPrice2, ..., itemPriceN]

Dependent Variables:
- finalAmounts : [Amount] [finalAmount1, finalAmount2, ..., finalAmountN]
*/

import Foundation

public typealias PayerName = String
public typealias ItemName = String
public typealias LabeledAmounts = [ItemName: Amount]
public typealias SplitResult = (result: [PayerName: Amount], remainder: Amount)

fileprivate func payerRawSum(_ rawAmount: LabeledAmounts) -> Amount {
    return rawAmount.reduce(0, { $0 + $1.value })
}

fileprivate func reduceRaw(payers: [PayerName: LabeledAmounts]) -> [PayerName: Amount] {
    return payers.mapValues(payerRawSum)
}

fileprivate func payerProportions(payers: [PayerName: Amount]) -> [PayerName: Double] {
    let total = payers.reduce(0, { $0 + $1.value })
    return payers.mapValues { $0 / total }
}

/**
 Call this function to split the check.
 
 - parameters:
    - totalPayment: the total payment to divide from
    - payers: a `Dictionary` consisting of the subtotals assigned to each payer
 
 - returns: a `Dictionary` consisting of shares of the total payment assigned to each payer, based on the proportions of each payer's subtotal in relation to the sum of subtotals
 */
public func splitCheck(totalPayment: Amount, payers: [PayerName: LabeledAmounts]) -> SplitResult {
    let proportions = payerProportions(payers: reduceRaw(payers: payers))
    let result = proportions.mapValues { Amount($0) * totalPayment }
    return (
        result: result,
        remainder: totalPayment - result.reduce(0, { $0 + $1.value })
    )
}
