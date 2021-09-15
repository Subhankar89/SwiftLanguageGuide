//
//  Generics.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 08/05/21.
//

import Foundation

//MARK:- Generics

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop(_ item: Element) {
        items.removeLast()
    }
}

//Extending a Generic Type

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//Type Constraints Syntax

func findIndex<T: Equatable>(of findValue: T, in arra:[T]) -> Int? {
    
}

//Associated Types

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Extending an Existing Type to Specify an Associated Type

extension Array: Container {}

//Adding Constraints to an Associated Type

protocol Container1 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Using a Protocol in Its Associated Type’s Constraints

protocol SuffixableContainer: Container1 {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}


extension Stack: SuffixableContainer {
  
    
    func suffix(_ size: Int) -> Stack {
        <#function body#>
    }
}

//Generic Where Clauses

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherConatiner: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable{
    
}

//Extensions with a Generic Where Clause

extension Stack where Element: Equatable {
    
}

//Associated Types with a Generic Where Clause

protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}


protocol ComparableContainer: Container3 where Item: Comparable { }


