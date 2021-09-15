//
//  Functions.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 04/06/21.
//

import Foundation

//Defining and Calling Functions

func greet(person: String) -> String {
    let greeting = "Hello," + person + "!"
    return greeting
}

print(greet(person: "Anna"))
// Prints "Hello, Anna!"
print(greet(person: "Brian"))
// Prints "Hello, Brian!"

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"


//MARK:- Function Parameters and Return Values

//Functions Without Parameters

func sayHelloWorld() -> String {
    return "hello, world"
}

print(sayHelloWorld())

// Functions With Functions With Multiple Parameters

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"

//Functions Without Return Values

func greetMe(person: String) {
    print("Hello, \(person)!")
}
greetMe(person: "Dave")
// Prints "Hello, Dave!"

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value

//Functions with Multiple Return Values

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMax, currentMin)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

//Optional Tuple Return Types

func minMaxOptional(array: [Int]) -> (min: Int, max: Int)? {
    var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
    return (currentMax, currentMin)
}

if  let boundsOptional = minMaxOptional(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(boundsOptional.min) and max is \(boundsOptional.max)")
}

//Functions With an Implicit Return

func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// Prints "Hello, Dave!"

//MARK:- Function Argument Labels and Parameter Names

//Specifying Argument Label

func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."

//Default Parameter Values

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12

//Place parameters that don’t have default values at the beginning of a function’s parameter list, before the parameters that have default values. Parameters that don’t have default values are usually more important to the function’s meaning—writing them first makes it easier to recognize that the same function is being called, regardless of whether any default parameters are omitted.

//Variadic Parameters

//A variadic parameter accepts zero or more values of a specified type.

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers


//In-Out Parameters

//If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.

//NOTE:- In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

//MARK:- Function Types

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return  a + b
}

// A function that has two parameters, both of type Int, and that returns a value of type Int.

//Using funtion Types

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

//Function Types as Prameter Types

func printMathRsult(_ mathfunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathfunction(a,b))")
}

printMathRsult(addTwoInts, 3, 5)
// Prints "Result: 8"

//Function Types as Return Types

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentvalue = 3
let moveNearerToZero = chooseStepFunction(backward: currentvalue > 0)
// moveNearerToZero now refers to the stepBackward() function

print("Counting to zero:")
//Counting to zero:

while currentvalue != 0 {
    print("\(currentvalue)... ")
    currentvalue = moveNearerToZero(currentvalue)
}

print("Zero!")
// 3...
// 2...
// 1...
// zero!

//MARK:- Nested Functions

func chooseStepFunctionNested(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZeroNested = chooseStepFunctionNested(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZeroNested(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!



