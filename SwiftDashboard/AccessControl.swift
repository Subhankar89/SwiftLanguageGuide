//
//  AccessControl.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 18/05/21.
//

import Foundation

//MARK:- Custom Types

//1.A public type defaults to having internal members, not public members. If you want a type member to be public, you must explicitly mark it as such.

public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

//MARK:- Tuple Types

//1. The access level for a tuple type is the most restrictive access level of all types used in that tuple.

//NOTE:- Tuple types don’t have a standalone definition in the way that classes, structures, enumerations, and functions do. A tuple type’s access level is determined automatically from the types that make up the tuple type, and can’t be specified explicitly.

//MARK:- Function Types

//1. The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type.

//One of these classes is defined as internal, and the other is defined as private. Therefore, the overall access level of the compound tuple type is private (the minimum access level of the tuple’s constituent types).
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return ()
    // function implementation goes here
}

//MARK:- Enumeration types

//1. The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to.

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

//2. The types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration’s access level. For example, you can’t use a private type as the raw-value type of an enumeration with an internal access level.

//MARK:- Subclassing

//An override can make an inherited class member more accessible than its superclass version.
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}

//It’s even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member, as long as the call to the superclass’s member takes place within an allowed access level context
public class A1 {
    fileprivate func someMethod() {}
}

internal class B1: A1 {
    override internal func someMethod() {
        super.someMethod()
    }
}

//MARK:- Constants, Variables, Properties, and Subscripts

//A constant, variable, or property can’t be more public than its type.

private var privateInstance = SomePrivateClass()

//You can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript.
//Note:- This rule applies to stored properties as well as computed properties.

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

//Although you can query the current value of the numberOfEdits property from within another source file, you can’t modify the property from another source file.

//You can make the structure’s numberOfEdits property getter public, and its property setter private, by combining the public and private(set) access-level modifiers:
    

public struct TrackedString1 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//MARK:- Intializers

// Custom initializers can be assigned an access level less than or equal to the type that they initialize.
//  A required initializer must have the same access level as the class it belongs to.

//MARK:- Protocols

//The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol. You can’t set a protocol requirement to a different access level than the protocol it supports.
//Note:- If you define a public protocol, the protocol’s requirements require a public access level for those requirements when they’re implemented.

//MARK:- Extensions

//You can’t provide an explicit access-level modifier for an extension if you’re using that extension to add protocol conformance. Instead, the protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension.

//Private Members in Extensions

//Declare a private member in the original declaration, and access that member from extensions in the same file.
//Declare a private member in one extension, and access that member from another extension in the same file.
//Declare a private member in an extension, and access that member from the original declaration in the same file.

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

//MARK:- Generics

//The access level for a generic type or generic function is the minimum of the access level of the generic type or function itself and the access level of any type constraints on its type parameters.

//MARK:- Type Aliases

//Any type aliases you define are treated as distinct types for the purposes of access control.
//A type alias can have an access level less than or equal to the access level of the type it aliases
//For example, a private type alias can alias a private, file-private, internal, public, or open type, but a public type alias can’t alias an internal, file-private, or private type.
