//
//  Model.swift
//  Check Splitter
//
//  Created by Vincent C. on 7/3/20.
//

/*
Independent Variables:
- totalPayment : Amount
- rawAmounts : [RawAmount] = [payerAmount1, payerAmount2, ..., payerAmountN]

Structure of RawAmount:
- RawAmount : [ItemName: Amount] = [itemPrice1, itemPrice2, ..., itemPriceN]

Dependent Variables:
- finalAmounts : [Amount] [finalAmount1, finalAmount2, ..., finalAmountN]
*/

import Foundation

public typealias PayerName = String
public typealias ItemName = String
public typealias RawAmount = [ItemName: Amount]

fileprivate func payerRawSum(_ rawAmount: RawAmount) -> Amount {
    return rawAmount.reduce(0, { $0 + $1.value })
}

fileprivate func reduceRaw(payers: [PayerName: RawAmount]) -> [PayerName: Amount] {
    return payers.mapValues(payerRawSum)
}

fileprivate func payerProportions(payers: [PayerName: Amount]) -> [PayerName: Double] {
    let total = payers.reduce(0, { $0 + $1.value })
    return payers.mapValues { $0 / total }
}

public func splitCheck(totalPayment: Amount, payers: [PayerName: RawAmount]) -> [PayerName: Amount] {
    let proportions = payerProportions(payers: reduceRaw(payers: payers))
    return proportions.mapValues { Amount($0) * totalPayment }
}
