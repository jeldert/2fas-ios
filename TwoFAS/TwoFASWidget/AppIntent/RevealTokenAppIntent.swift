//
//  This file is part of the 2FAS iOS app (https://github.com/twofas/2fas-ios)
//  Copyright © 2024 Two Factor Authentication Service, Inc.
//  Contributed by Zbigniew Cisiński. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program. If not, see <https://www.gnu.org/licenses/>
//

import SwiftUI
import UIKit
import AppIntents
import Protection
import TimeVerification
import Common
import Data

struct RevealTokenAppIntent: AppIntent {
    static var title = LocalizedStringResource("widget__token")
    
    @Parameter(title: "Secret")
    var secret: String
    
    init() {}
    
    init(secret: String) {
        self.secret = secret
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults.standard
        defaults.set(Date().timeIntervalSince1970, forKey: CommonKeys.tapDate)
        defaults.set(secret, forKey: CommonKeys.tapSecret)
        defaults.synchronize()
        
        return .result()
    }
}
