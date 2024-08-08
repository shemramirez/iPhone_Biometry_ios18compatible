//
//  FileSave.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/08/08.
//

import Foundation

protocol Initiable {
    init()
}

class FileSave {
    
    static func load<T>(_ path: String) -> T? where T: Codable {
        let destination = FileManager.SearchPathDirectory.cachesDirectory
        if let dir = FileManager.default.urls(for: destination, in: .userDomainMask).first {
            // returns the url
            let path = dir.appendingPathComponent(path)
            
            do {
                let decode = JSONDecoder()
                let json = try String(contentsOf: path, encoding: .utf8)
                return try decode.decode(T.self, from: json.data(using: .utf8)!)
            }
            catch {
                // cant see you domain
                print("JSONDecode has failed = \(error)")
            }
        }
        
        // there no return
        return nil
    }
    
    static func save<T>(_ object: T, _ path: String)where T: Codable, T: Initiable{
        
        // user -> temporary
        let destination = FileManager.SearchPathDirectory.cachesDirectory
        
        if let dir = FileManager.default.urls(for: destination, in: .userDomainMask).first {
            // returns the url
            let path = dir.appendingPathComponent(path)
            
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                let data = try encoder.encode(object)
                let json = String(data: data, encoding: .utf8) // changing the data into 8bit variable length
                
                try json?.write(to: path, atomically: false, encoding: .utf8)
            } catch {
                print("JSONEncoder has failed \(error) ")
            }
            
        }
    }
    
}
