import UIKit
import Foundation
import PlaygroundSupport
import XCTest

//Directories

func directory() {
    let bundle = Bundle.main
    print("bundle: \(bundle)")
    // NSBundle </Users/simonitalia/Library/Developer/XCPGDevices/051179FA-831D-447E-A874-244DF8078876/data/Containers/Bundle/Application/6850B31E-0C5B-4C89-98A7-C614F2E624A1/Chapter3_Files(27-31)-6656-7.app> (loaded)
    

    let path = Bundle.main.resourcePath!
    print("path: \(path)")
    //path: /Users/simonitalia/Library/Developer/XCPGDevices/051179FA-831D-447E-A874-244DF8078876/data/Containers/Bundle/Application/6850B31E-0C5B-4C89-98A7-C614F2E624A1/Chapter3_Files(27-31)-6656-7.app

    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectoryURL = paths[0] //URL
    print("documentsDirectoryURL: \(documentsDirectoryURL)")
    //documentsDirectoryURL: file:///var/folders/xx/c6586yw900nbqzd3tfvcw4vw0000gn/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.Chapter3-Files-27-31--D38D01AD-047F-44CC-955A-CA3200E0685B/Documents/


    let documentsDirectoryString = documentsDirectoryURL.path
    print("documentsDirectoryString: \(documentsDirectoryString)")
    //documentsDirectoryString: /var/folders/xx/c6586yw900nbqzd3tfvcw4vw0000gn/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.Chapter3-Files-27-31--D38D01AD-047F-44CC-955A-CA3200E0685B/Documents

    let defaults = UserDefaults.standard
    print("defualts: \(defaults)")
    //<NSUserDefaults: 0x600003d10060>

}

//let directories = directory()
//print(directories)

var number = 26

//Challenge 27: Load a list file and print to console X number of the list items in reverse order (ie: starting with the last item and working to first)
number += 1
print("--Challenge \(number)--")

func challenge27(filename: String, ofType: String, linesToPrint: Int) -> String {
    
    let fileContents: String
    var output = [String]()
    
    //Load  .txt file from Playground resources
    if let filepath = Bundle.main.path(forResource: filename, ofType: ofType, inDirectory: "Exercise27") {
        
        do {
            fileContents = try String(contentsOfFile: filepath)
//            print(fileContents)
            
            //Convert String to array
            let array = fileContents.components(separatedBy: "\n")
//            print("Array: \(array)")
            
            //Reverse String array
            let reversed = Array(array.reversed())
            
            //Ensure lines to print doesn't exceed array index range with min()
            let lowest = min(linesToPrint, reversed.count - 1)
            
            //If lines to print is greater than index range, return entitre contents of array in reverse
            if linesToPrint != lowest {
                return reversed.joined(separator: ", ")
                
                //Else print lines specified
            } else {
                
                for i in 0..<lowest {
                    output.append(reversed[i])
                }
//                    print("Partial reversed: \(output)")
            }
            
        } catch {
            // contents could not be loaded
            print("File contents could be loaded")
        }
        
    } else {
        // example.txt not found!
        print("File not found")
    }
    
    return output.joined(separator: ", ")
    
}

//Verification
var challenge27Result = challenge27(filename: "Exercise27", ofType: "txt", linesToPrint: 3)
print("challenge\(number)Result: \(challenge27Result)")

challenge27Result = challenge27(filename: "Exercise27", ofType: "txt", linesToPrint: 100)
print("challenge\(number)Result: \(challenge27Result)")

challenge27Result = challenge27(filename: "Exercise27", ofType: "txt", linesToPrint: 0)
print("challenge\(number)Result: \(challenge27Result)")


//Challenge 28: Write a log entry to a file on disk. Append existing log file with new entry or create a new log file if one doesn't already exist
number += 1
print("--Challenge \(number)--")

//My answer
//Helper method to find the path to files created and saved by the app
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    print("Documents Paths: \(paths)") //Documents directory path as URL array
//    print("Documents Paths[0]: \(paths[0])") // Documents directory path as URL
    print("Files/Documents Path.first!: \(paths.first!)") //Same as paths[0])
    return paths[0]
}

func challenge28(logEntry: String) {
    
    var text = logEntry
    
    //Set current date / timestamp
    let now = Date()

    //Using: Date formatter
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    let dateString = formatter.string(from: now)
    
    //Concatonate date and log entry text
    text = dateString + "\n" + text + "\n" + "---" + "\n"
    
    //Write / save file to disk
    //Get file directory path using helper method, and set file name to save in directory path
    let logFile = getDocumentsDirectory().appendingPathComponent("Exercise28.txt")
    print("Specific Document / File path: \(logFile)")
    
    //Attempt to load file and contents from disk
    if let savedText = try? String(contentsOf: logFile) {
        
        //If exists append new text string to saved log string
        print("File found, appending file with text")
        text += savedText
        
        do {
            
            //Attempt to append file with new text entry
            try text.write(to: logFile, atomically: true, encoding: String.Encoding.utf8)
            
        } catch {
            print("Failed to write new text to file with error: \(error.localizedDescription)")
                
        }
    
    } else {
    
        //Else attempt to write text to new log file
        do {
            
            //Attempt to write String object to file
            print("File not found, creating new file with first text entry")
            try text.write(to: logFile, atomically: true, encoding: String.Encoding.utf8)
            
        } catch {
            print("Failed to write first text entry to file with error: \(error.localizedDescription)")
        }
    }
}

//var challenge28Result = challenge28(logEntry: "This is a new log entry")

//Optimized answer: with nil coalescing
func challenge28b(message: String, to logFile: String) {

    //Get existing log file or create a new, empty log file if one doesn'r already exist
    var log = (try? String(contentsOfFile: logFile)) ?? ""
    
    //Append Date to log with Date() and String interpolaton
    log.append("\(Date())\n\(message)\n---\n")
    
    do {
        try log.write(toFile: logFile, atomically: true, encoding: .utf8)
        
    } catch {
        print("Failed to wirte log with error: \(error.localizedDescription)")
        
    }
}

//Verification
//var challenge28bResult = challenge28b(message: "This is a new log entry", to: "logFile")
//logFile path: /private/var/folders/xx/c6586yw900nbqzd3tfvcw4vw0000gn/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.Chapter3-Files-27-31--D38D01AD-047F-44CC-955A-CA3200E0685B/logFile


//Challenge 29: Write a function that returns a user's documents directory
//My answer:
number += 1
print("--Challenge \(number)--")

func challenge29(platform: String) -> URL? {
    
    //for iOS: target: path/to/container/Documents
    if platform == "ios" || platform == "iOS" {
    
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentsDirectory.first!
    }

    //for macOS: target path: /Users/simonitalia/Documents
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
            //Same as above, just referencing index 0, rather than built in first element property
        
}

//Verification
//var challenge29Result = challenge29(platform: "iOS")
//print("challenge\(number)Result: \(challenge29Result)")
//
//challenge29Result = challenge29(platform: "macOS")
//print("challenge\(number)Result: \(challenge29Result)")

//Challenge 30: Write a function that accepts a path to documents directory and returns jpegs from that direcrtory created in the last 48 hours
//My answer
number += 1
print("--Challenge \(number)--")
func challenge30(directory: String) -> [String] {
    
    //Instantiate File Manager
    let fm = FileManager.default
    
    //Access app's files / documents directory path
    let paths = fm.urls(for: .documentDirectory, in: .userDomainMask)
        //print(paths)
        //paths as url array
    let path = paths[0]
        //first url path in paths array
    let docsDirectory = paths[0].path
        // just the documents directory path, not file:// path
        //print("Documents Directory: \(docsDirectory)")
    
    //properties to store all files and jpeg file names
    var files = [String]()
    var jpegFiles = [String]()
    
    do {
        
        //Get all files in documents directory
        files = try fm.contentsOfDirectory(atPath: docsDirectory)
//        print("All files in docsDifectory: \(files) \n")
        
        //Pull out just .jpeg/.jpg files from documents directory
        jpegFiles = files.filter { $0.hasSuffix(".jpeg") || $0.hasSuffix(".jpg") }
//        print("jpeg file: \(file)")
        
    } catch {
        print("Failed to read directory with error: \(error.localizedDescription)")
    }
    
//    print("All files in docsDirectory: \(files)\n")
//    print("All jpeg files: \(jpegFiles)\n")
    
    //Get date/time range to search within
    let last12Hrs = Date(timeIntervalSinceNow: -43200) //in seconds
    var recentJPEGS = [String]()
    
    for jpeg in jpegFiles {
        
        //Get each jpeg file names path (as a url)
        let pathURL = path.appendingPathComponent(jpeg)
        //    print("jpeg file url (object) path: \(pathURL)")
        
        //    //Convert url path to string path
        //    let pathString = pathURL.absoluteString
        //    print("jpeg file string (object) path: \(pathString)")
        
        //Get file attributes (need to pass in path URL object as String object)
        do {
            let attributes = try fm.attributesOfItem(atPath: pathURL.path)
            
            for (key, value) in attributes {
                
                //Access file creation date attribute
                if key.rawValue == "NSFileCreationDate" {
                    
                    //Compare file creation date to time period
                    if value as! Date > last12Hrs {
//                        print(jpeg)
                        recentJPEGS.append(jpeg)
                    }
                    //                print("\(key): \(value)")
                }
            }
            
            //        print("jpeg file attributes: \(attributes)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //return just jpegs that are with date range
    return recentJPEGS
}

//Verification
var challenge30Result = challenge30(directory: "Documents")
print("challenge\(number)Result: \(challenge30Result)")

//Optimized answer:
func challenge30b(in directory: String) -> [String] {
    
    //Set access to file manager
    let fm = FileManager.default
    
    //Get directory path as URL
    let directoryURL = URL(fileURLWithPath: directory)
    
    //Get all contents in directory path
    guard let files = try? fm.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else { return [] }
    
    //Pull out jpeg/jpg only files at directory path
    let jpegs = files.filter { $0.pathExtension == "jpg" || $0.pathExtension == "jpeg" }
    
    //Property to store recent jpges
    var recentJPEGS = [String]()
    for jpeg in jpegs {
        
        //Attempt to get jpeg file attributes
        guard let attributes = try? fm.attributesOfItem(atPath: jpeg.path) else { continue }
        
        //Get creationDate attribute of jpeg file
        guard let creationDate = attributes[.creationDate] as? Date else { continue }
        
        //Check age of jpeg creationDate and return if within specified range of now (eg: 12 hours ago)
        if creationDate > Date.init(timeIntervalSinceNow: -60 * 60 * 12)  {
            recentJPEGS.append(jpeg.lastPathComponent)
        }
    }
    
    return recentJPEGS
}

//Verification
var challenge30bResult = challenge30b(in: "Documents")
print("challenge\(number)bResult: \(challenge30bResult)")


//Challenge 31: Copy one directory to another path. Return true if copy of all contents was succesful, or false if copy was unsuccesful or if directory to copy isn't a directory
number += 1
print("--Challenge \(number)--")

//My answer: (Copying files from Docuemnts to new created / custom folder)
func challenge31(copy directory: String, to path: String) -> Bool {

    //Set access to file manager
    let fm = FileManager.default
    
    //Locate directory path to copy files from
    let directoryURL = URL(fileURLWithPath: directory)
    
    //Get list of files (file paths) to copy
    guard let files = try? fm.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else { return false }

        do {
            try fm.copyItem(atPath: directory, toPath: path)
            print("\(directory) copied to \(path) successfully")

        } catch {
            print("Failed to copy \(directory) to \(path) with error: \(error.localizedDescription)")
            return false
        }

    //Get list of files copied in new diretcory and print to console
    let newDirectoryURL = URL(fileURLWithPath: path)
    guard let copiedFiles = try? fm.contentsOfDirectory(at: newDirectoryURL, includingPropertiesForKeys: nil) else { return false }
    print("All files in '\(directory)' copied succssfully to: '\(path)'")
    
    //Check # of files matches # of files copied
    if files.count != copiedFiles.count {
        print("Copy error, some or all files not copied")
        return false
    }
    
    //Return true to signify successful copy of all files
    return true
}

//Verification
//var challenge31Result = challenge31(copy: "Documents", to: "CopyOfDocuments")
//print("challenge\(number)Result: \(challenge31Result)")

//My answer: Copy a specific file only from My Documents directory / path, to another existing directory path
func challenge31c(copyFile filename: String, toDirectory directory: String) -> String {

    //Set access to file manager
    let fm = FileManager.default
    
    //Get path to Documents folder
    let paths = fm.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsURL = paths.first!
    let documents = documentsURL.path
//    print("Documents URL path: \(documentsURL)\n")
    
    //Print contents of Documents folder to verify file exists
    guard let files = try? fm.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil) else { return "No files found" }
    print("Documents files: \(files)\n")
    
    //Get source file path in Documents folder
    let sourceFileURL = URL(fileURLWithPath: "\(documents)/\(filename)")
//    print("Copy file with path: '\(sourceFileURL)'\n")
    
    //Set destination folder and filename to copy to
    let destinationDirURL = documentsURL.appendingPathComponent(directory)
    let destinationDir = "\(documents)/\(directory)"
    
    let destinationURL = destinationDirURL.appendingPathComponent(filename)
//    print("Destination directory path: \(destinationURL)\n")
    
    //Bool flag to store if destination folder exists or not
    var isDirectory: ObjCBool = false
    
    //Check if destination directory exists, if not, create it
    if fm.fileExists(atPath: destinationDir, isDirectory: &isDirectory) == false {
        
        do {
            try fm.createDirectory(at: destinationDirURL, withIntermediateDirectories: true, attributes: nil)
            
            //flip isDirectory flag
            isDirectory = true
            print("New Directory '\(directory)' created successfully")
            
        } catch {
            print("Creating new directory failed with error: \(error.localizedDescription)")
        }
    } else {
        print("Destinaton directory \(directory) already exists, skipping create, continuing")
    }
    
    //Check destination directory was created, if not bail out
    guard fm.fileExists(atPath: destinationDir, isDirectory: &isDirectory) == true else { return "Destination directory does not exist: \(isDirectory)" }
    
    //Perfrom copy of file from Documents folder to destination folder
    do {

        try fm.copyItem(at: sourceFileURL, to: destinationURL)
        print("\(filename) copied to \(directory) successfully\n")

    } catch {
        print("Failed to copy '\(filename)' to '\(directory)' with error: \(error.localizedDescription)\n")
    }
    
    //Return success message
    return "\(filename) copied to \(directory) successfully\n"

}

//Verification
//let challenge31cResult = challenge31c(copyFile: "logFile.txt", toDirectory: "SubFolder")
//print("challenge\(number)cResult: \(challenge31cResult)")


//Challenge 32: Return the frequency of a specified word contained in a file on disk, loads
number += 1
print("--Challenge \(number)--")

//My answer
func challenge32(filename: String, inDirectory directory: String, wordToCount word: String) -> (word: String, frequency: Int, error: String?) {
    
    var fileContents = String()
    
    //Load  .txt file from Playground resources
    guard let filepath = Bundle.main.path(forResource: filename, ofType: "txt", inDirectory: directory)  else {
        
        //Abort with error if file or file directory not found
        let error = "Failed to find file or file directory"
        return (word: "", frequency: 0, error: error)
    }
        
    do {
        //Attempt to load contents of file as String object
        fileContents = try String(contentsOfFile: filepath)
//        print("fileContents: \(fileContents)")
        
    } catch {
        //Abort with error if file contents is empty
        let error = "File contents failed to load with error: \(error.localizedDescription)"
            return (word: "", frequency: 0, error: error)
    }
    
    //Get arrray of all non-letters inside String object
    let nonLetters = fileContents.filter { !$0.isLetter }
//    print(nonLetters)
    
    //Convert word to array, seperated by non-letters
    let words = fileContents.components(separatedBy: CharacterSet(charactersIn: nonLetters))
//    print(words.sorted())
    
    //Count apperance of word
    let count = words.filter( { $0 == word } ).count
//    print("Word count: \(count)")
    
    //Return tuple object
    return (word: word, frequency: count, error: nil)
}

//Verification
var challenge32Result = challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Spain")
print("challenge\(number)Result: \(challenge32Result)")

challenge32Result = challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Hello")
print("challenge\(number)Result: \(challenge32Result)")


//Tests
//Test counts of words in file
assert(challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Spain") == (word: "Spain", frequency: 3, error: nil), "Challenge \(number) failed")
assert(challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Hello") == (word: "Hello", frequency: 4, error: nil), "Challenge \(number) failed")

//Test count of word not in file
assert(challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Blah") == (word: "Blah", frequency: 0, error: nil), "Challenge \(number) failed")
assert(challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Hello,") == (word: "Hello,", frequency: 0, error: nil), "Challenge \(number) failed")
assert(challenge32(filename: "Exercise32", inDirectory: "Exercise32", wordToCount: "Spain,") == (word: "Spain,", frequency: 0, error: nil), "Challenge \(number) failed")

//Test filename not found
assert(challenge32(filename: "ExerciseXX", inDirectory: "Exercise32", wordToCount: "Hello") == (word: "", frequency: 0, error: "Failed to find file or file directory"), "Challenge \(number) failed")

//Test file directory path not found
assert(challenge32(filename: "Exercise32", inDirectory: "ExerciseXX", wordToCount: "Hello") == (word: "", frequency: 0, error: "Failed to find file or file directory"), "Challenge \(number) failed")


//Optimized answer:
func challenge32b(filename: String, word: String) -> Int {
    
    guard let filepath = Bundle.main.path(forResource: filename, ofType: "txt", inDirectory: "Exercise32")  else { return 0 }
    
    guard let inputString = try? String(contentsOfFile: filepath) else { return 0 }
    var nonletters = CharacterSet.letters.inverted
    nonletters.remove("'")
    
    let allWords = inputString.components(separatedBy: nonletters)
    let wordsSet = NSCountedSet(array: allWords)
    
    return wordsSet.count(for: word)
}

//Verification:
var challenge32bResult = challenge32b(filename: "Exercise32", word: "Spain")
print("challenge\(number)bResult: \(challenge32bResult)")

//Challenge 33: Scan a directory inside Playground Resources and return an array of duplicate filenames
number += 1
print("--Challenge \(number)--")

//My answer: Scan a directory inside Playground Resources
func challenge33(scanDirectory directory: String) -> [String] {

    //Get path to Resources folder and append with directory to scan.
    let paths = Bundle.main.paths(forResourcesOfType: nil, inDirectory: directory)
//    print(paths)
    
//    guard let urlPaths = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: directory) else { return [] }
//    print("urlPaths: \(urlPaths)")
   
    //Instantiate FileManager object
    let fm = FileManager.default
    
    //Property to store all files found in sub directories of directory
    var files = [String]()

    //Iterate through each path (sub directory) and pull out items
    for path in paths {
//        guard let files = fm.subpaths(atPath: path) else { continue }
        guard let items = (try? fm.contentsOfDirectory(atPath: path)) else { continue }
        
        //Iterate through items to pull out each file
        for item in items {
//            print("Found item: \(item)")
            files.append(item)
        }
    }
    print("File list of all files found: \(files)")
    
    //Identify duplicate filenames
    //Transform each files string object to a tuple key-value pair object where 1 is the value component.
    let mappedFilenames = files.map { ($0, 1) }
//    print(mappedFilenames)
    
    //Create Dictionary from Tuple array, incrementing adding value component each time the same key string (filename) is found.
    let filenameCounts = Dictionary(mappedFilenames, uniquingKeysWith: +)
//    print(filenameCounts)
    
    //Pullout key-value objects using filter() where .value > 1
    let duplicates = filenameCounts.filter( { $0.value > 1 } )
//    print(duplicates)
    
    return Array(duplicates.keys)
}

//Verification:
var challenge33Result = challenge33(scanDirectory: "Exercise33")
print("challenge\(number)Result: \(challenge33Result)")


