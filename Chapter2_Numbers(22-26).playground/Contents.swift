import UIKit
import PlaygroundSupport
import XCTest

var number = 21

//Challenge 22: Return the binary reverse unsigned Int value of an "8-bit" unsigned integer value
number += 1
print("--Challenge \(number)--")

//My answer:
func challenge22(number: UInt) -> UInt {
    
    //Convert input UInt number to binary
    var binaryNumber = String(number, radix: 2)
//    print(numberAsBinary) //eg: 32 as binary = 100000 (6 bits)

    //Add leading zeros / padding to make up 8 bits
    while binaryNumber.count < 8 {
         binaryNumber = "0" + binaryNumber
    }
//    print(binaryNumber) // eg: 32 with padding = 00100000
    
    //Reverse  8-bit binary string
    let reversed = String(binaryNumber.reversed())
//    print(reversed) // eg: 32 with padding reversed = 00000100
    
    ///Convert and return reversed binary String to its UInt representation
//    return strtoul(reversed, nil, 2) // eg: 00000100 = 4
    return UInt(reversed, radix: 2) ?? 0 // eg: 00000100 = 4
    
}

//Verification
var challenge22Result = challenge22(number: 32)
print("challenge\(number)Result: \(challenge22Result)")

challenge22Result = challenge22(number: 4)
print("challenge\(number)Result: \(challenge22Result)")

challenge22Result = challenge22(number: 148)
print("challenge\(number)Result: \(challenge22Result)")

challenge22Result = challenge22(number: 41)
print("challenge\(number)Result: \(challenge22Result)")


//Tests
assert(challenge22(number: 32) == 4, "Challenge \(number) failed")
assert(challenge22(number: 4) == 32, "Challenge \(number) failed")
assert(challenge22(number: 148) == 41, "Challenge \(number) failed")
assert(challenge22(number: 41) == 148, "Challenge \(number) failed")


//Challenge 23: Return true if an input String contains only the numbers 0-9.
number += 1
print("--Challenge \(number)--")

func challenge23(input: String) -> Bool {
    
    //Iterate input String with filter() and pull out only whole numbers
    let numbers = input.filter { $0.isWholeNumber }.count
//    print(numbersOnly)
   
   //Compaer filtered array count with input String count
    if numbers == input.count {
        return true
    }

    return false
    
}

var challenge23Result = challenge23(input: "01010101")
print("challenge\(number)Result: \(challenge23Result)")

challenge23Result = challenge23(input: "123456789")
print("challenge\(number)Result: \(challenge23Result)")

challenge23Result = challenge23(input: "9223372036854775808")
print("challenge\(number)Result: \(challenge23Result)")

challenge23Result = challenge23(input: "1.01")
print("challenge\(number)Result: \(challenge23Result)")

challenge23Result = challenge23(input: "101F")
print("challenge\(number)Result: \(challenge23Result)")


//Challenge 24: Return the sum of all numbers contained in a String
number += 1
print("--Challenge \(number)--")

func challenge24(input: String) -> Int {
    
    //Pull out nun-numbers from input String to create an array to be ussed for CharacterSet
    let letters = input.filter { !$0.isNumber }
//    print(letters)
    
    //Use array of non-numbers to create array of numbers only
    let numbers = input.components(separatedBy: CharacterSet(charactersIn: letters))
//    print (numbers)
    
    //Remove nil elements using compactMap()
    let compactMapped = numbers.compactMap { numbers in Int(numbers)  }
//    print(compactMapped)
    
    //Sum numbers by iterating through String, converting each character to string, then to Int and addeding to each other via reduce()
    return compactMapped.reduce(0, { Int(String($0))! + Int(String($1))! })

    
}

//Verification
var challenge24Result = challenge24(input: "0101F45x60")
print("challenge\(number)Result: \(challenge24Result)")

challenge24Result = challenge24(input: "a10b20c30")
print("challenge\(number)Result: \(challenge24Result)")

//Tests
assert(challenge24(input: "a1b2c3") == 6, "Challenge \(number) failed")
assert(challenge24(input: "a10b20c30") == 60, "Challenge \(number) failed")
assert(challenge24(input: "h8ers") == 8, "Challenge \(number) failed")


//Challenge 25: Return the square root of a positive number without using sqrt()
number += 1
print("--Challenge \(number)--")

func challenge25(input: Int) -> Int? {
    
    guard input > 0 else { return nil }
    guard input != 1 else { return 1 }
    
    //Ste upper bound limit by halving input
    for i in 1...input / 2 {
        
        //Then check if i * itself == input
        if i * i == input {
            return i
        }
        
        //Else as soon as i * itself exceeds input, return i - 1
        if (i * i)  > input {
            return i - 1
        }
    }
    
    return nil
}

//Verification
var challenge25Result = challenge25(input: 9)
print("challenge\(number)Result: \(challenge25Result ?? 0)")

challenge25Result = challenge25(input: 15)
print("challenge\(number)Result: \(challenge25Result ?? 0)")

challenge25Result = challenge25(input: 26)
print("challenge\(number)Result: \(challenge25Result ?? 0)")

challenge25Result = challenge25(input: 1)
print("challenge\(number)Result: \(challenge25Result ?? 0)")

//Tests
assert(challenge25(input: 16777216) == 4096, "Challenge \(number) failed")
assert(challenge25(input: 16) == 4, "Challenge \(number) failed")


//Challenge 26: Subtruct a positive Int from another without using subtract operator
number += 1
print("--Challenge \(number)--")

func challenge26(subtract: Int, from: Int) -> Int? {
    
    var difference = 0
    
    for _ in subtract..<from {
        difference += 1
    }
    
    return difference
}

var challenge26Result = challenge26(subtract: 5, from: 9)
print("challenge\(number)Result: \(challenge26Result ?? 0)")

challenge26Result = challenge26(subtract: 10, from: 30)
print("challenge\(number)Result: \(challenge26Result ?? 0)")
