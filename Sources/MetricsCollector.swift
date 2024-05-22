//
//  MetricsCollector.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 21.05.2024.
//

import Foundation
import SwiftSyntax
import SwiftParser

class MetricsCollector: SyntaxVisitor {
    private var loc = 0
    private var cyclomaticComplexity = 1
    private var comments = 0
    
    private var operators: [String: Int] = [:]
    private var operands: [String: Int] = [:]
    
    override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
        loc += node.statements.count
        return .visitChildren
    }
    
    override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
        cyclomaticComplexity += 1
        countOperator("if")
        return .visitChildren
    }
    
    override func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
        cyclomaticComplexity += 1
        countOperator("while")
        return .visitChildren
    }
    
    override func visit(_ node: ForStmtSyntax) -> SyntaxVisitorContinueKind {
        cyclomaticComplexity += 1
        countOperator("for")
        return .visitChildren
    }
    
    override func visit(_ node: SwitchExprSyntax) -> SyntaxVisitorContinueKind {
        cyclomaticComplexity += 1
        countOperator("switch")
        return .visitChildren
    }
    
    override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
        switch token.tokenKind {
        case .stringQuote:
            comments += 1
        case .binaryOperator(let op), .prefixOperator(let op), .postfixOperator(let op):
            countOperator(op)
        case .identifier(let id):
            countOperand(id)
        default:
            break
        }
        return .visitChildren
    }
    
    private func countOperator(_ op: String) {
        if let count = operators[op] {
            operators[op] = count + 1
        } else {
            operators[op] = 1
        }
    }
    
    private func countOperand(_ operand: String) {
        if let count = operands[operand] {
            operands[operand] = count + 1
        } else {
            operands[operand] = 1
        }
    }
    
    private func calculateHalsteadVolume() -> Double {
        let n1 = operators.keys.count
        let n2 = operands.keys.count
        let N1 = operators.values.reduce(0, +)
        let N2 = operands.values.reduce(0, +)
        
        let vocabulary = n1 + n2
        let length = N1 + N2
        
        return Double(length) * log2(Double(vocabulary))
    }
}

extension MetricsCollector {
    func analyzeFile(atPath filePath: String) -> Double {
        do {
            let sourceFile = Parser.parse(source: filePath)
            let metricsCollector = MetricsCollector(viewMode: .all)
            metricsCollector.walk(sourceFile)

            let loc = metricsCollector.loc
            let cc = metricsCollector.cyclomaticComplexity
            let comments = metricsCollector.comments
            let halsteadVolume = metricsCollector.calculateHalsteadVolume()
            let commentPercentage = Double(comments) / Double(loc) * 100

            let mi = 171 - 5.2 * log(halsteadVolume) - 0.23 * Double(cc) - 16.2 * log(Double(loc)) + 50 * sin(sqrt(2.4 * commentPercentage))

            print("Maintainability Index: \(mi)")
            return mi
        } 
    }
}
