//
//  Created by Frank Gregor on 24.11.20.
//

import Foundation

public struct RadioStation: Hashable, Identifiable {
    public var id: Int
    public var uuid: String
    public var name: String
    public var description: String?
    public var streamUrl: String
    public var websiteUrl: String?
    public var coverUrl: String?
    public var countryCode: String?
    public var codec: String?
    public var bitrate: Int?
}

extension RadioStation: Codable {

    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case uuid        = "uuid"
        case name        = "name"
        case description = "description"
        case streamUrl   = "streamUrl"
        case websiteUrl  = "websiteUrl"
        case coverUrl    = "coverUrl"
        case countryCode = "countryCode"
        case codec       = "codec"
        case bitrate     = "bitrate"
    }

}

extension RadioStation: Equatable {

    public static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.id == rhs.id
    }

}
