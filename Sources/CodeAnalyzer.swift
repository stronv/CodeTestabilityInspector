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
    
    public func calculateTheMaintainabilityIndex(atPath path: String) -> Double {
        let content = readSwiftFile(atPath: path) ?? "Error to read .swift file"
        let collector = MetricsCollector(viewMode: .all)
        let result = collector.analyzeFile(atPath: content)
        return result
    }
    
    public func calculateCohesionAndCoupling(atPath path: String) -> (cohesion: Double, coupling: Double) {
        let content = readSwiftFile(atPath: path) ?? "Error to read .swift file"
        let analyzer = CohesionCouplingAnalyzer(viewMode: .all)
        return analyzer.analyzeCohesionAndCoupling(atPath: content)
    }
    
    public func analyzeTestability(atPath filePath: String) -> CodeTestability {
        let mi = calculateTheMaintainabilityIndex(atPath: filePath)
        let (cohesion, coupling) = calculateCohesionAndCoupling(atPath: filePath)
        let cc = calculateCyclomaticComplexity(atPath: filePath)

        // Условные значения для классификации тестируемости кода
        let miThresholds = (excellent: 85.0, good: 65.0)
        let cohesionThresholds = (excellent: 80, good: 50)
        let couplingThresholds = (excellent: 20, good: 50)
        let ccThresholds = (excellent: 10, good: 20)
        
        print("The Maintainability Index is equal to: \(mi)")
        print("The cohesion is equal to: \(cohesion)")
        print("The coupling is equal to: \(coupling)")
        print("The cyclomatic complexity is equal to: \(cc)")
        
        if mi >= miThresholds.excellent && Int(cohesion) >= cohesionThresholds.excellent && Int(coupling) <= couplingThresholds.excellent && cc <= ccThresholds.excellent {
            return .excellentlyTestable
        } else if mi >= miThresholds.good && Int(cohesion) >= cohesionThresholds.good && Int(coupling) <= couplingThresholds.good && cc <= ccThresholds.good {
            return .wellTestable
        } else {
            return .poorlyTestable
        }
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
