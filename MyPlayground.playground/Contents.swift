//: Playground - noun: a place where people can play

// 1. Some differences between Objective-C and Swift.

// #import <UIKit/UIKit.h>
import UIKit

// NSString *hello = @"Hello, playground";
let hello = "Hello, playground"

// NSString *example = [NSString stringWithFormat:@"My name is Djuro and I am %d years old", 34];
let example = "My name is Djuro and I am \(34) years old"

// @property (weak, nonatomic) IBOutlet UIButton *someButton;
// @IBOutlet weak var someButton: UIButton!

// CGSize size = CGSizeMake(width: 10, height: 10)
let size = CGSize(width: 10, height: 10)

// NSDate *date = [[NSDate alloc] init];
let date = Date()

// 2. var vs. let

var someVar = 34
someVar = 45

let someLet = 34
// someLet = 45 // Will produce an error.

// MUTABILITY IS DONE VIA var vs. let!

// 3. Data types.

let string = "text" // Type inferring.
let integer = 34
let boolean = false
let double = 34.0
let float: Float = 34.0

// 4. Optionals.
var temperature: Double?
// print("\(temperature!)") // It will crash because temperature is nil.

// Forced unwrapping.
var forced: Double?
forced = 34.0
print("\(forced)")
print("\(forced!)")

// Optional binding.
if let f = forced {
    print(f)
}

// Optional chaining.

// 5. Collections.

// Array - complexity O(n), ORDERED!
let numbers = [1,2,3,4,5,6,7,8,9]
let emptyIntArray = [Int]()
let emptyStringArray = [String]()
numbers[3]
// numbers[0] = 10 let -> var

// Dictionary
var dictionary = ["BG": "Beograd", "NS": "Novi Sad"]
dictionary["NI"] = "Niš"
print(dictionary)

// Set - complexity O(1), UNORDERED!
var set = Set(["Beograd", "Novi Sad", "Niš", "Niš"])
// Int, Double, String, ... conforms to Hashable protocol.

// Tuple
var tuple = ("Djuro", 34, true)
tuple.0

var tuple2 = (name: "Djuro", years: 34, drivingLicense: true)
tuple2.years
tuple2.drivingLicense

// 6. Control flow and loops.

if !boolean {
    print("Statement is false")
}

for number in numbers {
    print(number)
}

for i in 1...10 {
    print(i)
}

for i in 1..<10 {
    print(i)
}

// While, switch (not using fallthrough), ...

// 7. Functional programming.

// Form array of numbers which are > 3 and < 7.
var resultsViaFor = [Int]()
for number in numbers {
    if number > 3 && number < 7 {
        resultsViaFor.append(number)
    }
}
print(resultsViaFor)

var resultsViaFunctionalProgramming = [Int]()
resultsViaFunctionalProgramming = numbers.filter { $0 > 3 && $0 < 7}
print(resultsViaFunctionalProgramming)

// 8. Structs vs. Classes.

// Pass-by-reference.
class TestClass {
    var string = "class"
}

var aTestClass = TestClass()
var bTestClass = aTestClass

aTestClass.string = "changed"

print(aTestClass.string)
print(bTestClass.string)

// Pass-by-value.
struct TestStruct {
    var string = "struct"
}

var aTestStruct = TestStruct()
var bTestStruct = aTestStruct

aTestStruct.string = "changed"

print(aTestStruct.string)
print(bTestStruct.string) // !!!

// Example: NSDate is a class, Date is a 'wrapper strct' around NSDate. So it is value type instead of reference type.

// Apple's suggestion: choose wisely, but prefer to use structs rather than classes.

// 9. Access Control.

/*
 
 open - you can access open classes and class members from any source file in the defining module or any module that imports that module. You can subclass an open class or override an open class member both within their defining module and any module that imports that module.

 public - allows the same access as open - any source file in any module - but has more restrictive subclassing and overriding. You can only subclass a public class within the same module. A public class member can only be overriden by subclasses in the same module. This is important if you are writing a framework. If you want a user of that framework to be able to subclass a class or override a method you must make it open.

 internal - allows use from any source file in the defining module but not from outside that module. This is generally the default access level.

 fileprivate -  allows use only within the defining source file.

 private - allows use only from the enclosing declaration.

 */
