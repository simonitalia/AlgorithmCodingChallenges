//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import XCTest

//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
//        self.view = view
//    }
//}

// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()

var number = 0

//Challenge 1: Are letters unique
number += 1
print("--Challenge \(number)--")

//My answer
func challenge1(input: String) -> Bool {
    
    var checkChars = [Character]()
    
    for character in input {
        
        //If character already exists
        if checkChars.contains(character) {
            return false
            
            //If character doesn't exist
        } else {
            checkChars.append(character)
        }
    }
    
    return true
}


//Verification
var result = challenge1(input: "No duplicates")
print(result)

result = challenge1(input: "abcdefghijklmnopqrstuvwxyz")
print(result)

result = challenge1(input: "AaBbCc")
print(result)

result = challenge1(input: "Hello, world")
print(result)


//Tests
assert(challenge1(input: "No duplicates") == true, "Challenge \(number) failed")
assert(challenge1(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge \(number) failed")
assert(challenge1(input: "AaBbCc") == true, "Challenge \(number) failed")
assert(challenge1(input: "Hello, world") == false, "Challenge \(number) failed")

//Optimized answer
func challenge1a(input: String) -> Bool {
    return Set(input).count == input.count
    
}


//Tests
assert(challenge1a(input: "No duplicates") == true, "Challenge \(number) failed")
assert(challenge1a(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge \(number) failed")
assert(challenge1a(input: "AaBbCc") == true, "Challenge \(number) failed")
assert(challenge1a(input: "Hello, world") == false, "Challenge \(number) failed")


//Challenge 2: Is a string a palindrom (if reads the same in reverse. word or sentence)
number += 1
print("--Challenge \(number)--")

//My answer
func challenge2(input: String) -> Bool {
    
    //Convert input String to array of characters, lower case all letters
    let characters = Array(input.lowercased())
    
    //Reverse order of characters  String, store as an Array
    let reversedCharacters = characters.reversed() as Array
    
    if characters == reversedCharacters {
        return true
        
    } else {
        
        return false
        
    }
    
}


//Verification
result = challenge2(input: "rotator")
print(result)

result = challenge2(input: "Rats live on no evil star")
print(result)

result = challenge2(input: "Never odd or even")
print(result)

result = challenge2(input: "Hello, world")
print(result)


//Tests
assert(challenge2(input: "rotator") == true, "Challenge \(number) failed")
assert(challenge2(input: "Rats live on no evil star") == true, "Challenge \(number) failed")
assert(challenge2(input: "Never odd or even") == false, "Challenge \(number) failed")
assert(challenge2(input: "Hello, world") == false, "Challenge \(number) failed")


//Optimized answer
func challenge2a(input: String) -> Bool {
    
    //Lower case input String
    let lowercaseInput = input.lowercased()
    
    //Compare lowercased inut String, to itself in reverse order
    return String(lowercaseInput.reversed()) == lowercaseInput
    
}

//Tests
assert(challenge2a(input: "rotator") == true, "Challenge \(number) failed")
assert(challenge2a(input: "Rats live on no evil star") == true, "Challenge \(number) failed")
assert(challenge2a(input: "Never odd or even") == false, "Challenge \(number) failed")
assert(challenge2a(input: "Hello, world") == false, "Challenge \(number) failed")


//Challenge 3: Do 2 strings contain the exact same characters. Case sensitive, any order.
number += 1
print("--Challenge \(number)--")

//My answer
func challenge3(inputA: String, inputB: String) -> Bool {
    
    //Compare 2 input Strings, factoring in case
    return inputA.sorted() == inputB.sorted()
}

result = challenge3(inputA: "abca", inputB: "abca")
print(result)

result = challenge3(inputA: "abc", inputB: "cba")
print(result)

result = challenge3(inputA: "a1 b2", inputB: "b1 a2")
print(result)

result = challenge3(inputA: "abc", inputB: "abca")
print(result)

result = challenge3(inputA: "abc", inputB: "Abc")
print(result)

result = challenge3(inputA: "abc", inputB: "cbAa")
print(result)

result = challenge3(inputA: "abcc", inputB: "abca")
print(result)


//Optimized answer
//Sames as Myanswer :)

//Tests
assert(challenge3(inputA: "abca", inputB: "abca") == true, "Challenge \(number) failed")
assert(challenge3(inputA: "abc", inputB: "cba") == true, "Challenge \(number) failed")
assert(challenge3(inputA: "a1 b2", inputB: "b1 a2") == true, "Challenge \(number) failed")
assert(challenge3(inputA: "abc", inputB: "abca") == false, "Challenge \(number) failed")
assert(challenge3(inputA: "abc", inputB: "Abc") == false, "Challenge \(number) failed")
assert(challenge3(inputA: "abc", inputB: "cbAa") == false, "Challenge \(number) failed")
assert(challenge3(inputA: "abcc", inputB: "abca") == false, "Challenge \(number) failed")


//Challenge 4: Does one string contain another string. (Can't use contains() method)
number += 1
print("--Challenge \(number)--")

func challenge4(input1: String, input2: String) -> Bool {
    
    //Ensure to compare smaller string inside of longer string
    let inputA: String
    let inputB: String
    
    if input1.count <= input2.count {
        inputA = input1
        inputB = input2
        
    } else {
        inputA = input2
        inputB = input1
    }
    
    //Convert Strings to Character arrays, and set case
    let arrayA = Array(inputA.lowercased())
    let arrayB = Array(inputB.lowercased())
    
    //Computed Array to check / test against
    var tempArray = [Character]()
    
    //Starting index point
    var indexA = 0
    
    //Loop through inputB characters array
    for characterB in arrayB {
        
        if arrayA[indexA] == characterB {
            tempArray.append(characterB)
            indexA += 1
            
            if tempArray == arrayA {
                return true
            }
        }
    }
    
    return false
}

//Verification
result = challenge4(input1: "hello, world", input2: "hello")
print(result)

result = challenge4(input1: "hello, world", input2: "WORLD")
print(result)

result = challenge4(input1: "hello, world", input2: "Goodbye")
print(result)


//Tests
assert(challenge4(input1: "hello, world", input2: "hello") == true, "Challenge \(number) failed")
assert(challenge4(input1: "hello, world", input2: "WORLD") == true, "Challenge \(number) failed")
assert(challenge4(input1: "Goodbye", input2: "hello, world") == false, "Challenge \(number) failed")


//Optimized answer (Using ranged(of: method)
let text2compare = "Hello, world"

//Verification
result = (text2compare.range(of: "hello", options: .caseInsensitive) != nil)
print(result)

result = (text2compare.range(of: "WORLD", options: .caseInsensitive) != nil)
print(result)

result = (text2compare.range(of: "Goodbye", options: .caseInsensitive) != nil)
print(result)


//With extension
extension String {
    
    func challenge4a(input: String) -> Bool {
        
        return range(of: input, options: .caseInsensitive) != nil
    }
}

//Tests
assert("Hello, world".challenge4a(input: "Hello") == true, "Challenge \(number) failed")
assert("Hello, world".challenge4a(input: "WORLD") == true, "Challenge \(number) failed")
assert("Hello, world".challenge4a(input: "Goodbye") == false, "Challenge \(number) failed")


//Challenge 5: Count how many times each character of a string appears. (Can't use for-in-loop)
number += 1
print("--Challenge \(number)--")


//My answer 1: (Using for-in-loop)
func challenge5(inputA: Character, inputB: String) -> Int {
    
    var frequency = 0
    
    for character in inputB {
        
        if character == inputA {
            frequency += 1
        }
    }
    
    return frequency
    
}

//Verification
var challenge5Result = challenge5(inputA: "a", inputB: "The rain in Spain")
print(challenge5Result)

challenge5Result = challenge5(inputA: "i", inputB: "Mississipi")
print(challenge5Result)

challenge5Result = challenge5(inputA: "i", inputB: "Hacking with Swift")
print(challenge5Result)

challenge5Result = challenge5(inputA: "I", inputB: "Simon Italia")
print(challenge5Result)


//Tests
assert(challenge5(inputA: "a", inputB: "The rain in Spain") == 2, "Challenge \(number) failed")
assert(challenge5(inputA: "i", inputB: "Mississipi") == 4, "Challenge \(number) failed")
assert(challenge5(inputA: "i", inputB: "Hacking with Swift") == 3, "Challenge \(number) failed")
assert(challenge5(inputA: "I", inputB: "Simon Italia") == 1, "Challenge \(number) failed")

//My answer 2: (without using for-in-loop) Using "filter"
func challenge5a(inputA: Character, inputB: String) -> Int {
    
    return inputB.filter { $0 == inputA }.count
    
}

//Verification
var challenge5aResult = challenge5a(inputA: "a", inputB: "The rain in Spain")
print(challenge5aResult)

challenge5aResult = challenge5a(inputA: "i", inputB: "Mississipi")
print(challenge5aResult)

challenge5aResult = challenge5a(inputA: "i", inputB: "Hacking with Swift")
print(challenge5aResult)

challenge5aResult = challenge5a(inputA: "I", inputB: "Simon Italia")
print(challenge5aResult)


//Tests
assert(challenge5a(inputA: "a", inputB: "The rain in Spain") == 2, "Challenge \(number) failed")
assert(challenge5a(inputA: "i", inputB: "Mississipi") == 4, "Challenge \(number) failed")
assert(challenge5a(inputA: "i", inputB: "Hacking with Swift") == 3, "Challenge \(number) failed")
assert(challenge5a(inputA: "I", inputB: "Simon Italia") == 1, "Challenge \(number) failed")



//My answer 3: Same as above, as String extension
extension String {
    
    func challenge5b(input: Character) -> Int {
        
        return self.filter { $0 == input }.count
    }
}

//Verification
var challenge5bResult = "The rain in Spain".challenge5b(input: "a")
print(challenge5bResult)

challenge5bResult = "Mississipi".challenge5b(input: "i")
print(challenge5bResult)

challenge5bResult = "Hacking with Swift".challenge5b(input: "i")
print(challenge5bResult)

challenge5bResult = "Simon Italia".challenge5b(input: "I")
print(challenge5bResult)


//Tests
assert("The rain in Spain".challenge5b(input: "a") == 2, "Challenge \(number) failed")
assert("Mississipi".challenge5b(input: "i") == 4, "Challenge \(number) failed")
assert("Hacking with Swift".challenge5b(input: "i") == 3, "Challenge \(number) failed")
assert("Simon Italia".challenge5b(input: "I") == 1, "Challenge \(number) failed")

//Optimized answer: (Using .reduce() )
func challenge5c(inputA: Character, inputB: String) -> Int {
    
    return inputB.reduce(0) {
        $1 == inputA ? $0 + 1 : $0
    }
    
}

//Tests
assert(challenge5c(inputA: "a", inputB: "The rain in Spain") == 2, "Challenge \(number) failed")
assert(challenge5c(inputA: "i", inputB: "Mississipi") == 4, "Challenge \(number) failed")
assert(challenge5c(inputA: "i", inputB: "Hacking with Swift") == 3, "Challenge \(number) failed")
assert(challenge5c(inputA: "I", inputB: "Simon Italia") == 1, "Challenge \(number) failed")


//Challenge 6: Remove duplicate characters from a string, so only a singele occurance of each chracter remains
number += 1
print("--Challenge \(number)--")

//My answer: (Using for-in-loop)
func challenge6(input: String) -> String {
    
    var newString = [Character]()
    
    for character in input {
        
        if newString.contains(character) {
            //Do nothing
            
        } else {
            //Add character to newString array
            newString.append(character)
        }
    }
    
    return String(newString)
    
}

//Verification
var challenge6Result = challenge6(input: "wombat")
print(challenge6Result)

challenge6Result = challenge6(input: "hello")
print(challenge6Result)

challenge6Result = challenge6(input: "Mississipi")
print(challenge6Result)


//Tests
assert(challenge6(input: "wombat") == "wombat", "Challenge \(number) failed")
assert(challenge6(input: "hello") == "helo", "Challenge \(number) failed")
assert(challenge6(input: "Mississipi") == "Misp", "Challenge \(number) failed")


//My answer: (without using for-in-loop)
func challenge6a(input: String) -> String {
    
    var set = Set<Character>()
    let unique = Array(input.filter {
        set.insert($0).inserted
    })
    
    return String(unique)
    
}

//Verification
var challenge6aResult = challenge6a(input: "wombat")
print(challenge6aResult)

challenge6aResult = challenge6a(input: "hello")
print(challenge6aResult)

challenge6aResult = challenge6a(input: "Mississipi")
print(challenge6aResult)


//Tests
assert(challenge6a(input: "wombat") == "wombat", "Challenge \(number) failed")
assert(challenge6a(input: "hello") == "helo", "Challenge \(number) failed")
assert(challenge6a(input: "Mississipi") == "Misp", "Challenge \(number) failed")


//Challenge 7: Remove consecutive spaces, so only single occurance of a space remains
number += 1
print("--Challenge \(number)--")

//My answer
func challenge7(input: String) -> String {
    
    let str = input.replacingOccurrences(of: "  ", with: " ")
    
    return str.replacingOccurrences(of: "  ", with: " ")
    
}

//Verification
var challenge7Result = challenge7(input: "a   b   c")
print(challenge7Result)

challenge7Result = challenge7(input: "    a")
print(challenge7Result)

challenge7Result = challenge7(input: "abc")
print(challenge7Result)

//Test
assert(challenge7(input: "a   b   c") == "a b c", "Challenge \(number) failed")
assert(challenge7(input: "    a") == " a", "Challenge \(number) failed")
assert(challenge7(input: "abc") == "abc", "Challenge \(number) failed")


//Optimized answer: Using regular expression
func challenge7a(input: String) -> String {
    
    return input.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
    
}

//Verification
var challenge7aResult = challenge7a(input: "a   b   c")
print(challenge7aResult)

challenge7aResult = challenge7a(input: "    a")
print(challenge7aResult)

challenge7aResult = challenge7a(input: "abc")
print(challenge7aResult)


//Tests
assert(challenge7a(input: "a   b   c") == "a b c", "Challenge \(number) failed")
assert(challenge7a(input: "    a") == " a", "Challenge \(number) failed")
assert(challenge7a(input: "abc") == "abc", "Challenge \(number) failed")


//Challenge 8: Is a string a rotation of another string. Can rotate 1 or many characters
number += 1
print("--Challenge \(number)--")

//My answer
func challenge8(inputA: String, inputB: String) -> Bool {
    
    //Verify both input strings are the same length before comparing
    guard inputA.count == inputB.count else { return false }
    
    //Convert inputB to array
    var array = Array(inputB)
    
    for _ in inputB {
        
        //Get the last element position of the array
        let lastIndex = array.count - 1
        
        //Remove last letter of inputB and, move it to the front
        let lastLetter = array.remove(at: lastIndex)
        array.insert(lastLetter, at: 0)
        //        print(array)
        
        //Test if array as a String matches inputA
        if String(array) == inputA {
            
            return true
        }
    }
    
    return false
    
}

//Verification
var challenge8Result = challenge8(inputA: "eabcd", inputB: "abcde")
print(challenge8Result)

challenge8Result = challenge8(inputA: "abcde", inputB: "eabcd")
print(challenge8Result)

challenge8Result = challenge8(inputA: "cdeab", inputB: "abcde")
print(challenge8Result)

challenge8Result = challenge8(inputA: "abcde", inputB: "cdeab")
print(challenge8Result)

challenge8Result = challenge8(inputA: "abced", inputB: "abcde")
print(challenge8Result)

challenge8Result = challenge8(inputA: "abcde", inputB: "abced")
print(challenge8Result)

challenge8Result = challenge8(inputA: "a", inputB: "abc")
print(challenge8Result)

challenge8Result = challenge8(inputA: "abc", inputB: "a")
print(challenge8Result)

challenge8Result = challenge8(inputA: "Eabcd", inputB: "abcdE")
print(challenge8Result)

challenge8Result = challenge8(inputA: "Eabcd", inputB: "abcde")
print(challenge8Result)

//Tests
assert(challenge8(inputA: "eabcd", inputB: "abcde") == true, "Challenge \(number) failed")
assert(challenge8(inputA: "abcde", inputB: "eabcd") == true, "Challenge \(number) failed")
assert(challenge8(inputA: "cdeab", inputB: "abcde") == true, "Challenge \(number) failed")
assert(challenge8(inputA: "abcde", inputB: "cdeab") == true, "Challenge \(number) failed")
assert(challenge8(inputA: "abced", inputB: "abcde") == false, "Challenge \(number) failed")
assert(challenge8(inputA: "abcde", inputB: "abced") == false, "Challenge \(number) failed")
assert(challenge8(inputA: "a", inputB: "abc") == false, "Challenge \(number) failed")
assert(challenge8(inputA: "abc", inputB: "a") == false, "Challenge \(number) failed")
assert(challenge8(inputA: "Eabcd", inputB: "abcdE") == true, "Challenge \(number) failed")
assert(challenge8(inputA: "Eabcd", inputB: "abcde") == false, "Challenge \(number) failed")

//Optimized answer: Add one of the strings to itself, then compare combined string to the other string
func challenge8a(inputA: String, inputB: String) -> Bool {
    
    //Verify both strings are the same length before comparing
    guard inputA.count == inputB.count else { return false }
    
    //combine one input with itself
    let combined = inputA + inputA
    //    print(combined)
    
    //check if inutB is contained inside combined version of inputA
    return combined.contains(inputB)
    
}


//Tests
assert(challenge8a(inputA: "eabcd", inputB: "abcde") == true, "Challenge \(number) failed")
assert(challenge8a(inputA: "abcde", inputB: "eabcd") == true, "Challenge \(number) failed")
assert(challenge8a(inputA: "cdeab", inputB: "abcde") == true, "Challenge \(number) failed")
assert(challenge8a(inputA: "abcde", inputB: "cdeab") == true, "Challenge \(number) failed")
assert(challenge8a(inputA: "abced", inputB: "abcde") == false, "Challenge \(number) failed")
assert(challenge8a(inputA: "abcde", inputB: "abced") == false, "Challenge \(number) failed")
assert(challenge8a(inputA: "a", inputB: "abc") == false, "Challenge \(number) failed")
assert(challenge8a(inputA: "abc", inputB: "a") == false, "Challenge \(number) failed")

