import Foundation

internal enum ApiEndpoints: String {
    case add
    case checks
    case clicks
    case clickCount = "url"
    case codecs
    case config
    case countries
    case countryCodes = "countrycodes"
    case languages
    case servers
    case states
    case stations
    case stationsByName = "stations/byname"
    case stationsByCountryCode = "stations/bycountrycodeexact"
    case stationsBroken = "stations/broken"
    case stationsChanged = "stations/changed"
    case stationsLastChange = "stations/lastchange"
    case stationsLastClick = "stations/lastclick"
    case stationsSearch = "stations/search"
    case stationsTopClick = "stations/topclick"
    case stationsTopVote = "stations/topvote"
    case stats
    case tags
    case vote
}
