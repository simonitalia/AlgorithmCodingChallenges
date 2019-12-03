import Foundation
import PlaygroundSupport
import XCTest

var number = 33

//Challenge 34: Return all executable file names within a given directory (eg: Resources folder). Do not include exe files in the directory's sub-diretory/ies or the names of sub-directories
number += 1
print("--Challenge \(number)--")

//My answer
func challenge34(scanDirectory directory: String) -> [String] {
    
    //Instantiate FileManager object
    let fm = FileManager.default

    //Get path to Resources folder and pass in folder to scan
    let paths = Bundle.main.paths(forResourcesOfType: nil, inDirectory: directory)
//    print("Paths: \(paths)\n")

    var executableFiles = [String]()
    for path in paths {
        
        //Detect if file at path is a directory and if so, skip file
        let file = URL(fileURLWithPath: path)
        guard file.hasDirectoryPath == false else { continue }
        
//        var isDirectory: ObjCBool = false
//        guard fm.fileExists(atPath: path, isDirectory: &isDirectory) && isDirectory.boolValue == false else {
////            print("File for path: \(path) is a directory, skipping\n")
//                continue
//            }

        //For files that are not directory, check if file is executable
        if fm.isExecutableFile(atPath: path) {
//            print("File at path: \(path), is executable\n")
//            let filename = URL(fileURLWithPath: path)
        
            //Append to executable array
            executableFiles.append(file.lastPathComponent)
        }
        else {
//            print("File at path: \(path), not executable\n")
        }
    }
//    print("Executable files: \(executableFiles)\n")

    return executableFiles
}

//Verification:
var challenge34Result = challenge34(scanDirectory: "Exercise34")
print("challenge\(number)Result: \(challenge34Result)")


//Challenge 35: Copy and convert a set of jpeg files to png files (leave originals as is)
number += 1
print("--Challenge \(number)--")

func challenge35(convertFilesIn sourceDirectory: String, to destinationDirectory: String) -> Bool {

    //Instantiate FileManager object
    let fm = FileManager.default
    
    //Get paths to sourceDirectory contents as urls
    let urlPaths = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: sourceDirectory)
//    print("Url paths: \(urlPaths ?? [] )\n")

    //Property to store Url paths to jpeg files
    var jpegs = [URL]()
    var filenames = [String]()
    
    //Get contents inside each url path
    for urlPath in urlPaths! {
        
        guard let contents = (try? fm.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil)) else { continue }
//        print("Contents: \(contents)\n")
        
        //Pull out url paths to just .jpeg/.jpg files
        jpegs = contents.filter({$0.pathExtension == "jpeg" || $0.pathExtension == "jpg"})
        
        //Get filenames
        let names = jpegs.map( { $0.deletingPathExtension() } )
        filenames = names.map( { $0.lastPathComponent } )
        
    }
    
//    print("Source jpeg files: \(jpegs)\n")
//      print("jpeg filenames: \(filenames)\n")
    
    //Convert source jpeg file to png
    for (index, jpeg) in jpegs.enumerated() {

        //Load jpeg file as tiff Data Object
        guard let image = NSImage(contentsOf: jpeg) else { continue }
        
        //Convert image to tiff Data object
        guard let tiffData = image.tiffRepresentation else { continue }

        //Convert tiffData to imageRep
        guard let imageRep = NSBitmapImageRep(data: tiffData) else { continue }
        
        // Convert imageRep object to png Data object
        guard let png = imageRep.representation(using: .png, properties: [:]) else { continue }

//            Save Data object to disk as png
        do {
            //Set .filename to save as
            let filename = filenames[index] + ".png"
//                print("png filename: \(filename)\n")
        
            //Set Destination directory url path to save to
            
            //A. Desktop location (remember to create sub folder/s)
//                let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
//
//                let destinationPathURL = desktop.appendingPathComponent(destinationDirectory)
//
//                print("Destination save path: \(destinationPathURL)")
//
//                //Write png filename to destination url path
//                try png?.write(to: destinationPathURL.appendingPathComponent(filename))
            
            //--OR--
            
            //B. Resources folder (ensure folder passed in  as param exists)
            let resourcesPathURL = jpeg.deletingLastPathComponent().appendingPathComponent(destinationDirectory)
            
//            print("Destination save path: \(resourcesPathURL.lastPathComponent)")
            
            //Write / save png filename to destination url path
            try png.write(to: resourcesPathURL.appendingPathComponent(filename))
            
            //Print success message to console
            print("Image file '\(jpeg.lastPathComponent)' converted and saved successfully to directory: '\(resourcesPathURL.lastPathComponent)'\n")

        } catch {
            print("Failed to convert image file '\(jpeg.lastPathComponent)' to png.")
            print("Reason: \(error.localizedDescription)\n")
            continue
        }
    }
    
    //Return true if conversion of files succeeds
    return true
    
}

//Verification:
//var challenge35Result = challenge35(convertFilesIn: "Exercise35", to: "ConvertedToPNG")
//print("challenge\(number)Result: \(challenge35Result)")


//Challenge 36: Write a function that scans a log file and returns how many occurrences of ["ERROR"] occur
number += 1
print("--Challenge \(number)--")

//My answer:

func challenge36(filename: String, inFolder directory: String) -> String {
    
    //Get path to log file in source Directory
    guard let filePath = Bundle.main.path(forResource: filename, ofType: "txt", inDirectory: directory) else { return "" }
//    print("File path: \(filePath)\n")
    
    let fileURLPath = URL(fileURLWithPath: filePath)
//    print("File URL Path: \(fileURLPath)\n")
    

    //Call helper function to load and scan log file for errors
    var errors = 0
    let reader = ChunkedFileReader(urlPath: fileURLPath)
    while let line = reader.readLine() {
        if line.hasPrefix("ERROR") {
            errors += 1
        }
    }
 
    return "Errors found in '\(filename)' file: \(errors)"
}


//Streaming data helper Class and method
class ChunkedFileReader {
    
    //Property to store contents of Log file as Data object
    var fileHandle: FileHandle?
    var buffer: Data //Add to buffer until line break is found
    let chunkSize: Int = 5 //# of lines to read at a time
    let delimiter = "/n".data(using: .utf8)! //line end delimiter delimiter
    
    init(urlPath: URL) {
        do {
        fileHandle = try? FileHandle(forReadingFrom: urlPath)
        buffer = Data(capacity: chunkSize)
        
        }
//        } catch {
//            print("Error loading file with error...\n")
//            print(error.localizedDescription)
//
//        }
        
    }
    
    func readLine() -> String? {
        
        //Loop until we find end of of line delimiter
        var rangeOfDelimiter = buffer.range(of: delimiter)
        
        //read chunk of Data object or exit if error
        while rangeOfDelimiter == nil {
            guard let chunk = fileHandle?.readData(ofLength: chunkSize) else { return nil }
            
            if chunk.count == 0 {
                if buffer.count > 0 {
                    defer { buffer.count = 0 }
                    return String(data: buffer, encoding: .utf8)
                }
                return nil
                
            } else {
                buffer.append(chunk)
                rangeOfDelimiter = buffer.range(of: delimiter)
            }
        }
        
        let rangeOfLine = 0..<rangeOfDelimiter!.upperBound
        let line = String(data: buffer.subdata(in: rangeOfLine), encoding: .utf8)
        buffer.removeSubrange(rangeOfLine)
        
        return line?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


//Verification:
var challenge36Result = challenge36(filename: "Log", inFolder: "Exercise36")
print("challenge\(number)Result: \(challenge36Result)")



