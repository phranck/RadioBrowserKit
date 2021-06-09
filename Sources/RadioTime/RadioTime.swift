//
//  RadioTime.swift
//
//  Created by Frank Gregor on 24.11.20.
//

import Combine
import Foundation
import SwiftyBeaver
import SwiftUI
let log = SwiftyBeaver.self

public class RadioTime: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
//    private var categoriesPublisher: AnyPublisher<Response, Error>
    
    @Published public var categories: [RadioCategory] = []
    
    public init() {
//        self.cancellable = nil
    }

    public func fetchCategories(url: String) throws {
        guard let url = URL(string: url) else {
            throw RadioTimeError.malformedURLString(urlString: url)
        }
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                        response.statusCode == 200 else {
                    throw RadioTimeError.httpStatusCode
                }
                return output.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        log.debug("fetchCategories complete")
                        break
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                }
            }, receiveValue: { response in
                print(response.body)
                self.categories = response.body
            })
        
        cancellables.insert(cancellable)
    }
    
}
