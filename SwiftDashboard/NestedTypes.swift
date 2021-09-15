//
//  NestedTypes.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 25/08/21.
//

import Foundation

//MARK:- Nested Types

/// Enumerations are often created to support a specific class or structure’s functionality.

/// Similarly, it can be convenient to define utility classes and structures purely for use within the context of a more complex type.

/// To accomplish this, Swift enables you to define nested types, whereby you nest supporting enumerations, classes, and structures within the definition of the type they support.

/// Types can be nested to as many levels as are required.

//MARK:- Nested Types in Action

struct BlackjackCard {
    
    //nested suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    //nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"

//MARK:- Referring to Nested Types

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
