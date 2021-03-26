//
//  Created by Frank Gregor on 25.03.21.
//

import Foundation

public enum RadioBrowserError: Error {
    case undefined(error: Error)
    /// Thrown when `data` response on `URLSession.dataTask(..)` isn't readable
    case invalidResponseData
    case malformedURLString(urlString: String)
}

extension RadioBrowserError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .undefined:
                return "Undefined error occured"
            case .invalidResponseData:
                return "Unable to read response data"
            case .malformedURLString(let urlString):
                return "Malformed URL string: \(urlString)"
        }
    }
}
