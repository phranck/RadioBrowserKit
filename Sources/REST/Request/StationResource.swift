import Foundation

struct StationResource: ApiResource {
    typealias ModelType = [RadioBrowser.Station]

    var endpoint: ApiEndpoints
    var path: String?
    var seconds: Int?

    var name: String?
    var nameExact: Bool?
    var country: String?
    var countryExact: Bool?
    var countryCode: String?
    var state: String?
    var stateExact: Bool?
    var language: String?
    var languageExact: Bool?
    var tag: String?
    var tagExact: Bool?
    var tagList: String?
    var codec: String?
    var bitrateMin: Int?
    var bitrateMax: Int?
    var hasGeoInfo: Bool?
    var hasExtendedInfo: Bool?
    var order: ApiResponseOrder?
    var reverse: Bool?
    var offset: Int?
    var limit: Int?
    var hideBroken: Bool?
}
