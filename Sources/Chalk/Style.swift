//
//  TerminalString.swift
//  Chalk
//
//  Created by Quentin Jin on 2018/10/19.
//

import Foundation

public let chalk = Style()
public let ck = Style()

public struct Style {

    public var fgColor: TerminalColor?

    public var bgColor: TerminalColor?

    public var modifiers: Set<Modifier>?
}

extension Style {
    
    public func on(_ strings: String...) -> String {
        switch TerminalSupportedColor.current {
        case .none:
            return strings.joined()
        default:
            return strings.map {
                var codes = ""
                var closeCodes = ""
                if let modifiers = modifiers {
                    codes.append(modifiers.map({ $0.openCode }).joined())
                    closeCodes.append(modifiers.map({ $0.closeCode }).joined())
                }

                var string = $0
                if let fg = fgColor {
                    codes.append(fg.fgOpenCode)
                    string.replacingOccurrences(of: fg.fgCloseCode, with: fg.fgOpenCode)
                    closeCodes.append(fg.fgCloseCode)
                }
                if let bg = bgColor {
                    codes.append(bg.bgOpenCode)
                    string.replacingOccurrences(of: bg.bgCloseCode, with: bg.bgOpenCode)
                    closeCodes.append(bg.bgCloseCode)
                }
                return codes + string + closeCodes
            }.joined()
        }
    }
}

extension Style {

    public func fg(_ color: RainbowColor) -> Style {
        var style = self
        style.fgColor = color
        return style
    }

    public func bg(_ color: RainbowColor) -> Style {
        var style = self
        style.bgColor = color
        return style
    }
}

extension Style {

    private func modify(_ modifier: Modifier) -> Style {
        var style = self
        if style.modifiers == nil {
            style.modifiers = [modifier]
        } else {
            style.modifiers!.insert(modifier)
        }
        return style
    }
    
    public var reset: Style {
        return modify(.reset)
    }
    
    public var bold: Style {
        return modify(.bold)
    }
    
    public var faint: Style {
        return modify(.faint)
    }
    
    public var dim: Style {                 // faint
        return faint
    }
    
    public var italic: Style {
        return modify(.italic)
    }
    
    public var underline: Style {
        return modify(.underline)
    }
    
    public var reverse: Style {
        return modify(.reverse)
    }
    
    public var conceal: Style {
        return modify(.conceal)
    }
    
    public var hidden: Style {              // conceal
        return conceal
    }
    
    public var crossedOut: Style {
        return modify(.crossedOut)
    }
    
    public var strikethrough: Style {       // crossedOut
        return crossedOut
    }
}

extension Style {

    private func fg(ansi16: ANSI16Color) -> Style {
        var style = self
        style.fgColor = ansi16
        return style
    }

    private func bg(ansi16: ANSI16Color) -> Style {
        var style = self
        style.bgColor = ansi16
        return style
    }
    
    public var black: Style {
        return fg(ansi16: .black)
    }
    
    public var red: Style {
        return fg(ansi16: .red)
    }
    
    public var green: Style {
        return fg(ansi16: .green)
    }
    
    public var yellow: Style {
        return fg(ansi16: .yellow)
    }
    
    public var blue: Style {
        return fg(ansi16: .blue)
    }
    
    public var magenta: Style {
        return fg(ansi16: .magenta)
    }
    
    public var cyan: Style {
        return fg(ansi16: .cyan)
    }
    
    public var white: Style {
        return fg(ansi16: .white)
    }
    
    public var blackBright: Style {
        return fg(ansi16: .blackBright)
    }
    
    public var redBright: Style {
        return fg(ansi16: .redBright)
    }
    
    public var greenBright: Style {
        return fg(ansi16: .greenBright)
    }
    
    public var yellowBright: Style {
        return fg(ansi16: .yellowBright)
    }
    
    public var blueBright: Style {
        return fg(ansi16: .blueBright)
    }
    
    public var magentaBright: Style {
        return fg(ansi16: .magentaBright)
    }
    
    public var cyanBright: Style {
        return fg(ansi16: .cyanBright)
    }
    
    public var whiteBright: Style {
        return fg(ansi16: .whiteBright)
    }
    
    public var gray: Style {
        return blackBright
    }
    
    public var bgBlack: Style {
        return bg(ansi16: .black)
    }
    
    public var bgRed: Style {
        return bg(ansi16: .red)
    }
    
    public var bgGreen: Style {
        return bg(ansi16: .green)
    }
    
    public var bgYellow: Style {
        return bg(ansi16: .yellow)
    }
    
    public var bgBlue: Style {
        return bg(ansi16: .blue)
    }
    
    public var bgMagenta: Style {
        return bg(ansi16: .magenta)
    }
    
    public var bgCyan: Style {
        return bg(ansi16: .cyan)
    }
    
    public var bgWhite: Style {
        return bg(ansi16: .white)
    }
    
    public var bgBlackBright: Style {
        return bg(ansi16: .blackBright)
    }
    
    public var bgRedBright: Style {
        return bg(ansi16: .redBright)
    }
    
    public var bgGreenBright: Style {
        return bg(ansi16: .greenBright)
    }
    
    public var bgYellowBright: Style {
        return bg(ansi16: .yellowBright)
    }
    
    public var bgBlueBright: Style {
        return bg(ansi16: .blueBright)
    }
    
    public var bgMagentaBright: Style {
        return bg(ansi16: .magentaBright)
    }
    
    public var bgCyanBright: Style {
        return bg(ansi16: .cyanBright)
    }
    
    public var bgWhiteBright: Style {
        return bg(ansi16: .whiteBright)
    }
    
    public var bgGray: Style {
        return bgBlackBright
    }
}
