//
//  Created by Frank Gregor on 24.03.21.
//

import Foundation
import RapidAPI

public struct Constants {

    public struct API {
        static let baseUrl: String = "https://\(RapidAPI.host)"
        static let JSON: String = "\(baseUrl)/json"
        static let XML: String = "\(baseUrl)/xml"
    }

}

public struct ModelDefaults {
    static let NoId: Int = -1
    static let EmptyString: String = ""
}
