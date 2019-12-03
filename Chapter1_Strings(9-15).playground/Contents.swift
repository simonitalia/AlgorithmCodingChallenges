//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import XCTest

var number = 8

//Challenge 9: Is a string an english pangram (contains all alphabet letters at least once)
number += 1
print("--Challenge \(number)--")
func challenge9(input: String) -> Bool {
    
    //Immeditaley exit method and return false if string contains less than 26 characters
    guard input.count > 25 else { return false }
    
    //Remove duplicate characters from lower case String
    let set = Set(input.lowercased())
    var count = 0
    
    for char in set {
        if char.isLetter {
            count += 1
        }
        
        //If we hit 26 (unique) letters, exit method and return true
        if count == 26 {
            return true
        }
    }
    
    return false
    
}

//Verification
var challenge9Result = challenge9(input: "The quick brown fox jumps over the lazy dog")
print(challenge9Result)

challenge9Result = challenge9(input: "The quick brown fox jumped over the lazy dog")
print(challenge9Result)

//Tests
assert(challenge9(input: "The quick brown fox jumps over the lazy dog") == true, "Challenge \(number) failed")
assert(challenge9(input: "The quick brown fox jumped over the lazy dog") == false, "Challenge \(number) failed")


//My answer: (Using map(), instead of for-in-loop)
func challenge9a(input: String) -> Bool {
    
    //Immeditaley exit method and return false if string contains less than 26 characters
    guard input.count > 25 else { return false }
    
    //Remove duplicate characters from lower case String
    let set = Set(input.lowercased())
    let letters = set.filter { $0.isLetter }
    return letters.count == 26
    
}

//Verification
var challenge9aResult = challenge9a(input: "The quick brown fox jumps over the lazy dog")
print(challenge9aResult)

challenge9aResult = challenge9a(input: "The quick brown fox jumped over the lazy dog")
print(challenge9aResult)

//Tests
assert(challenge9a(input: "The quick brown fox, jumps over the lazy dog!") == true, "Challenge \(number) failed")
assert(challenge9a(input: "The quick brown fox jumped over the lazy dog.") == false, "Challenge \(number) failed")
assert(challenge9a(input: "Not enough letters") == false, "Challenge \(number) failed")

//Optimized answer
//Sames as Myanswer :)

//Challenge 10: Return in a tuple, number of consonants and vowels contained in a string.
number += 1
print("--Challenge \(number)--")

func challenge10(input: String) -> (String, String) {
    
    let vowels = "aeiou"
    
    //Set input string object to lowercase, and pull out just letters
    let letters = input.lowercased().filter { $0.isLetter }
    
    //Compare each Character of letters String object to each character of vowels String object, pull out just vowel Characters
    let justVowels = letters.filter { vowels.contains($0) }
    
    //Return tuple with count of each letter type
    return ("Vowels: \(justVowels.count)", "Consonants \(letters.count - justVowels.count)")
}

//Verification
var challenge10Result = challenge10(input: "Swift Coding Challenges.")
print(challenge10Result)

challenge10Result = challenge10(input: "Mississippi")
print(challenge10Result)

//Tests
assert(challenge10(input: "Swift! Coding Challenges.") == ("Vowels: 6", "Consonants 15"), "Challenge \(number) failed")
assert(challenge10(input: "Mississippi is gr8") == ("Vowels: 5", "Consonants 10"), "Challenge \(number) failed")

//Optimized answer: Way less optimal than mine :)

//Challenge 11: Are 2 strings in length identical, but have no more than 3 identical letters (factor in case and string order)
number += 1
print("--Challenge \(number)--")

func challenge11(inputA: String, inputB: String) -> Bool {
    
    //Check both strings match length
    guard inputA.count == inputB.count else { return false }
    
    var matchedCharsAToB = [Int]()
    var matchedCharsBToA = [Int]()
    
    //Compare each input string to get the order of characters matched
    for (index, char) in inputA.enumerated() {
        if inputB.contains(char) {
            matchedCharsAToB.append(index)
        }
    }
    
    //Before moving on, check that no more than 3 letters don't match using the input string object and comparing to the matched characters objects
    let differences = inputA.count - matchedCharsAToB.count
    if differences > 3 {
//        print("Exiting method. Too many differences of: \(differences)")
//        print("---")
        return false
    }
    
//    print(matchedCharsAToB)
    
    for (index, char) in inputB.enumerated() {
        if inputA.contains(char) {
            matchedCharsBToA.append(index)
        }
    }
//    print(matchedCharsBToA)
    
    //Compare the 2 for equality
    let matchedOrder = matchedCharsAToB == matchedCharsBToA
    
//    print("Matched character order?: \(matchedOrder)")
//    print("Character differences: \(inputA.count - matchedCharsAToB.count)")
//    print("---")

    return differences < 4 && matchedOrder == true
    
}

//Verification
var challenge11Result = challenge11(inputA: "Clamp",inputB: "Grans" )
print("challenge11Result: \(challenge11Result)")

//Tests
assert(challenge11(inputA: "Clamp", inputB: "Cramp") == true, "Challenge \(number) failed")
assert(challenge11(inputA: "Clamp", inputB: "Crams") == true, "Challenge \(number) failed")
assert(challenge11(inputA: "Clamp", inputB: "Grams") == true, "Challenge \(number) failed")
assert(challenge11(inputA: "Simon", inputB: "Jason") == true, "Challenge \(number) failed")
assert(challenge11(inputA: "Clamp", inputB: "Grans") == false, "Challenge \(number) failed")
assert(challenge11(inputA: "Clamp", inputB: "Clam") == false, "Challenge \(number) failed")
assert(challenge11(inputA: "clamp", inputB: "maple") == false, "Challenge \(number) failed")
assert(challenge11(inputA: "simon", inputB: "Jason") == false, "Challenge \(number) failed")


//My answer: (Using map() and filter() instead of for-loop to find letter matches
func challenge11a(inputA: String, inputB: String) -> Bool {
    
    //Check both strings match length
    guard inputA.count == inputB.count else { return false }
    
    //Compare inputA string object characters to inputB string object characters
    let mapA = inputA.map { inputB.contains($0) }
//    print("mapA: \(mapA)")
    
    //Check no more than 3 characters mismatch by checking mapA character array object for mismatched occurrences (aka false)
    let diffs = mapA.filter { $0 == false }
//    print("Letter Diffs: \(diffs.count)")
    
    //Exit method if character diffs exceed 3, return false
    if diffs.count > 3 {
//        print("Exiting method. Too many differences of: \(diffs)")
        return false
    }
    
    //Compare input B characters to inputA characters
    let mapB = inputB.map { inputA.contains($0) }
//    print("mapB: \(mapB)")
    
    //Check orders of both arrays match
    let orderMatch = mapA == mapB
//    print("Letter order match: \(orderMatch)")
    
    //Return true if orders Match
    return orderMatch == true
    
}

//Verification
var challenge11aResult = challenge11a(inputA: "Clamp",inputB: "Grams" )
print("challenge11aResult: \(challenge11aResult)")

challenge11aResult = challenge11a(inputA: "clamp",inputB: "maple" )
print("challenge11aResult: \(challenge11aResult)")

challenge11aResult = challenge11a(inputA: "simon",inputB: "jason" )
print("challenge11aResult: \(challenge11aResult)")

//Tests
assert(challenge11a(inputA: "Clamp", inputB: "Cramp") == true, "Challenge \(number) failed")
assert(challenge11a(inputA: "Clamp", inputB: "Crams") == true, "Challenge \(number) failed")
assert(challenge11a(inputA: "Clamp", inputB: "Grams") == true, "Challenge \(number) failed")
assert(challenge11a(inputA: "Simon", inputB: "Jason") == true, "Challenge \(number) failed")
assert(challenge11a(inputA: "Clamp", inputB: "Grans") == false, "Challenge \(number) failed")
assert(challenge11a(inputA: "Clamp", inputB: "Clam") == false, "Challenge \(number) failed")
assert(challenge11a(inputA: "clamp", inputB: "maple") == false, "Challenge \(number) failed")
assert(challenge11a(inputA: "simon", inputB: "Jason") == false, "Challenge \(number) failed")

//Optimized answer: Using index / for-in-lopp of one string obeject
func challenge11b(inputA: String, inputB: String) -> Bool {
    
    //Check both strings match length
    guard inputA.count == inputB.count else { return false }
    
    let inputAArray = Array(inputA)
    let inputBArray = Array(inputB)
    
    var diffs = 0
    
    //Compare inputA string object characters with inputB array object elements (of type Character)
    for (index, char) in inputAArray.enumerated() {
        
        //Check for character order diffs
        if inputBArray[index] != char {
            diffs += 1
            print("Diff found: \(diffs)")
        }
        
        //Check if more than 3 characters diff
        if diffs > 3 {
            print("Exiting method. Too many differences of: \(diffs)")
            return false
        }
    }
    
    return true
}

//Verification
var challenge11bResult = challenge11b(inputA: "Clamp",inputB: "Grams" )
print("challenge11bResult: \(challenge11bResult)")

challenge11bResult = challenge11b(inputA: "clamp",inputB: "maple" )
print("challenge11bResult: \(challenge11bResult)")

challenge11bResult = challenge11b(inputA: "simon",inputB: "Jason" )
print("challenge11bResult: \(challenge11bResult)")

challenge11bResult = challenge11b(inputA: "simon",inputB: "jason" )
print("challenge11bResult: \(challenge11bResult)")

//Tests
assert(challenge11b(inputA: "Clamp", inputB: "Cramp") == true, "Challenge \(number) failed")
assert(challenge11b(inputA: "Clamp", inputB: "Crams") == true, "Challenge \(number) failed")
assert(challenge11b(inputA: "Clamp", inputB: "Grams") == true, "Challenge \(number) failed")
assert(challenge11b(inputA: "Simon", inputB: "Jason") == true, "Challenge \(number) failed")
assert(challenge11b(inputA: "Clamp", inputB: "Grans") == false, "Challenge \(number) failed")
assert(challenge11b(inputA: "Clamp", inputB: "Clam") == false, "Challenge \(number) failed")
assert(challenge11b(inputA: "clamp", inputB: "maple") == false, "Challenge \(number) failed")
//assert(challenge11b(inputA: "simon", inputB: "Jason") == false, "Challenge \(number) failed")


//Challenge 12: What's the common / longest prefix of all words in a String of words. How many of the first letters of a word match all the other words in the same string (eg: String = "swift switch swill swim. Matching longest prefix across all words = swi")
number += 1
print("--Challenge \(number)--")

//My answer: Using components(seperatedBy: ) and commonPrefix(with: ) methods
func challenge12(input: String) -> String {
    
    //Convert String of words to String Array
    let inputArray = input.components(separatedBy: " ")
//    print("Input String: \(inputArray)")
    
    var commonPrefixes = [String]()
    
    for (index, word) in inputArray.enumerated() {

        //Iterate throuhg the array to compare prefix of each element with next element, excluding last element
        if index < inputArray.count - 1 {
            
            let commonPrefix = word.commonPrefix(with: inputArray[index + 1])
            commonPrefixes.append(commonPrefix)
        }
    }
    
    //Sort commonPrefixes array objects by count property to place shortest prefix in first index position
    commonPrefixes.sort(by: { $0.count < $1.count })
//    print("Common longest prefix: \(commonPrefixes[0])")

    //Return first string object from the array
    return commonPrefixes[0]
}


//Verification
var challenge12Result = challenge12(input: "swift switch swill swim")
print("challenge12Result: \(challenge12Result)")

challenge12Result = challenge12(input: "flip flop flap")
print("challenge12Result: \(challenge12Result)")

challenge12Result = challenge12(input: "flipping flip flop flap flapping")
print("challenge12Result: \(challenge12Result)")

//Tests
assert(challenge12(input: "swift switch swill swim") == "swi", "Challenge \(number) failed")
assert(challenge12(input: "flip flop flap") == "fl", "Challenge \(number) failed")
assert(challenge12(input: "flipping flip flop flap flapping") == "fl", "Challenge \(number) failed")


//Optimized answer (although i think my answer is better, easier to digest): Using hasPrefix() method
func challenge12a(input: String) -> String {
    
    //Convert String of words to String Array
    let inputArray = input.components(separatedBy: " ")
    //    print("Input String: \(inputArray)")
    
    //Get the first word / string object from the inputArray string array object
    guard let firstWord = inputArray.first else { return ""}
    
    var bestPrefix = ""
    var currentPrefix = ""
    
    //Loop through and store each letter of firstWord object string
    for letter in firstWord {
        currentPrefix.append(letter)
        
        //Compare the combined letter/s in currentPrefix string object with prefix of all words in inputArray object. When combined letters don't match prefix with any word, exit the loops. Return the bestPrefix object (end result)
        for word in inputArray {
            if !word.hasPrefix(currentPrefix) {
                return bestPrefix
            }
        }
        
        //Update the bestPrefix after each outer loop
        bestPrefix = currentPrefix
    }
    
    return bestPrefix
}

//Verification
var challenge12aResult = challenge12a(input: "swift switch swill swim")
print("challenge12aResult: \(challenge12aResult)")


//Challenge 13: How often is each letter repeated in a single run, in a string
number += 1
print("--Challenge \(number)--")

func challenge13(input: String) -> String {
    
    let letters = Array(input)
    var output = [Character]()
    var result = ""
    
    //Set current letter counter
    var letterCount = 1
    
    for (index, letter) in letters.enumerated() {
        
        //Compare letter to next letter, but don't compare last letter in array to next index, otherwise crash :(
        if index < input.count - 1 {
            
            //Update letter count if the next letter matches current letter and so on
            if letter == letters[index + 1] {
                letterCount += 1
            
            //Once letter doens't match, update character object with letter and count
            } else {
                //Append letter and counts to output
                output.append(letter)
                
                //To append the count to the character object, convert to String, then Character before appending
                let countString = String(letterCount)
                output.append(Character(countString))
                
                //Reset counter
                letterCount = 1
            }
        
        //Deal with the last letter in the letters object, if different from previous
        } else {
            output.append(letter)
            let countString = String(letterCount)
            output.append(Character(countString))
        }
    }
    
    //Convert the resulting Character object to a String object
    result = String(output)
//    print(output)
    
    //Return result
    return result
}

//Verification
var challenge13Result = challenge13(input: "aaabbbaabb")
print("challenge13Result: \(challenge13Result)")

challenge13Result = challenge13(input: "aabbcc")
print("challenge13Result: \(challenge13Result)")

challenge13Result = challenge13(input: "aaAAaa")
print("challenge13Result: \(challenge13Result)")

challenge13Result = challenge13(input: "aaabaaabaaa")
print("challenge13Result: \(challenge13Result)")

challenge13Result = challenge13(input: "aaabaaaccba")
print("challenge13Result: \(challenge13Result)")

//Tests
assert(challenge13(input: "aaabbbaabb") == "a3b3a2b2", "Challenge \(number) failed")
assert(challenge13(input: "aabbcc") == "a2b2c2", "Challenge \(number) failed")
assert(challenge13(input: "aaAAaa") == "a2A2a2", "Challenge \(number) failed")
assert(challenge13(input: "aaabaaabaaa") == "a3b1a3b1a3", "Challenge \(number) failed")
assert(challenge13(input: "aaabaaaccba") == "a3b1a3c2b1a1", "Challenge \(number) failed")


//Challenge 14: How many and what are the permutations in a string
number += 1
print("--Challenge \(number)--")

func challenge14(input: String) -> (numberOfPermutations: Int, permutations: [String]) {
    
//    let input = "abc"
    
    //If only one letter contained in input string object, simply return the letter
    guard input.count > 1 else { return ( input.count, [input] ) }
    
    //Set properties
    let inputArray = Array(input)
//    var inputArrayCopy = inputArray
    
    var permutations = [String]()
    
    //Add starting array to permutations, if it doesn't exist
    if !permutations.contains(String(inputArray)) {
        permutations.append(String(inputArray))
        print("permutations updated")
    }

//    for _ in 0...15 {
    
    //Temp empty arrays to work with
    var leftSideArray = [String.Element]()
    var rightSideArray = inputArray
    print("Starting rightSideArray: \(rightSideArray)")

            for i in 0...rightSideArray.count - 1 {
                print("Loop number: \(i)")

//            for _ in rightSideArray.enumerated() {
    
                //Create a copy of inputArray to work with / mutate
//                let firstIndex = 0
                let lastChar = rightSideArray.last
                let lastIndex = rightSideArray.count - 1
                
                if rightSideArray.count != 0 {

                    //Move last letter to first position of array
    //                leftSideArray.insert(lastChar!, at: firstIndex)
                    leftSideArray.append(lastChar!)
                    print("leftSideArray modified: \(leftSideArray)")
                    
                    rightSideArray.remove(at: lastIndex)
                    print("rightSideArray modified: \(rightSideArray)")
                
                    let permutation = leftSideArray + rightSideArray
                    print("permutation: \(permutation)")

                    //Concatonate left and right arrays, update permutations with permutation
                    if !permutations.contains(String(permutation)) {
                        permutations.append(String(permutation))
                        print("Permutations updated with: \(permutation)")
                    }
                }
            }
    
//        }

//    }
    
    //To do: Remove duplicates with Set
//    return (numberOfPermutations: 0, permutations: [""])
//    print((permutations.count, permutations))
    return (permutations.count, permutations)
}

//Verification
//var challenge14Result = challenge14(input: "abcd")
//print("challenge14Result: \(challenge14Result)")


//Challenge 15: Right a function that reverses each word in a string, but leaves each word in its orginal order / sequence of the input string
number += 1
print("--Challenge \(number)--")

//My answer: using reversed and joined(seperrator: )
func challenge15(input: String) -> String {
    
    //Create array of Strings from strings inside input
    let inputArray = input.components(separatedBy: " ")
//    print(inputArray)
    
    //Iterate through each string in the array to reverse and output it. Need to ensure the array object being reversed is a String object since revresed works on string characters (aka [String.Element] )
    let reversedStrings = inputArray.map { String(($0).reversed())}
    
//    print(reversedStrings)
    
    //Convert array of Strings into a Single String
    return reversedStrings.joined(separator: " ")
    
}

//Verification
var challenge15Result = challenge15(input: "Swift Coding Challenges")
print("challenge15Result: \(challenge15Result)")


//Tests
assert(challenge15(input: "Swift Coding Challenges") == "tfiwS gnidoC segnellahC", "Challenge \(number) failed")
assert(challenge15(input: "The quick brown fox") == "ehT kciuq nworb xof", "Challenge \(number) failed")





