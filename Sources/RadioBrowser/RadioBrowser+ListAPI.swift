//
//  File.swift
//
//  Created by Frank Gregor on 26.03.21.
//

import Foundation

extension RadioBrowser {
    
    public func allStations(completion: @escaping RadioStationsCompletion) {
        
    }
    
    public func stationsForCountryCode(_ countryCode: String, completion: @escaping RadioStationsCompletion) {
        let endpoint = "/stations/\(countryCode.lowercased())"
        stations(for: endpoint) { result in
            do {
                let stations = try result.get()
                completion(.success(stations))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
