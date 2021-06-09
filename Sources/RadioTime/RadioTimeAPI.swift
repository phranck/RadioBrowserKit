//
//  Created by Frank Gregor on 09.06.21.
//

import Foundation

public struct RadioTimeAPI {
    public static let baseUrl: String = "https://opml.radiotime.com"
    public static let Browse: String = "\(baseUrl)/Browse.ashx?render=json"
    public static let Search: String = "\(baseUrl)/Search.ashx?render=json"
    
    public enum CategoryKey: String {
        case local
        case music
        case talk
        case sports
        case podcast
        case lang
    }
}
