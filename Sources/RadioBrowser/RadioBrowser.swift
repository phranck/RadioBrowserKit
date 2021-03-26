//
//  RadioBrowser.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

public typealias RadioStationsCompletion = (Result<[RadioStation], Error>) -> Void

public class RadioBrowser {
    public static let version = "1.0.0"
    public static let build = 1
    
    private let agentName: String!
    private let agentVersion: String!
    
    required public init(agent: String = "\(RadioBrowser.self)", version: String = "\(RadioBrowser.version)") {
        agentName = agent
        agentVersion = version
        
        log.info("\(RadioBrowser.self) with agent: agent: \(agent)/\(version)")
    }

    public func stationsForCountryCode(_ countryCode: String, completion: @escaping RadioStationsCompletion) {
        getStations(endpoint: "/stations/bycountrycodeexact/\(countryCode.lowercased())") { result in
            do {
                let stations = try result.get()
                completion(.success(stations))
            }
            catch {
                completion(.failure(error as! RadioBrowserError))
            }
        }
    }
    
    private func getStations(endpoint: String, completion: @escaping RadioStationsCompletion) {
        let urlString = Constants.API.apiUrl + endpoint
        guard let requestUrl = URL(string: urlString) else {
            completion(.failure(RadioBrowserError.malformedURLString(urlString: urlString)))
            return
        }
        
        log.debug("requestUrl: \(requestUrl.absoluteString)")
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadRevalidatingCacheData
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let responseData = data else {
                completion(.failure(RadioBrowserError.invalidResponseData))
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                let result = try decoder.decode([RadioStation].self, from: responseData)
                completion(.success(result))
            }
            catch {
                completion(.failure(RadioBrowserError.undefined(error: error)))
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
