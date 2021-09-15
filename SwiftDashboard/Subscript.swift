//
//  Subscript.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 21/07/21.
//

import Foundation

//MARK:- Subscripts

// Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence.

// You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval.

// Subscript Syntax

// Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name.
struct TimesTable {
    
    let multiplier: Int
    subscript(index: Int) -> Int {
       return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"

//Subscript Usage

// Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence.


var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


// Subscript Options

// Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return a value of any type.

// However, unlike functions, subscripts can’t use in-out parameters.

// subscript overloading.

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * column) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}


var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// Type Subscripts

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
