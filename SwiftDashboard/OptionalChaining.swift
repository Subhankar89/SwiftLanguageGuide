//
//  OptionalChaining.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 23/08/21.
//

import Foundation

//MARK:- Optional Chaining

/// Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.

/// Optional Chaining as an Alternative to Forced Unwrapping

/// The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.

/// To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value.

class Person {
    var residence: ImprovedResidence?
}

class Residence {
    var numberOfRooms = 1
}

let subhankar = Person()

if let roomCount = subhankar.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

//subhankar.residence = Residence()

if let roomCount = subhankar.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."

//MARK:- Defining Model Classes for Optional Chaining

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class ImprovedResidence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//MARK:- Accessing Properties Through Optional Chaining

let shiwali = Person()
if let roomCount = shiwali.residence?.numberOfRooms {
    print("Shiwali's residence has \(roomCount) rooms(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

// Prints "Unable to retrieve the number of rooms."

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
shiwali.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}
shiwali.residence?.address = createAddress()

//MARK:- Calling Methods Through Optional Chaining

func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}

if (shiwali.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."
