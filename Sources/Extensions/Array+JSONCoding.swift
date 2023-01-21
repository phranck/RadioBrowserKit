import Foundation

extension Array where Element: Codable {
    public init?(data: Data) {
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            self = result
            return

        } catch {
            log.error(error)
        }
        return nil
    }

    public var data: Data {
        guard let data = try? JSONEncoder().encode(self) else {
            fatalError("Could not JSONEncode Array: \(self)")
        }
        return data
    }
}

extension Encodable {
    public var jsonString: String? {
        guard let data = try? JSONEncoder().encode(self) else {
            fatalError("Could not JSONEncode element: \(self)")
        }
        return String(data: data, encoding: .utf8)
    }
}
