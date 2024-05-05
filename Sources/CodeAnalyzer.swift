//
//  CodeAnalyzer.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 05.05.2024.
//

import Foundation

public class CodeAnalyzer {
    public func readFile(_ fileName: String) {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "swift") {
            do {
                let fileContents = try String(contentsOfFile: filePath)
                print("Contents of \(fileName).swift:")
                print(fileContents)
            } catch {
                print("Error reading file: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(fileName).swift")
        }
    }
}
