import Foundation

internal protocol NetworkRequest {
    associatedtype ModelType

    func decode(_ data: Data, withCompletion completion: @escaping (Result<ModelType?, RadioBrowserError>) -> Void)
    func execute(withCompletion completion: @escaping (Result<ModelType?, RadioBrowserError>) -> Void)
}

extension NetworkRequest {
    internal func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType?, RadioBrowserError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 5
        request.cachePolicy = .returnCacheDataElseLoad
        request.addValue(RadioBrowserAPI.httpUserAgent, forHTTPHeaderField: "User-Agent")

        log.debug(request)

        RadioBrowserAPI.delegate?.radioBrowser(willStartRequest: request)

        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
                if let error = error {
                    completion(.failure(RadioBrowserError.urlSessionDataTask(error: error)))
                    RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)
                    return
                }

                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    let error = RadioBrowserError.invalidHTTPURLResponse
                    completion(.failure(error))
                    RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)
                    return
                }

                guard let data = data else {
                    let error = RadioBrowserError.invalidResponseData
                    completion(.failure(error))
                    RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)
                    return
                }

                switch statusCode {
                    case 200:
                        self.decode(data, withCompletion: { result in
                            switch result {
                                case .success(let result):
                                    completion(.success(result))
                                case .failure(let error):
                                    completion(.failure(RadioBrowserError.jsonDecoding(error: error)))
                                    RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)
                            }
                        })

                    case 503:
                        let error = RadioBrowserError.http503ServiceUnavailable(error: error)
                        completion(.failure(error))
                        RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)

                    default:
                        let error = RadioBrowserError.unhandledStatusCode(statusCode: statusCode)
                        completion(.failure(error))
                        RadioBrowserAPI.delegate?.radioBrowser(endRequest: request, withError: error)
                }
            }
            task.resume()
        }
    }
}
