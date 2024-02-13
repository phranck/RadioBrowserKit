import Foundation

internal class RadioBrowserServer {
    internal var servers: () -> [String]

    init(servers: @escaping () -> [String] = { String.defaultServers }) {
        self.servers = servers
        log.debug("[\(RadioBrowserServer.self)] initialised")
    }

    var host: String {
        return servers().randomElement() ?? String.defaultServers.randomElement()!
    }
}

public extension String {
    static let defaultServers: [String] = [
        "nl1.api.radio-browser.info",
        "at1.api.radio-browser.info",
        "de1.api.radio-browser.info"
    ]
}
