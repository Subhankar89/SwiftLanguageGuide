//
//  Methods.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 15/07/21.
//

import Foundation

//MARK:- Methods

// Methods are functions that are associated with a particular type.

// The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C.

//  In Objective-C, classes are the only types that can define methods.

// Instance Methods

// Instance methods are functions that belong to instances of a particular class, structure, or enumeration.

class Counter {
    
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset () {
        count = 0
    }
}

let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0

// The Self Property

// You use the self property to refer to the current instance within its own instance methods.

struct Point {
    var x = 0.0, y = 0.0
    
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// Prints "This point is to the right of the line where x == 1.0"

// Modifying Value Types from Within Instance Methods

struct Points {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoints = Points(x: 1.0, y: 1.0)
//Instead of returning a new point, this method actually modifies the point on which it’s called.
somePoints.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"

let fixedPoints = Points(x: 3.0, y: 3.0)
//fixedPoints.moveBy(x: 2.0, y: 3.0)
// this will report an error

//Assigning to self Within a Mutating Method

// Mutating methods can assign an entirely new instance to the implicit self property.

struct Pointd {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Pointd(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

//MARK:- Type Methods

// Instance methods, as described above, are methods that you call on an instance of a particular type.

// You can also define methods that are called on the type itself. These kinds of methods are called type methods.

// Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.

// Note: - In Objective-C, you can define type-level methods only for Objective-C classes. In Swift, you can define type-level methods for all classes, structures, and enumerations. Each type method is explicitly scoped to the type it supports.

class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unLock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unLock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

// (The Boolean return value of advance(to:) is ignored, because the level is known to have been unlocked by the call to LevelTracker.unlock(_:) on the previous line.)

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
// Prints "level 6 hasn't yet been unlocked"
