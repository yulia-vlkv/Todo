//
//  ThemeSettings.swift
//  Todo
//
//  Created by Iuliia Volkova on 05.07.2023.
//

import SwiftUI

// MARK: - Theme Class

class ThemeSettings: ObservableObject {
    
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
}
