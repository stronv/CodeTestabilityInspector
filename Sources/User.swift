//
//  User.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 23.04.2024.
//

import Foundation

public class User {
    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public func sayHi() {
        print("Hello \(name)")
    }
}
