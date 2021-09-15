//
//  Properties.swift
//  SwiftDashboard
//
//  Created by Subhankar Acharya on 14/07/21.
//

import Foundation

//MARK:- Introduction

 //1. Computed properties are provided by classes, structures, and enumerations.
 //2. Stored properties are provided only by classes and structures.
 //3. Properties can also be associated with the type itself. Such properties are known as type properties.
 //4. Property observers to monitor changes in a property’s value, which you can respond to with custom actions.
 //5. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.
 //6. Use a property wrapper to reuse code in the getter and setter of multiple properties.

//MARK:- Stored Properties

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
    
    //When an instance of a value type is marked as a constant, so are all of its properties.
    //If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.

//Lazy Stored Properties


//A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.

//You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.


class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created

print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"

//Stored Properties and Instance Variables

// With Objective-C, you may know that it provides two ways to store values and references as part of a class instance.

// In addition to properties, you can use instance variables as a backing store for the values stored in a property.

// A Swift property doesn’t have a corresponding instance variable, and the backing store for a property isn’t accessed directly.

//MARK:- Computed Properties

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.x + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

//Shorthand Setter Declaration

//If a computed property’s setter doesn’t define a name for the new value to be set, a default name of newValue is used.

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//Shorthand Getter Declaration

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//Read-Only Computed Properties

//A computed property with a getter but no setter is known as a read-only computed property.

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return height * width
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 7.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"


//MARK:- Property Observers

//Property observers observe and respond to changes in a property’s value.

//Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.

    //Stored properties that you define
    //Stored properties that you inherit
    //Computed properties that you inherit

//For an inherited property, you add a property observer by overriding that property in a subclass.

//For a computed property that you define, use the property’s setter to observe and respond to value changes, instead of trying to create an observer.

    //willSet is called just before the value is stored.
    //didSet is called immediately after the new value is stored.

//The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps){
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

//If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called.

//Note:- If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function.

//MARK:- Property Wrappers

//A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
//e.g:- if you have properties that provide thread-safety checks or store their underlying data in a database
//      you have to write that code on every property

// When you use a property wrapper, you write the management code once when you define the wrapper, and then reuse that management code by applying it to multiple properties.


//In the code below, the TwelveOrLess structure ensures that the value it wraps always contains a number less than or equal to 12. If you ask it to store a larger number, it stores 12 instead.
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue,12) }
    }
}

//Code that’s written anywhere else accesses the value using the getter and setter for wrappedValue, and can’t use number directly as its declared private.

//You apply a wrapper to a property by writing the wrapper’s name before the property as an attribute.

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
//prints "0"

rectangle.height = 10
print(rectangle.height)
//Prints 10

rectangle.height = 24
print(rectangle.height)
//prints 12


struct SmallRectangles {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

// The _height and _width properties store an instance of the property wrapper, TwelveOrLess.


// Setting Initial Values for Wrapped Properties

//To support setting an initial value or other customization, the property wrapper needs to add an initializer.

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum)}
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

//When you apply a wrapper to a property and you don’t specify an initial value, Swift uses the init() initializer to set up the wrapper.

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
//Prints "0 0"

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
//Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"

//Projecting a Value From a property Wrapper

//a property wrapper can expose additional functionality by defining a projected value

//TO DO:- Projecting a Value From a Property Wrapper

//MARK:- Global and Local Variables



//MARK:- Type Properties

// Instance properties are properties that belong to an instance of a particular type.

// Stored type properties can be variables or constants.

// Computed type properties are always declared as variable properties, in the same way as computed instance properties.

// Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.

// Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.

//Type property syntax

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.

// Querying and Setting Type Properties

print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "7"
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "10"


