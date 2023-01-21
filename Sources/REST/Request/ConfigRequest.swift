import Foundation

internal class ConfigRequest: ApiFetch {
    internal func backendConfig(completion: @escaping (RadioBrowser.Config?) -> Void) {
        let resource = ConfigResource()

        performRequest(with: resource) { config in
            completion(config)

            if let config = config {
                RadioBrowserAPI.delegate?.radioBrowser(self.api, receivedConfig: config)
            }
        }
    }
}
