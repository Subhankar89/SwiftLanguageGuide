//
//  Closures.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 25/06/21.
//

import Foundation

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

//MARK- Closure Expression Syntax

//    { (statements) -> return type in
//    statements
//}

// The parameters in closure expression can be in-out parameters, but they can't have a default value.
// Tuples can also be used as parameter types and return types.

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//The start of the closure’s body is introduced by the in keyword. This keyword indicates that the definition of the closure’s parameters and return type has finished, and the body of the closure is about to begin.

//Inferring Type From Context

reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})

//Implicit Retursn from Single - Expression Closures

reversedNames = names.sorted(by: {s1 , s2 in s1 > s2})

//Shorthand Argument Names

reversedNames = names.sorted(by: {$0 > $1})

//Operator Methods

reversedNames = names.sorted(by: >)

//MARK:- Trailing Closures

//If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead

func someFunctionThatTakesAClosure(closure: () -> Void) {
    //function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

reversedNames = names.sorted() { $0 > $1 }

reversedNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

//MARK:- Capturing Values

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()


//MARK:- Escaping Closures

//A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()

instance.doSomething()
print(instance.x) //prints "200"

completionHandlers.first?()

print(instance.x)


class SomeOtherClass {
    
    var x = 10
    func doSomething () {
        someFunctionWithEscapingClosure {
            [self] in
            x = 100
            someFunctionWithNonescapingClosure {
                x = 200
            }
        }
    }
}

//If self is an instance of a structure or an enumeration, you can always refer to self implicitly.

//However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration.

//Structures and enumerations don’t allow shared mutability


struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

//The call to the someFunctionWithEscapingClosure function in the example above is an error because it’s inside a mutating method, so self is mutable.

//The call to the someFunctionWithEscapingClosure function in the example above is an error because it’s inside a mutating method, so self is mutable. That violates the rule that escaping closures can’t capture a mutable reference to self for structures.

//MARK:- AutoClosures

// An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function.

//It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it.

//An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure.

var customersInLine = ["Chris", "Alex", "Papun", "Rikun"]

print(customersInLine.count)
// Prints "5"

let customerProvider = {
    customersInLine.remove(at: 0)
    print(customersInLine.count) // Prints 5
}

print("Now serving \(customerProvider())!")
//Prints "Now serving Chris!"

print(customersInLine.count)
// Prints "4"

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"


//The serve(customer:) function in the listing above takes an explicit closure that returns a customer’s name. The version of serve(customer:) below performs the same operation but, instead of taking an explicit closure, it takes an autoclosure by marking its parameter’s type with the @autoclosure attribute.

//Now you can call the function as if it took a String argument instead of a closure.

// The argument is automatically converted to a closure, because the customerProvider parameter’s type is marked with the @autoclosure attribute.

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"
