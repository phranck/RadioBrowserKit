//
//  File.swift
//
//  Created by Frank Gregor on 25.04.21.
//

import Foundation

extension URL {
    
    func append(queryParameters parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    
}
