//
//  Initialization.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 21/08/21.
//

import Foundation

//MARK:- Initialization

/// Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.

/// Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.


/// Setting Initial Values for Stored Properties

/// Intialiaizers

struct Fahrenheit {
    var temperature: Double
        init() {
            temperature = 32.0
        }
}

var f = Fahrenheit()

print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"

///Default Property Values

struct Farenheit {
    var temperature = 32.0 //default initialization
}

//MARK:- Custom Initialization

///Initialization Parameters

///You can provide initialization parameters as part of an initializer’s definition,
///to define the types and names of values that customize the initialization process

struct Celsius {
    var temperatureInCelcius: Double
    
    init(fromFarenheit farenheit: Double) {
        temperatureInCelcius = (farenheit - 32.0)/1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelcius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFarenheit: 212.0)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)

/// Parameters Name and Argument Labels

struct Color {
    let green, blue, red: Double
    init(red: Double, green: Double, blue: Double) {
        self.green = green
        self.red = red
        self.blue = blue
    }
    
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGrey = Color(white: 0.5)

/// Initializer Parameters Without Argument Labels

struct Celsiu {
    var temperatureInCelcius: Double
    init(_ celcius: Double) {
        temperatureInCelcius = celcius
    }
}

let bodytemperature = Celsiu(37.0)

///Optional Property Types

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}


let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")

cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese"

/// Assigning Constant Properties During Initialization

class SurveyQuestions {
    let text: String  //a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestions(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//MARK:- Default Initalizers

///Swift provides a default initializer for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

struct ShoppingList {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingList()

/// Memberwise Initializers for Structure Types

/// Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers.

/// Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"

//MARK:- Initializer Delegation for Value Types

/// Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

/// Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves.

/// classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.

/// For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.

///NOTE:- If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

struct Sizes {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Sizes()
    
    init() {}
    init(origin: Point, size: Sizes) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Sizes) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.width / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Sizes(width: 3.0, height: 3.0))

//MARK:- Class Inheritance and Initialization

/// All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.

/// Designated initializers are the primary initializers for a class.

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

/// If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a zero-argument designated initializer, you can omit a call to super.init() after assigning values to all of the subclass’s stored properties.

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitlty called here
    }
    
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

/// Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver

/// Automatic Initializer Inheritance

/// Designated and Convenience Initializers in Action

//1800 419 0505

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"

let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]"

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    ///The init(name: String) convenience initializer provided by RecipeIngredient takes the same parameters as the init(name: String) designated initializer from Food. Because this convenience initializer overrides a designated initializer from its superclass, it must be marked with the override modifier (as described in Initializer Inheritance and Overriding).
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
    ///Even though RecipeIngredient provides the init(name: String) initializer as a convenience initializer, RecipeIngredient has nonetheless provided an implementation of all of its superclass’s designated initializers. Therefore, RecipeIngredient automatically inherits all of its superclass’s convenience initializers too.
}

let oneMysteryItem = RecipeIngredient()

let oneBacon = RecipeIngredient(name: "Bacon")

let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
    ///Because it provides a default value for all of the properties it introduces and doesn’t define any initializers itself, ShoppingListItem automatically inherits all of the designated and convenience initializers from its superclass.
}

var breakfastList = [ShoppingListItem(),
                     ShoppingListItem(name: "Bacon"),
                     ShoppingListItem(name: "Eggs", quantity: 6),]

breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘

//MARK:- Failable Initializers

///A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.

/// For instance, failable initializers are implemented for numeric type conversions.

let wholeNumber:Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber)
{
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}
// Prints "3.14159 conversion to Int doesn't maintain value"


struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}


let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"

let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal

if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}
// Prints "The anonymous creature couldn't be initialized"

///Checking for an empty string value (such as "" rather than "Giraffe") isn’t the same as checking for nil to indicate the absence of an optional String value. In the example above, an empty string ("") is a valid, non-optional String. However, it’s not appropriate for an animal to have an empty string as the value of its species property. To model this restriction, the failable initializer triggers an initialization failure if an empty string is found.

/// Failable Initializers for Enumerations

enum TemperatureUnit {
    case kelvin, celcius, farenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celcius
        case "F":
            self = .farenheit
        default:
            return nil
        }
    }
}

let farenheitUnit = TemperatureUnit(symbol: "F")
if farenheitUnit != nil {
    print("This is a defined tempaeraturte unit, so initalization succeeded.")
}

// Prints "This is a defined tempareature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")

if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

// Prints "This isn't a defined temperature unit, so initialization failed."

///Failable Initializers for Enumerations with Raw Values

// Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists.

enum TemperatureUnits: Character {
    case kelvin = "K", celcius = "C", farenheit = "F"
}

let fahrenheitUnits = TemperatureUnits(rawValue: "F")

if fahrenheitUnits != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnits = TemperatureUnits(rawValue: "X")
if unknownUnits == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."

/// Propagation of Initialization Failure

/// A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration.

/// NOTE:- A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Prints "Item: sock, quantity: 2"

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// Prints "Unable to initialize zero shirts"

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// Prints "Unable to initialize one unnamed product"

/// Overriding a Failable Initializer

/// You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer.

/// Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.

/// You can override a failable initializer with a nonfailable initializer but not the other way around.

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init?(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

///You can use forced unwrapping in an initializer to call a failable initializer from the superclass as part of the implementation of a subclass’s nonfailable initializer.

class UntitedDocument : Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//MARK:- Required Initializers

class SomeClass {
    required init() {
        
    }
}

class SomeSubclass : SomeClass {
    required init() {
        
    }
}

//MARK:- Setting a Default Property Value with a Closure or Function

//class SomeClasss {
//    let someProperty: SomeType = {
//        // create a default value for someProperty inside this closure
//        // someValue must be of the same type as SomeType
//        return someValue
//    }()
//}

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Prints "false"
