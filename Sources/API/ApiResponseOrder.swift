import Foundation

public enum ApiResponseOrder: String {
    case name
    case url
    case homepage
    case favicon
    case tags
    case country
    case state
    case language
    case votes
    case codec
    case bitrate
    case lastCheckok = "lastcheckok"
    case lastCheckTime = "lastchecktime"
    case clickTimestamp = "clicktimestamp"
    case clickCount = "clickcount"
    case clickTrend = "clicktrend"
    case changeTimestamp = "changetimestamp"
    case random
}
