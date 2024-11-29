//
//  TheChannels
//
//  Created by Utsav on 29/11/24.
//

import Foundation

extension NSError {
    func isNetworkConnectionError() -> Bool {
        let networkErrors = [
            NSURLErrorResourceUnavailable,
            NSURLErrorDNSLookupFailed,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorTimedOut
        ]
        return domain == NSURLErrorDomain && networkErrors.contains(self.code)
    }
}
