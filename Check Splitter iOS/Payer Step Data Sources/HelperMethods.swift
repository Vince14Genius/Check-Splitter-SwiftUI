//
//  HelperMethods.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/20/21.
//

import Foundation

extension String {
    func withDefaultOption(_ defaultOption: String) -> String {
        return self == "" ? defaultOption : self
    }
}

func index<T: Identifiable>(withID elementID: T.ID, in arr: Array<T>) -> Int {
    arr.firstIndex { $0.id == elementID }!
}
