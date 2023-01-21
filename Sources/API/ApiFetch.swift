import Foundation

internal protocol ApiFetchable {
    func fetchStations()
}

public class ApiFetch: ApiFetchable {
    public let api: RadioBrowserAPI

    public init(api: RadioBrowserAPI) {
        self.api = api
    }

    internal func performRequest<Resource: NetworkResource>(with resource: Resource, withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        let request = ApiRequest(resource: resource)
        request.execute { result in
            switch result {
                case .success(let result):
                    completion(result)

                case .failure(let error):
                    log.error(error)
                    completion(nil)
                    break
            }
        }
    }

    // MARK: - ApiFetchable

    func fetchStations() {}
}
