//
//  File.swift
//  
//
//  Created by jinxiangqiu on 18/3/2020.
//

import Foundation

public struct TerminalString {
    
    let strings: [(String, Style)]
    
    init(strings: [(String, Style)]) {
        self.strings = strings
    }
    
    public init() {
        self.strings = []
    }
        
    public var string: String {
        strings.map { $0.0 }.joined()
    }
}

extension TerminalString: CustomStringConvertible {
    
    public var description: String {
        strings.map {
            switch TerminalSupportedColor.current {
            case .none:
                return $0.0
            default:
                var openCodes: [String] = []
                var closeCodes: [String] = []
                if let modifiers = $0.1.modifiers {
                    openCodes.append(contentsOf: modifiers.map { $0.openCode } )
                    closeCodes.append(contentsOf: modifiers.map { $0.closeCode } )
                }
                if let color = $0.1.fgColor {
                    openCodes.append(color.fgOpenCode)
                    closeCodes.append(color.fgCloseCode)
                }
                if let color = $0.1.bgColor {
                    openCodes.append(color.bgOpenCode)
                    closeCodes.append(color.bgCloseCode)
                }
                return openCodes.joined() + $0.0 + closeCodes.joined()
            }
        }
        .joined()
    }
}

public func + (a: TerminalString, b: TerminalString) -> TerminalString {
    TerminalString(strings: a.strings + b.strings)
}

public func + (a: TerminalString, b: String) -> TerminalString {
    a + b.terminalString
}

public func + (a: String, b: TerminalString) -> TerminalString {
    a.terminalString + b
}