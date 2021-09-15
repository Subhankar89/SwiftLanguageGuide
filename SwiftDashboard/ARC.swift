//
//  ARC.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 15/05/21.
//

import Foundation

/*
//MARK:- weak reference
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    var apartmet: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {self.unit = unit}
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "Jhon")
unit4A = Apartment(unit: "4A")

john!.apartmet = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

print("All deinitialized")

//MARK:- unowned reference

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {self.name = name }
    deinit {
        print("\(name) is deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var jhon: Customer?
jhon = Customer(name: "Subhankar")
jhon!.card = CreditCard(number: 1234_5678_9012_3456, customer: jhon!)
//print("initialized")
jhon = nil
print("deinitialized")

//MARK:- Unowned Optional References

//1. In terms of the ARC ownership model, an unowned optional reference and a weak reference can both be used in the same contexts.
//2. The difference is that when you use an unowned optional reference, you’re responsible for making sure it always refers to a valid object or is set to nil.

class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]



//MARK:- Unowned References and Implicitly Unwrapped Optional Properties

//1. Two Phase Initialization
//2. Implicitly unwarapped Optionals

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "India", capitalName: "Delhi")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

//MARK:- Strong Reference Cycles for Closures

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p",text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

//MARK:- Resolving Strong Reference Cycles for Closures

//1. A capture list defines the rules to use when capturing one or more reference types within the closure’s body.
/*
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String  in
    //closure body
}*/

//2. Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.

//3. Define a capture as a weak reference when the captured reference may become nil at some point in the future.
*/
