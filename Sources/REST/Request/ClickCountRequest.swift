import Foundation

internal class ClickCountRequest: ApiFetch {
    internal func updateClickCount(for stationUUID: String, completion: ((RadioBrowser.ClickCount?) -> Void)? = nil) {
        var resource = ClickCountResource()
        resource.path = stationUUID

        performRequest(with: resource) { result in
            if let completion = completion {
                completion(result)

                if let clickCount = result {
                    RadioBrowserAPI.delegate?.radioBrowser(self.api, didUpdateClickCount: clickCount)
                }
            }
        }
    }
}
