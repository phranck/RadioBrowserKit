//
//  Created by Frank Gregor on 09.06.21.
//

import Foundation

public struct Response: Hashable, Codable {
    public var head: Head
    public var body: [RadioCategory]
}
