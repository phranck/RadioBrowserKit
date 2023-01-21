import Foundation

public enum RadioBrowserError: Error {
    /// Zen-Mode, everything is fine.
    case none
    /// Uncategorized error, so we passthrough it.
    case undefined(error: Error)
    case urlSessionDataTask(error: Error)
    case unhandledStatusCode(statusCode: Int)
    /// Thrown when `data` response on `URLSession.dataTask(..)` isn't readable
    case invalidResponseData
    case invalidHTTPURLResponse
    case jsonDecoding(error: Error)
    case malformedURLString(String)
    case http503ServiceUnavailable(error: Error?)
}
