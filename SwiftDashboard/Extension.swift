//
//  Extension.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 26/08/21.
//

import Foundation

//MARK:- Extensions

/// Extensions add new functionality to an existing class, structure, enumeration, or protocol type.

/// This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling).

//MARK:- NOTE:-
///Extensions can add new functionality to a type, but they can’t override existing functionality.

/// An extension can extend an existing type to make it adopt one or more protocols.

//MARK:- NOTE:-

/// If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.

//MARK:- Computed Properties

/// Extensions can add computed instance properties and computed type properties to existing types.

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

//MARK:- NOTE:-
/// Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.

//MARK:- Initializers

/// Extensions can add new initializers to existing types

/// This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.

/// Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.

/// If you use an extension to add an initializer to a structure that was declared in another module, the new initializer can’t access self until it calls an initializer from the defining module.

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

//MARK:-

/// Extensions can add new instance methods and type methods to existing types.

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello")
}
// Hello!
// Hello!
// Hello!

/// Mutating Instance Methods

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
//someInt is now 9

//MARK:- Subscripts

/// Extensions can add new subscripts to an existing type.

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7
746381295[9]
// returns 0, as if you had requested:
0746381295[9]

//MARK:- Nested Types

/// Extensions can add new nested types to existing classes, structures, and enumerations

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return.zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "
