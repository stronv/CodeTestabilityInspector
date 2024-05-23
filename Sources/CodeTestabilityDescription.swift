//
//  CodeTestabilityDescription.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 23.05.2024.
//

import Foundation

public enum CodeTestability: String {
    case excellentlyTestable
    case wellTestable
    case poorlyTestable

    var description: String {
        switch self {
        case .excellentlyTestable:
            return "Your code will be tested perfectly. Good job!"
        case .wellTestable:
            return "Your code will be tested well. Please check the information above and explore how it can be improved."
        case .poorlyTestable:
            return "Your code will be poorly tested. Please check the information above and explore how it can be improved."
        }
    }
}
