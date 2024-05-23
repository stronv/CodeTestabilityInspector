//
//  CyclomaticComplexityVisitor.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 18.05.2024.
//

import Foundation
import SwiftSyntax
import SwiftParser

class CyclomaticComplexityVisitor: SyntaxVisitor {
    
    var complexity = 1
    
    override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: ForStmtSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: SwitchExprSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: RepeatStmtSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
        complexity += 1
        return .visitChildren
    }
    
    override func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
    }
    
    override func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
        return .visitChildren
    }
}

extension CyclomaticComplexityVisitor {
    func calculateCyclomaticComplexity(atPath filePath: String) -> Int {
       do {
           let sourceFile = Parser.parse(source: filePath)
           let visitor = CyclomaticComplexityVisitor(viewMode: .all)
           visitor.walk(sourceFile)
           return visitor.complexity
       }
   }
}
