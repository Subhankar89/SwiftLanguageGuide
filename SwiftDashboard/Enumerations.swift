//
//  Enumerations.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 30/06/21.
//

import Foundation

//MARK: Enumerations

//enumeration cases can specify associated values of any type to be stored along with each different case value

// Enumerations in Swift are first-class types in their own right.

//They adopt many features traditionally supported only by classes, such as:
    //1. computed properties to provide additional information about the enumeration’s current value, and
    //2. instance methods to provide functionality related to the values the enumeration represents.

//can also define initializers to provide an initial case value
//can be extended to expand their functionality beyond their original implementation
//can conform to protocols to provide standard functionality

// Enumeration Syntax

enum SomeEnumeration {
    //enumeration deficnition goes in here
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

//Note:- Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C. In the CompassPoint example above, north, south, east and west don’t implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are values in their own right, with an explicitly defined type of CompassPoint.

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.east

directionToHead = .east

//MARK:- Matching Enumeration Values with a Switch Statement

directionToHead = .south

switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguines")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

//a switch statement must be exhaustive when considering an enumeration’s cases. If the case for .west is omitted, this code doesn’t compile, because it doesn’t consider the complete list of CompassPoint cases

let somePlanet = Planet.earth

switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}


//MARK:- Iterating over Enumeration Cases

//Swift exposes a collection of all the cases as an allCases property of the enumeration type.

enum Beverages: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverages.allCases.count

print("\(numberOfChoices) bverages available")

for beverage in Beverages.allCases {
    print(beverage)
}

//MARK:- Associated Values

//it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an associated value, and it varies each time you use that case as a value in your code.

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarCode = Barcode.upc(8, 85909, 51226, 3)
productBarCode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC:\(numberSystem), \(manufacturer), \(product), \(check))")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

//If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single var or let annotation before the case name, for brevity

switch productBarCode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

//MARK:- Raw Values

//As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//NOTE:- Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.

//Implicitly Assigned Raw Values

enum Planets: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoints: String {
    case north, south, east, west
}

let earthsOrder = Planets.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoints.west.rawValue
// sunsetDirection is "west"

//MARK:- Initializing from a Raw Value

//If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil.

let possiblePlanet = Planets(rawValue: 7)

//possiblePlanet is of type Planet? and equals Planet.uranus

let positionToFind = 11
if let somePlanet = Planets(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"

//MARK:- Recursive Enumerations

//A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.

enum ArithmaticExpression {
    case number(Int)
    indirect case addition(ArithmaticExpression, ArithmaticExpression)
    indirect case multiplication (ArithmaticExpression, ArithmaticExpression)
}

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//these associated values make it possible to nest expressions.
//(5 + 4) * 2:

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//A recursive function is a straightforward way to work with data that has a recursive structure.

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"
