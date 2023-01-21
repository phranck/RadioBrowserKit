import Foundation

internal class RadioBrowserServer {
    private var index = 0

    init() {
        log.debug("[\(RadioBrowserServer.self)] initialised")
    }

    /// TODO: This MUST be changed by requesting the API to return a list available servers!
    private let servers: [String] = [
        "de1.api.radio-browser.info",
        "nl1.api.radio-browser.info",
        "fr1.api.radio-browser.info"
    ]

    /// Simple and stupid round robin over the server array.
    var host: String {
        index = index + 1 < servers.count ? index + 1 : 0
        return servers[index]
    }
}
