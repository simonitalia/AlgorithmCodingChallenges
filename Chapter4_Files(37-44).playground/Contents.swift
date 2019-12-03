import Foundation
import PlaygroundSupport
import XCTest

var number = 36

//Challenge 37: Return all executable file names within a given directory (eg: Resources folder). Do not include exe files in the directory's sub-diretory/ies or the names of sub-directories
number += 1
print("--Challenge \(number)--")

//My answer: Write an extension for collections of integers, returning the number of times a specified digit appears in each integer

func challenge37(count number: Int, in array: [Int]) -> Int {
    
    var count = 0
    for num in array {
        
        for digit in String(num)  {
            
            //If digit in Int doesn't match number to compare to, exit that loop
            if String(digit) == String(number) {
                count += 1
            }
        }
    }
    return count
}

//var digits: [Int] {
//    return String(describing: self).compactMap { Int(String($0)) }
// }

//Verification:
var challenge37Result = challenge37(count: 1, in: [55, 15, 25, 15, 1205])
print("challenge\(number)Result: \(challenge37Result)")

challenge37Result = challenge37(count: 5, in: [55, 15, 25, 15, 1205])
print("challenge\(number)Result: \(challenge37Result)")


//My answer: As Array extension and functional programming
extension Array {
    
    func challenge37a(count number: Int) -> Int {
        var count = 0
        
        //Iterate over each Int object inside array
        for element in self as! [Int] {
            
            //Convert each Int element object to String, and iterate over string
            for digit in String(element)  {
                
                //If digit in Int element matches number to compare with, increment count
                if String(digit) == String(number) {
                    count += 1
                }
            }
        }
        return count
    }
}

//Verification
var challenge37aResult = [55, 15, 25, 15, 1205].challenge37a(count: 5)
print("challenge\(number)aResult: \(challenge37aResult)")

//Tests
assert([5, 15, 55, 515].challenge37a(count: 5) == 6, "Challenge \(number) failed")
assert([5, 15, 55, 515].challenge37a(count: 1) == 2, "Challenge \(number) failed")
assert([55555].challenge37a(count: 5) == 5, "Challenge \(number) failed")
assert([55555].challenge37a(count: 1) == 0, "Challenge \(number) failed")


//Optimized answer: Using filter()
extension Collection where Iterator.Element == Int {
    
    func challenge37b(count number: Character) -> Int {
        
        return self.reduce(0) {
            $0 + String($1).filter { (char: Character) -> Bool in
                char == number }.count
            }
        }
}

//Tests
assert([5, 15, 55, 515].challenge37b(count: Character(String(5))) == 6, "Challenge \(number) failed")
assert([5, 15, 55, 515].challenge37b(count: Character(String(1))) == 2, "Challenge \(number) failed")


//Challenge 38: Write an extenson for all collections that returns the input array in order from smallest to largest , for the N number elements requested
number += 1
print("--Challenge \(number)--")

//Conform to Comparable so array of element type Any is actually usable
extension Collection where Iterator.Element: Comparable {

    func challenge38(count: Int) -> [Iterator.Element] {
        
        //Check collection contains more elements than count , and if nor, exit method and rerun sorted array
        guard self.count > count else { return self.sorted() }
    
        //Sort array from smallest to largest
        let sortedArray = self.sorted()
        var result = [Any]()
        
            for (index, value) in sortedArray.enumerated() {
                guard index != count else { return result as! [Self.Element] }
                result.append(value)
            }
        return []
    }

}

//Verification
var challenge38Result = [55, 15, 25, 1205].challenge38(count: 3)
print("challenge\(number)Result: \(challenge38Result)")

challenge38Result = [55, 15, 25, 1205].challenge38(count: 9)
print("challenge\(number)Result: \(challenge38Result)")

//Tests
assert([1, 2, 3, 4].challenge38(count: 3) == [1, 2, 3], "Challenge \(number) failed")
assert(["q", "f", "k"].challenge38(count: 10) == ["f", "k", "q"], "Challenge \(number) failed")
assert([256, 16].challenge38(count: 3) == [16, 256], "Challenge \(number) failed")
assert([String]().challenge38(count: 3) == [], "Challenge \(number) failed")


//Optimized answer: Using prefix to get the first N elements of array
extension Collection where Iterator.Element: Comparable {
    
    func challenge38b(count: Int) -> [Iterator.Element] {
        
        //Check collection contains more elements than count , and if not, exit method and return sorted array
        guard self.count > count else { return self.sorted() }
        
        //Sort array, smallest to largest
        let sortedArray = self.sorted()
        
        //Pull out number of elements up specified by count parameter
        return Array(sortedArray.prefix(count))
    }
}

//Tests
assert([1, 2, 3, 4].challenge38b(count: 3) == [1, 2, 3], "Challenge \(number) failed")
assert(["q", "f", "k"].challenge38b(count: 10) == ["f", "k", "q"], "Challenge \(number) failed")
assert([256, 16].challenge38b(count: 3) == [16, 256], "Challenge \(number) failed")
assert([String]().challenge38b(count: 3) == [], "Challenge \(number) failed")


//Challenge 39: Extend collections with a function to sort an array of strings from longest to shortest
number += 1
print("--Challenge \(number)--")

//My answer:
extension Collection where Iterator.Element == String {

    func challenge39() -> [String] {
        
        guard self.count > 1 else { return self as! Array }
        
        //Customize sorted() to sort based on specific criteria (length of String element, big to small)
        return self.sorted { $0.count > $1.count }
    }
}

//Verification

//Arrays
var challenge39Result = ["paul", "taylor", "adele"].challenge39()
print("challenge\(number)Result: \(challenge39Result)")

challenge39Result = ["ab", "abcd", "abcdef", "abc"].challenge39()
print("challenge\(number)Result: \(challenge39Result)")

challenge39Result = ["a", "abc", "ab"].challenge39()
print("challenge\(number)Result: \(challenge39Result)")

challenge39Result = [String]().challenge39()
print("challenge\(number)Result: \(challenge39Result)")

//Sets
let setA: Set<String> = ["ab", "abcd", "abcdef", "abc"]
challenge39Result = setA.challenge39()
print("challenge\(number)Result: \(challenge39Result)")


//Tests
assert(["ab", "abcd", "abcdef", "abc"].challenge39() == ["abcdef", "abcd", "abc", "ab"], "Challenge \(number) failed")
assert(["a", "abc", "ab"].challenge39() == ["abc", "ab", "a"], "Challenge \(number) failed")
assert([String]().challenge39() == [], "Challenge \(number) failed")
assert(["paul", "taylor", "adele"].challenge39() == ["taylor", "adele", "paul"], "Challenge \(number) failed")

//Challenge 40: Create a function that takes an unsorted array of numbers from 1 to 100, with 0 or more missing numbers, and returns the missing numbers
number += 1
print("--Challenge \(number)--")

//My answer:

//Generate Test data
var numbers = [Int]()
for i in 1...100 {
    numbers.append(i)
}
numbers.shuffle()
//print(numbers)

let testArray = Array(numbers.prefix(75))
//print(testNumbers.sorted())

func challenge40(numbers array: [Int]) -> [Int] {
    
    print("Numbers: \(array.sorted())")
    
    var missingNumbers = [Int]()
    
    for i in 1...100  {
        if !array.contains(i) {
            missingNumbers.append(i)
        }
    }
    
//    print("Missing numbers: \(missingNumbers.sorted())")
    return missingNumbers.sorted()
    
}

var challenge40Result = challenge40(numbers: testArray)
print("challenge\(number)Result: \(challenge40Result)\n")


//My answer: Using Set.contains() method since it's faster than Array.set()
func challenge40b(numbers array: [Int]) -> [Int] {
    
    //convert input Array to Set
    let inputSet = Set(array)
    print("Numbers: \(inputSet.sorted())")
    
    var missingNumbers = [Int]()
    
    for i in 1...100  {
        if !inputSet.contains(i) {
            missingNumbers.append(i)
        }
    }
    
    //    print("Missing numbers: \(missingNumbers.sorted())")
    return missingNumbers.sorted()
    
}

var challenge40bResult = challenge40b(numbers: testArray)
print("challenge\(number)bResult: \(challenge40bResult)\n")


//Optimized answer:
func challenge40c(numbers array: [Int]) -> [Int] {

    //convert input Array to Set
    let partialSet = Set(array)
    print("Numbers: \(partialSet.sorted())")
    
    //Generate correct Array set (all numbers)
    let fullSet = Set(1...100)
    
    //Return numbers not contained in either set by subtracting full set from the partial set
    return Array(fullSet.subtracting(partialSet).sorted())
}

var challenge40cResult = challenge40c(numbers: testArray)
print("challenge\(number)cResult: \(challenge40cResult)\n")


//Challenge 41: Return the median (mid point of an array). If array has 2 mid points (ie: arrays with even number of elements), return the average of the 2 mid points
number += 1
print("--Challenge \(number)--")

//My answer:
extension Collection where Iterator.Element == Int {
    
    func challenge41() -> Double? {
        
        guard self.count != 0 else { return nil }
        
        //Sort inputArray
        var sortedArray = self.sorted()
        var median = Double()
        
        //If array has even set of numbers
        if sortedArray.count % 2 == 0 {
            
            let startIndex = sortedArray.count / 2
            median = Double((sortedArray[startIndex] + sortedArray[startIndex - 1])) / 2
        
        //If array has odd set of numbers
        } else {
            let index = (sortedArray.count - 1) / 2
            median = Double(sortedArray[index])
        }
        
        return median
    }
}

//Verification
var challenge41Result = [9, 1, 23, 5].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [1, 5, 10, 12, 15].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [1, 2, 3].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [1, 2, 9].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [1, 3, 5, 7, 9].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [1, 2, 3, 4].challenge41()!
print("challenge\(number)Result: \(challenge41Result)\n")

challenge41Result = [Int]().challenge41() ?? 0
print("challenge\(number)Result: \(challenge41Result)\n")

//Challenge 42: Recreate firstIndex(of: method)
number += 1
print("--Challenge \(number)--")

//My answer
let indexOfNumber = [9, 1, 23, 5, 9]
indexOfNumber.firstIndex(of: 9)

extension Collection where Iterator.Element == Any {
    
    func challenge42(indexOf element: Int) -> Int? {
        
        for (index, value) in self.enumerated() {
            if element == value as! Int {
                return index
            }
        }
        
        return nil
    }
}

//Verification
var challenge42Result = [1, 2, 3, 4].challenge42(indexOf: 4)!
print("challenge\(number)Result: \(challenge42Result)\n")

challenge42Result = [1, 2, 3, 4].challenge42(indexOf: 5) ?? 0
print("challenge\(number)Result: \(challenge42Result)\n")

//Tests
assert([1, 2, 3].challenge42(indexOf: 1) == 0, "Challenge \(number) failed")
assert([1, 2, 3].challenge42(indexOf: 3) == 2, "Challenge \(number) failed")
assert([1, 2, 3].challenge42(indexOf: 5) == nil, "Challenge \(number) failed")

//Optimized answer: Using Equatable Protocol
extension Collection where Iterator.Element: Equatable {
    
    func challenge42a(indexOf element: Iterator.Element) -> Int? {
        
        for (index, value) in self.enumerated() {
            if element == value {
                return index
            }
        }
        
        return nil
    }
}

//Verification
var challenge42aResult = [1, 2, 3, 4].challenge42a(indexOf: 4)!
print("challenge\(number)aResult: \(challenge42aResult)\n")

challenge42aResult = [1, 2, 3, 4].challenge42a(indexOf: 5) ?? 0
print("challenge\(number)aResult: \(challenge42aResult)\n")

//Tests
assert([1, 2, 3].challenge42a(indexOf: 1) == 0, "Challenge \(number) failed")
assert([1, 2, 3].challenge42a(indexOf: 3) == 2, "Challenge \(number) failed")
assert([1, 2, 3].challenge42a(indexOf: 5) == nil, "Challenge \(number) failed")


//Challenge 43: Create a linked lowercase list of all the (english) alphabet letters, and a method that travesres the nodes and prints the letters on a single line, seperated with a space
number += 1
print("--Challenge \(number)--")

//My answer: Using explicit Data Type
//class Node {
//
//    //node properties
//    var value: Character //value of node
//    var next: Node? //reference to next node. Decalred as optional since last node in the list won't have a next node property
//    weak var previous: Node?  //reference to previous node. defined as weak to avoid strong / multiple reference cycles
//
//    init(value: Character) {
//        self.value = value
//    }
//
//}
//
//class LinkedList {
//
//    //linked list properties to track start (head) and end (tail) of linked list
//    var head: Node?
//    var tail: Node?
//
//    //Set head and tail nodes
//    var isEmpty: Bool {
//        return head == nil
//    }
//
//    var first: Node? {
//        return head
//    }
//
//    var last: Node? {
//        return tail
//    }
//
//
//    //handle appending new nodes to list, at start, at end or in middle
//    func append(value: Character) {
//
//        let newNode = Node(value: value) //properties to create new node
//
//        if let tailNode = tail { //if tail node exists (not nil),
//            newNode.previous = tailNode //set (former) tail node to be the previous node of new node
//            tailNode.next = newNode // set (former) tail node next property to the new node
//
//        } else {
//            head = newNode //if tail node property is nil, (doesn't exist), set new node as head node
//
//        }
//        tail = newNode //set new node as tail node
//    }
//
//
//    //Enable accessing specific node/s by their position / index
//    func nodeAt(index: Int) -> Node? {
//
//        guard index >= 0 else { return nil } //ensure index value passed is not negative
//
//        var node = head
//        var i = index
//
//        //loop through nodes
//        while node != nil {
//            guard i == 0 else { return node } //when index is found, return node
//            i -= 1
//            node = node!.next
//        }
//
//        return nil
//    }
//
//
//}
//
////Make custom LinkedList class conform to Custom String convertible protocol to enable friendly output
//extension LinkedList: CustomStringConvertible {
//
//    var description: String {
//
//        var text = "["
//        var node = head
//
//        while node != nil {
//            text += "\(node!.value)"
//            node = node!.next
//            if node != nil { text += ", " }
//        }
//
//        return text + "]"
//    }
//
//}
//
////Test creating LinkedList data objects
//let letters = LinkedList()
//for letter in "abcdefghijklmnopqrstuvwxyz" {
//
//    letters.append(value: letter)
//
//}
////print(letters)
//
////let firstNode = letters.nodeAt(index: 8)
////print(firstNode!)
//
//
////My answer: Using Generics
//
////Define the node class
//class LLNode<T: Equatable> {
//    var value: T? = nil
//    var next: LLNode? = nil //exists for all nodes, except final node
//
//}
//
////Define the Linked List class and declare the head node
//class LList<T: Equatable> {
//    var head = LLNode<T>() //Assigned to first node ony
//
//    //Setup insert node method
//    func insertNode(with value: T) {
//
//        //check if list is empty
//
//        //If list is empty assign new node as head
//        if self.head.value == nil {
//            self.head.value = value
//
//        //else find and insert new node after last node, assign new node as last node
//        } else {
//            var lastNode = self.head
//            while lastNode.next != nil {
//                lastNode = lastNode.next!
//            }
//
//            //Once last node is found, by nil next property, insert new node at end of list
//            let newNode = LLNode<T>()
//            newNode.value = value //set value of new node (passed in as param)
//            lastNode.next = newNode //set/point the previous last node's next property to newNode
//        }
//    }
//
//    //method to print out keys
//    func printAllNodes() {
//        var current: LLNode! = self.head
//        while current != nil && current.value != nil{
//            print(current.value!, terminator: " ")
//            current = current.next
//        }
//    }
//
//}
//
////Make custom LinkedList class conform to Custom String convertible protocol to enable friendly output
//extension LList: CustomStringConvertible {
//
//    var description: String {
//
//        var text = "["
//        var current = head
//
//        while current.next != nil {
//            text += "\(current.value!)"
//            current = current.next!
//            if current.next != nil {
//                text += ", "
//
//            } else {
//                text += ", \(current.value!)"
//            }
//        }
//
//        return text + "]"
//    }
//}
//
////Generate linked list and output to console
//var alphabet = LList<Character>()
//
//for letter in "abcdefghijklmnopqrstuvwxyz" {
//    alphabet.insertNode(with: letter)
//}
//
////print(alphabet)
//alphabet.printAllNodes()

//Optimized answer:

//Define node class
class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

//Define Linked List / chain of nodes class
class LinkedL<T> {
    var head: LinkedListNode<T>?
    
    //Creat print function
    func printNodes() {
        var currentNode = head //set start node
        
        while let node = currentNode { //while currentNode is not nil
            print(node.value, terminator: " ")
            currentNode = node.next // update current node to next node
        }
    }
}

var list = LinkedL<Character>()
var previousNode: LinkedListNode<Character>? = nil

for letter in "abcdefghijklmnopqrstuvwxyz" {
    let node = LinkedListNode(value: letter)
    
    //if there's a value for previousNode, set it's next property to current node
    if let predecessor = previousNode {
        predecessor.next = node
    
    //Set the first node to head node (based on previousNode being nil for first loop
    } else {
        list.head = node
    }
    
    //Set the previous node property to current node for use in the next loop
    previousNode = node
}

list.printNodes()


//Challenge 44: Get the mid-point by extendin the list class

extension LinkedL {
    
    //Get mid-point
    func midPointOf(node: T) -> Int {
        
        
        
        
        
        return 0
    }
    
    
    
    //Enable accessing specific node/s by their position / index
    func nodeAt(index: Int) -> LinkedListNode<T>? {
        
        guard index >= 0 else { return nil } //ensure index value passed is not negative
        
        var node = head
        var i = index
        
        //loop through nodes
        while node != nil {
            guard i == 0 else { return node } //when index is found, return node
            i -= 1
            node = node!.next
        }
        
        return nil
    }
    
}



