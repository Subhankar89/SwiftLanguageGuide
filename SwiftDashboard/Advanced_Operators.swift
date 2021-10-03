//
//  Advanced_Operators.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 03/10/21.
//

import Foundation

//MARK:- Advanced Operators

/// Unlike arithmetic operators in C, arithmetic operators in Swift don’t overflow by default. Overflow behavior is trapped and reported as an error. To opt in to overflow behavior, use Swift’s second set of arithmetic operators that overflow by default, such as the overflow addition operator (&+). All of these overflow operators begin with an ampersand (&).

//MARK:- Bitwise Operators

/// Bitwise operators enable you to manipulate the individual raw data bits within a data structure.

/// 1. often used in low-level programming, such as graphics programming and device driver creation.

/// Bitwise NOT Operator
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  // equals 11110000

/// Bitwise AND Operator

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

/// Bitwise OR Operator

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110

/// BItwise XOR Operator

/// The operator returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bits are the same

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001

/// Bitwise Left and Right Shift Operators

/// Bitwise left and right shifts have the effect of multiplying or dividing an integer by a factor of two.

/// Shifting an integer’s bits to the left by one position doubles its value, whereas shifting it to the right by one position halves its value.

/// Shifting Behavior for Unsigned Integers

/// This approach is known as a logical shift.

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153

//MARK:- Overflow Operators

///Swift provides three arithmetic overflow operators that opt in to the overflow behavior for integer calculations. These operators all begin with an ampersand (&):

/// Value Overflow
/// Numbers can overflow in both the positive and negative direction.

/// +ve overflow
var unsignedOverflowMax = UInt8.max
// unsignedOverflow equals 255, which is the maximum value a UInt8 can hold
unsignedOverflowMax = unsignedOverflowMax &+ 1
// unsignedOverflow is now equal to 0

/// -ve overflow

var unsignedOverflowMin = UInt8.min
// unsignedOverflow equals 0, which is the minimum value a UInt8 can hold
unsignedOverflowMin = unsignedOverflowMin &- 1
// unsignedOverflow is now equal to 255

var signedOverflow = Int8.min
// signedOverflow equals -128, which is the minimum value an Int8 can hold
signedOverflow = signedOverflow &- 1
// signedOverflow is now equal to 127

/// For both signed and unsigned integers, overflow in the positive direction wraps around from the maximum valid integer value back to the minimum, and overflow in the negative direction wraps around from the minimum value to the maximum.

//MARK:- Precedence and Associativity

///Operator precedence gives some operators higher priority than others; these operators are applied first.

//MARK:- Operator Methods

/// Classes and structures can provide their own implementations of existing operators. This is known as overloading the existing operators.
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.x + right.y)
    }
}

/// Because addition isn’t part of the essential behavior for a vector, the type method is defined in an extension of Vector2D rather than in the main structure declaration of Vector2D.

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector is a Vector2D instance with values of (5.0, 5.0)

// Prefix and Postfix Operators

extension Vector2D {
    static prefix func -(vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)

let negative = -positive
// negative is a Vector2D instance with values of (-3.0, -4.0)

let alsoPositive = -negative
// alsoPositive is a Vector2D instance with values of (3.0, 4.0)

/// Compounding Assignment Operators

/// Compound assignment operators combine assignment (=) with another operation.

/// You mark a compound assignment operator’s left input parameter type as inout, because the parameter’s value will be modified directly from within the operator method.


extension Vector2D {
    static func +=(left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original now has values of (4.0, 6.0)
print(original)
/// NOTE:- It isn’t possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) can’t be overloaded.

/// Equivalence Operators

/// By default, custom classes and structures don’t have an implementation of the equivalence operators, known as the equal to operator (==) and not equal to operator (!=).


/// You usually implement the == operator, and use the standard library’s default implementation of the != operator that negates the result of the == operator.

extension Vector2D: Equatable {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// Prints "These two vectors are equivalent."

//MARK:- Custom Operators
