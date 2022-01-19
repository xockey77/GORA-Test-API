//
//  Parser.swift
//  GORA Test API
//
//  Created by username on 18.01.2022.
//

import Foundation

class Parser {
    
    static func parseArray<T: Decodable>(data: Data, type: T) -> [T] {
        do {
            var results: [T] = []
            
            let decoder = JSONDecoder()
            results = try decoder.decode([T].self, from: data)
            return results
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}

