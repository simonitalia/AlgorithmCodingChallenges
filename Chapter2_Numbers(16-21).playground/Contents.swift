import UIKit

import UIKit
import PlaygroundSupport
import XCTest

var number = 15

//Challenge 16: If number is divisible by 3, 5 or both print specific words for each case
number += 1
print("--Challenge \(number)--")

func challenge16() {
    
    for number in 1...100 {
        
        if number % 3 == 0 {
            print("Fizz : ", (number))
        
        } else if number % 5 == 0 {
            print(" Buzz : ", (number))
        
        } else if number % 3 == 0 && number % 5 == 0 {
            print("Fizz Buzz : ", (number))
        
        } else {
            print(number)
            
        }
    }
    
}

//Verification
var result: Any = challenge16()
print("challenge \(number)Result: \(result)")

//Optimized answer: Using forEach
func challenge16a() {
    
    (1...100).forEach {
        
        print($0 % 3 == 0 ? $0 % 5 == 0 ? "Fizz Buzz" : "Fizz" : $0 % 5 == 0 ? "Buzz" : "\($0)" )
    }
}

//Verification
result = challenge16a()
print("challenge\(number)aResult: \(result)")


//Challenge 17: Print out a random number between a range of positive numbers (eg: 3-22)
number += 1
print("--Challenge \(number)--")

func challenge17(inputA: Int, inputB: Int) -> Int {
    
    //Ensure both inputs are positive
    guard inputA >= 0 && inputB >= 0 else { return 0}
    
    //Set which input vaue is min and max
    var min = 0
    var max = 0
    
    if inputA < inputB {
        min = inputA
        max = inputB
        
    } else {
        min = inputB
        max = inputA
    }
    
    //Generate random number between min and mx
//    let randomNum = Int.random(in: min...max)
    
    return Int.random(in: min...max)
}


//Verification
var challenge17Result = challenge17(inputA: 0, inputB: 5)
print("challenge\(number)Result: \(challenge17Result)")


//Tests
//Check random number is between inputs A and B
assert(challenge17(inputA: 0, inputB: 10) >= 0, "Challenge \(number) failed")
assert(challenge17(inputA: 0, inputB: 10) <= 10, "Challenge \(number) failed")
assert(challenge17(inputA: 10, inputB: 0) >= 0, "Challenge \(number) failed")
assert(challenge17(inputA: 10, inputB: 0) <= 10, "Challenge \(number) failed")


//Challenge 18: Recreate the pow() function by raising the first input to the power of the second
number += 1
print("--Challenge \(number)--")
func challenge18(inputA: Int, inputB: Int) -> Int {
    
    //Ensure both inputs are positive
    guard inputA > 0 && inputB > 0 else { return 0}
    
    //Get result of initial inputA multiply itself
    var result = inputA * inputA
    
    //Multiply result with inputA, mor times denoted inputB value
    for _ in 2..<inputB  {
        result *= inputA
    }

    return result
}

//Verification
var challenge18Result = challenge18(inputA: 9, inputB: 6)
print("challenge\(number)Result: \(challenge18Result)")
var challenge18Check = pow(9,6)
print(challenge18Check)

challenge18Result = challenge18(inputA: 5, inputB: 7)
print("challenge\(number)Result: \(challenge18Result)")
challenge18Check = pow(5,7)
print(challenge18Check)

challenge18Result = challenge18(inputA: 8, inputB: 3)
print("challenge\(number)Result: \(challenge18Result)")
challenge18Check = pow(8,3)
print(challenge18Check)

//Tests
assert(challenge18(inputA: 4, inputB: 3) == 64, "Challenge \(number) failed")
assert(challenge18(inputA: 2, inputB: 8) == 256, "Challenge \(number) failed")



//My answer: Using a recursive function (a function that calls itself
func challenge18a(inputA: Int, inputB: Int, count: Int) -> Int {
    
    //Ensure both inputs are positive
    guard inputA > 0 && inputB > 0 else { return 0 }
    
    if count < inputB - 1 {
        //Count property used to track and stop call back to function
    let power = inputB
        return challenge18a(inputA: inputA * power, inputB: inputB, count: count + 1)
    }

    return inputA
}

//Verification
var challenge18aResult = challenge18a(inputA: 3, inputB: 3, count: 0)
print("challenge\(number)aResult: \(challenge18aResult)")
var challenge18aCheck = pow(3,3)
print(challenge18aCheck)

challenge18aResult = challenge18a(inputA: 9, inputB: 9, count: 0)
print("challenge\(number)aResult: \(challenge18aResult)")
challenge18aCheck = pow(9,9)
print(challenge18aCheck)


//Optimized answer: Using a recursive function without a count to track calls
func challenge18b(number: Int, power: Int) -> Int {
    
    //Ensure both inputs are positive
    guard number > 0, power > 0 else { return 0 }
    
    if power == 1 {
        return number
    }
    
    return number * challenge18b(number: number, power: power - 1)
}

//Verification
var challenge18bResult = challenge18b(number: 3, power: 3)
print("challenge\(number)bResult: \(challenge18bResult)")
var challenge18bCheck = pow(3,3)
print(challenge18bCheck)

challenge18bResult = challenge18b(number: 9, power: 9)
print("challenge\(number)bResult: \(challenge18bResult)")
challenge18bCheck = pow(9,9)
print(challenge18bCheck)



//Challenge 19: Swap 2 integer variables, without using a temp variable
number += 1
print("--Challenge \(number)--")

//My aswer with tuple and math
func challenge19(inputA: Int, inputB: Int) -> (inputB: Int, inputA: Int) {
    
    guard inputA > 0 && inputB > 0 else { return (inputB: 0, inputA: 0) }
    
    return (inputB: (inputA + inputB) - inputA, inputA: (inputA + inputB) - inputB)
}

//Verification
var challenge19Result = challenge19(inputA: 5, inputB: 3)
print("challenge\(number)Result: \(challenge19Result)")

challenge19Result = challenge19(inputA: 203, inputB: 5031)
print("challenge\(number)Result: \(challenge19Result)")

//Tests
assert(challenge19(inputA: 4, inputB: 3) == (inputB: 3, inputA: 4), "Challenge \(number) failed")
assert(challenge19(inputA: 2, inputB: 8) == (inputB: 8, inputA: 2), "Challenge \(number) failed")
assert(challenge19(inputA: 2, inputB: 8) == (inputB: 8, inputA: 2), "Challenge \(number) failed")
assert(challenge19(inputA: 0, inputB: 8) == (inputB: 0, inputA: 0), "Challenge \(number) failed")
assert(challenge19(inputA: 7, inputB: -1) == (inputB: 0, inputA: 0), "Challenge \(number) failed")


//My asnwer: With simple tuple
func challenge19a(inputA: Int, inputB: Int) -> (inputB: Int, inputA: Int) {
    
    guard inputA > 0 && inputB > 0 else { return (inputB: 0, inputA: 0) }
    
    let tuple = (inputB: inputA, inputA: inputB)
    
    return tuple
}

var challenge19aResult = challenge19a(inputA: 5, inputB: 3)
print("challenge\(number)aResult: \(challenge19aResult)")

//My answer with swap() method
func challenge19b(inputA: Int, inputB: Int) -> (inputA: Int, inputB: Int) {
    
    var a = inputA
    var b = inputB
    
    swap(&a, &b)
    
    //swapAt via an array type
//    var array = [inputA, inputB]
//    array.swapAt(0, 1)
    
    return (inputA: a, inputB: b)
}

var challenge19bResult = challenge19b(inputA: 5, inputB: 3)
print("challenge\(number)bResult: \(challenge19bResult)")

//Optimized answer: Using tuple and switching objects inside tuple
func challenge19b(a: Int, b: Int) -> (a: Int, b: Int) {
    
    var tuple = (a, b)
    tuple = (b, a)
    
    //swapAt via an array type
    //    var array = [inputA, inputB]
    //    array.swapAt(0, 1)
    
    return tuple
}


//Challenge 20: Is number a prime number
number += 1
print("--Challenge \(number)--")

func challenge20(input: Int) -> Bool {
    
    for i in 2..<input {
        if input % i == 0 {
            return false
        }
    }

    return true
    
}

var challenge20Result = challenge20(input: 11)
print("challenge\(number)Result: \(challenge20Result)")

challenge20Result = challenge20(input: 13)
print("challenge\(number)Result: \(challenge20Result)")

challenge20Result = challenge20(input: 4)
print("challenge\(number)Result: \(challenge20Result)")

challenge20Result = challenge20(input: 9)
print("challenge\(number)Result: \(challenge20Result)")

//challenge20Result = challenge20(input: 16777259)
//print("challenge\(number)Result: \(challenge20Result)")


//MY answer: Using sqrt() method to search up to max number
func challenge20b(input: Int) -> Bool {
    
    //Abort execution if input < 1 (since by definition, 1 is not prime)
    guard input > 1 else { return false }
    
    //Abort execution if input = 2, sinc this won't work for 2
    guard input != 2 else { return true}
    
    let number = Double(input)
    let sqrRoot = round(sqrt(number))
    let max = Int(sqrRoot)
    
    for i in 2...max {
        if input % i == 0 {
            return false
        }
    }
    
    return true
    
}

var challenge20bResult = challenge20b(input: 11)
print("challenge\(number)bResult: \(challenge20bResult)")

challenge20bResult = challenge20b(input: 13)
print("challenge\(number)bResult: \(challenge20bResult)")

challenge20bResult = challenge20b(input: 4)
print("challenge\(number)bResult: \(challenge20bResult)")

challenge20bResult = challenge20b(input: 9)
print("challenge\(number)bResult: \(challenge20bResult)")

challenge20bResult = challenge20b(input: 16777259)
print("challenge\(number)bResult: \(challenge20bResult)")

challenge20bResult = challenge20b(input: 4)
print("challenge\(number)bResult: \(challenge20bResult)")


//Challenge 21: Count the binary 1s in an intenger, above and below an input integer
number += 1
print("--Challenge \(number)--")

//My answer: Using while-loop
func challenge21(input: Int) -> (nextLowest: Int, nextHighest: Int) {
    
    //Ensure input is positive
    guard input > 0 else { return (nextLowest: 0, nextHighest: 0) }
    
//    let input = 12
    
    //A. Determine number if 1s in input String
    //Convert input Int object to String, and convert to binary String
    let inputAsBinary = String(input, radix: 2)
//    print(inputAsBinary) //eg: 10100
    
    var inputOnesCount = 0
    //Use filter() to pull out 1s
    var _ = inputAsBinary.filter { (one) -> Bool in
        if one == "1" {
            inputOnesCount += 1
        }
//        print(inputOnesCount) //eg: 2
        return true
    }
    
    //2. Look for next lower number with same number of 1s
    var nextLowest = input
    var count = 0
    
    while count != inputOnesCount {
        nextLowest -= 1
        count = 0
        
        let nextLowestAsBinary = String(nextLowest, radix: 2)
        
        let _ = nextLowestAsBinary.filter { (one) -> Bool in

            if one == "1" {
                count += 1
            }
            
            return true
        }
    }
    
    //3. Look for next Higher number with same number of 1s
    var nextHighest = input
    var nextHighestCount = 0

    while nextHighestCount != inputOnesCount {
        nextHighest += 1
        nextHighestCount = 0

        let nextHighestAsBinary = String(nextHighest, radix: 2)
        nextHighestCount = nextHighestAsBinary.filter { (one) -> Bool in one == "1"}.count

        
    }

    return (nextLowest: nextLowest, nextHighest: nextHighest)

}

//Verification
var challenge21Result = challenge21(input: 12)
print("challenge\(number)Result: \(challenge21Result)")

challenge21Result = challenge21(input: 28)
print("challenge\(number)Result: \(challenge21Result)")

//Tests
assert(challenge21(input: 12) == (nextLowest: 10, nextHighest: 17), "Challenge \(number) failed")
assert(challenge21(input: 28) == (nextLowest: 26, nextHighest: 35), "Challenge \(number) failed")



