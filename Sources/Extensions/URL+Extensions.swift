//
//  Created by Frank Gregor on 24.03.21.
//

import Foundation

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension URL {
    
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
    
}
