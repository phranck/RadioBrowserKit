import Foundation

internal class ApiRequest<Resource: NetworkResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<Resource.ModelType?, RadioBrowserError>) -> Void) {
        load(resource.url, withCompletion: completion)
    }

    func decode(_ data: Data, withCompletion completion: @escaping (Result<Resource.ModelType?, RadioBrowserError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        do {
            let stations = try decoder.decode(Resource.ModelType.self, from: data)
            completion(.success(stations))
            
        } catch let error {
            completion(.failure(RadioBrowserError.jsonDecoding(error: error)))
        }
    }
}
