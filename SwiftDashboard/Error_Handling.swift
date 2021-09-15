//
//  Error_Handling.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 24/08/21.
//

import Foundation

//MARK:- Error Handling

/// Error handling in Swift interoperates with error handling patterns that use the NSError class in Cocoa and Objective-C.

//MARK:- Representing and Throwing Errors

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//MARK:- Handling Errors

/// 4 ways to handle Error in Swift.
    /// 1. You can propagate the error from a function to the code that calls that function
    /// 2.  handle the error using a do-catch statement
    /// 3.  handle the error as an optional value
    /// 4.  assert that the error will not occur

/// Propagating Errors Using Throwing Functions (A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.)

//func canThrowErrors() throws -> String
//
//func cannotThrowErrors() -> String

/// NOTE:- Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    /// Throwing initializers can propagate errors in the same way as throwing functions
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/// Handling Errors Using Do-Catch

/// You use a do-catch statement to handle errors by running a block of code.

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock {
    print("Out of Stock")
}catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."


/// In a nonthrowing function, an enclosing do-catch statement must handle the error. In a throwing function, either an enclosing do-catch statement or the caller must handle the error. If the error propagates to the top-level scope without being handled, you’ll get a runtime error.

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

//call site of nourish
do {
    try nourish(with: "Beet-Flavoured Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}

// Prints "Couldn't buy that from the vending machine."

func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

/// Converting Errors to Optional Values

func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction()

let y: Int?

do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk () {
        return data
    }
    if let data = try? fetchDataFromServer() {
        return data
    }
    return nil
}

/// Disabling Error Propagation

/// Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime.

let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")


//MARK:- Specifying Cleanup Actions

/// You use a defer statement to execute a set of statements just before code execution leaves the current block of code.

/// This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break.

/// A defer statement defers execution until the current scope is exited.

/// Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.

func processFile(fileName: String) throws {
    if exists(fileName) {
        let file = open(fileName)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file
        }
        //close(file) is called here, at the end of the scope.
    }
}
