//
//  CodeAnalyzer.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 18.05.2024.
//

import Foundation
import SwiftParser

public class CodeAnalyzer {
    public init() {}
    
    public func calculateCyclomaticComplexity(atPath path: String) -> Int {
        let reader = CyclomaticComplexityVisitor(viewMode: .all)
        let content: String = readSwiftFile(atPath: path) ?? "Error to read .swift file"
        let complexity = reader.calculateCyclomaticComplexity(atPath: content)
        return complexity
    }
    
    public func calculateConnectivityAndConnectivity(atPath path: String) -> Double {
        let content = readSwiftFile(atPath: path) ?? "Error to read .swift file"
        let collector = MetricsCollector(viewMode: .all)
        let result = collector.analyzeFile(atPath: content)
        return result
    }
    
    public func calcualteCohesionAndCoupling(atPath path: String) {
        let content = readSwiftFile(atPath: path) ?? "Error to read .swift file"
        let analyzer = CohesionCouplingAnalyzer(viewMode: .all)
        analyzer.analyzeFile(atPath: content)
    }
}

private extension CodeAnalyzer {
    private func readSwiftFile(atPath path: String) -> String? {
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            return content
        } catch {
            print("Error reading file: \(error.localizedDescription)")
            return nil
        }
    }
}
