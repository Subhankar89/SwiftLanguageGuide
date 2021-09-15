//
//  Memory_Safety.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 14/09/21.
//

import Foundation

//MARK:- Memory Safety

//MARK:- Understanding Conflicting Access to Memory

// Access to memory happens in your code when you do things like set the value of a variable or pass an argument to a function.

// A write access to the memory where one is stored.
var one = 1

// A read access from the memory where one is stored.
print("We're number \(one)!")

//MARK:- Characteristics of Memory Access

/// There are three characteristics of memory access to consider in the context of conflicting access:

/// 1. whether the access is a read or a write, the duration of the access,

/// 2. location in memory being accessed

/// 3. duration of the access

/// Specifically, a conflict occurs if you have two accesses that meet all of the following conditions:

/// 1. At least one is a write access or a nonatomic access.

/// 2. They access the same location in memory.

/// 3. Their durations overlap.

/// An operation is atomic if it uses only C atomic operations; otherwise it’s nonatomic.

/// An access is instantaneous if it’s not possible for other code to run after that access starts but before it ends. By their nature, two instantaneous accesses can’t happen at the same time.

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// Prints "2"

/// Overlapping accesses appear primarily in code that uses in-out parameters in functions and methods or mutating methods of a structure.

//MARK:- Conflicting Access to In-Out Parameters

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

increment(&stepSize)
// Error: conflicting accesses to stepSize

// One way to solve this is to make explicit copy

// Make an explicit copy.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// Update the original.
stepSize = copyOfStepSize
// stepSize is now 2

/// Another consequence of long-term write access to in-out parameters is that passing a single variable as the argument for multiple in-out parameters of the same function produces a conflict.

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30

balance(&playerOneScore, &playerTwoScore) // OK
balance(&playerOneScore, &playerOneScore) // Error: conflicting accesses to playerOneScore

// MARK:- Conflicting Access to self in Methods

/// A mutating method on a structure has write access to self for the duration of the method call.

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func sharehealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)

oscar.sharehealth(with: &maria) //OK


//MARK:- Conflicting Access to Properties
