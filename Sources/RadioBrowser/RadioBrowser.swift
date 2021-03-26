//
//  RadioBrowser.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation
import RapidAPI
import SwiftyBeaver
let log = SwiftyBeaver.self

public typealias RadioStationsCompletion = (Result<[RadioStation], Error>) -> Void

public class RadioBrowser: NSObject {
    public static let version = "0.1.0"
    public static let build = 1
    
    private var agentName: String = "n/a"
    private var agentVersion: String = version
    
    required public init(agent: String = "\(RadioBrowser.self)", version: String = "\(RadioBrowser.version)") {
        agentName = agent
        agentVersion = version
    }
    
    // MARK: - Private Helper
    
    internal func stations(for endpoint: String, queryParameters: Dictionary<String, String> = [:], completion: @escaping RadioStationsCompletion) {
        var request: URLRequest!

        do {
            request = try self.request(for: endpoint, queryParameters: queryParameters)
        } catch {
            completion(.failure(error))
        }
        
        log.debug("Performing request: \(request.url!)")

        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            guard let responseData = data else {
                completion(.failure(RadioBrowserError.invalidResponseData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([RadioStation].self, from: responseData)
                completion(.success(result))
            } catch let error {
                completion(.failure(RadioBrowserError.undefined(error: error)))
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func request(for endpoint: String, queryParameters: Dictionary<String, String>) throws -> URLRequest {
        let urlString = Constants.API.JSON + endpoint
        guard var requestUrl = URL(string: urlString) else {
            throw RadioBrowserError.malformedURLString(urlString: urlString)
        }
        
        if !queryParameters.isEmpty {
            requestUrl = requestUrl.append(queryParameters: queryParameters)
        }
        
        let headers = [
            "x-rapidapi-key": RapidAPI.key,
            "x-rapidapi-host": RapidAPI.host
        ]
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.addValue("\(agentName)/\(agentVersion)", forHTTPHeaderField: "User-Agent")
        request.cachePolicy = .reloadRevalidatingCacheData
        
        return request
    }
}

extension RadioBrowser: URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
    
}
