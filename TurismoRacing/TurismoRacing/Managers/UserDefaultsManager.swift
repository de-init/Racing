//
//  UserDefaultsManager.swift
//  TurismoRacing
//
//  Created by S2 on 30.09.22.
//

import Foundation
import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    func saveSettings(settings: Settings) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(settings)
            UserDefaults.standard.set(data, forKey: "settings")
        } catch {
            print(error)
        }
    }
    
    func getSettings() -> Settings {
        var settings = Settings()
        guard let data = UserDefaults.standard.data(forKey: "settings") else {
            return Settings()
        }
        do {
            let decoder = JSONDecoder()
            settings = try decoder.decode(Settings.self, from: data)
        } catch {
            print(error)
        }
        return settings
    }
}
