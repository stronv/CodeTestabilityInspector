//
//  CohesionCouplingAnalyzer.swift
//  CodeTestabilityInspector
//
//  Created by Artyom Tabachenko on 21.05.2024.
//

import Foundation
import SwiftSyntax
import SwiftParser

class CohesionCouplingAnalyzer: SyntaxVisitor {
    private var methodFieldUsage: [String: Set<String>] = [:]
    private var classDependencies: Set<String> = []
    private var currentFunction: String?

    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        let className = node.name.text
        print("Analyzing class: \(className)")
        return .visitChildren
    }

    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        currentFunction = node.name.text
        methodFieldUsage[currentFunction!] = []
        return .visitChildren
    }

    override func visitPost(_ node: FunctionDeclSyntax) {
        currentFunction = nil
    }

    override func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
        if let currentMethod = currentFunction {
            let fieldName = node.declName.baseName.text
            methodFieldUsage[currentMethod]?.insert(fieldName)
        }
        return .visitChildren
    }

    override func visit(_ node: IdentifierTypeSyntax) -> SyntaxVisitorContinueKind {
        let typeName = node.name.text
        classDependencies.insert(typeName)
        return .visitChildren
    }

    private func analyzeCohesion() -> Double {
        var totalFieldAccesses = 0
        var totalMethods = 0
        for (_, fields) in methodFieldUsage {
            totalFieldAccesses += fields.count
            totalMethods += 1
        }
        return totalMethods > 0 ? Double(totalFieldAccesses) / Double(totalMethods) : 0
    }

    private func analyzeCoupling() -> Int {
        return classDependencies.count
    }
}

extension CohesionCouplingAnalyzer {
    func analyzeFile(atPath filePath: String) {
        do {
            let sourceFile = Parser.parse(source: filePath)
            let analyzer = CohesionCouplingAnalyzer(viewMode: .all)
            analyzer.walk(sourceFile)
            
            let cohesion = analyzer.analyzeCohesion()
            let coupling = analyzer.analyzeCoupling()
            
            print("Cohesion: \(cohesion)")
            print("Coupling: \(coupling)")
        }
    }
}
