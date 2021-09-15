//
//  Classes&Structures.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 04/07/21.
//

import Foundation

//MARK:- Structures and Classes

//Comparing Structure and Classes

    //1. Both properties to store values
    //2. Define methods to provide functionality
    //3. Define subscripts to provide access to their values using subscript syntax
    //4. Define initializeers to setup their intial state
    //5. Be extended to expand their functionality beyonf a default implementation
    //6. Conformm to protocols to provide standard functionality of a certain kind

//Additional Capabilitites of Classes

    //1. Inheritance enables characteristics of one class to inherit capabilities of another
    //2. Type casting enables you to check and interpret the type of a class instance at runtime
    //3, Deinitializeers enable an instance of a class o free up any resources it has assigned
    //4. Reference counting allows more than one reference to a class instance

//Definition Syntax

struct SomeStructure {
    //struct def goes inside
}

class SomeClass {
    //class definition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


//Structure and Classes Instances

let someResolution = Resolution()
let someVideoMode = VideoMode()

//Accessing Properties

print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"


//Memberwise Initializers for Structure types

let vga = Resolution(width: 640, height: 480)

//MARK:- Structures and Enumerations Are Value Types

// A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

//Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.


// Because Resolution is a structure, a copy of the existing instance is made, and this new copy is assigned to cinema.
//Even though hd and cinema now have the same width and height, they’re two completely different instances behind the scenes.
let hd = Resolution(width: 1290, height: 1080)
var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"


enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"

//MARK:- Classes are Reference Types

// Unlike value types, reference types are not copied when they’re assigned to a variable or constant, or when they’re passed to a function.

// Rather than a copy, a reference to the same existing instance is used.

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"


//Identity Operators

//It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:

//Identical to (===)
//Not identical to (!==)

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

//Pointers

//A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but isn’t a direct pointer to an address in memory, and doesn’t require you to write an asterisk (*) to indicate that you are creating a reference.

// Instead, these references are defined like any other constant or variable in Swift.

//The standard library provides pointer and buffer types that you can use if you need to interact with pointers directly
