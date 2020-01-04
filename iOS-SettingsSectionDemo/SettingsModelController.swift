//
//  SettingsModelController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/3/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class SettingsModelController {
    
    public private(set) var settingItems: [[String: Any]]? = [
        ["SettingName": "Display Language",
         "SettingOptions": ["English", "French", "Romanian", "Russian"],
         "SelectedOption": "English"],
        ["SettingName": "Profile Visibility",
         "SettingOptions": ["Private", "Public"],
         "SelectedOption": "Private"],
        ["SettingName": "Receive Notifications",
         "SettingOptions": ["Yes", "No"],
         "SelectedOption": "No"],
        ["SettingName": "Share Location",
         "SettingOptions": ["Yes", "No"],
         "SelectedOption": "No"],
        ["SettingName": "Information Pages",
         "SettingOptions": ["Terms and Conditions", "Privacy Policy"],
         "HasDisclosureIndicator": true]
    ]

    public func updateSelectedOptionFor(section sectionIndex: Int,
                                        optionIndex: Int) {
        if let settingItem = settingItems?[sectionIndex],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            settingItems?[sectionIndex]["SelectedOption"] = settingOptions[optionIndex]
        }
    }
    
    public func numberOfSettings() -> Int {
      return settingItems?.count ?? 0
    }
    
    public func numberOfOptionsInSection(section: Int) -> Int {
        if let settingItem = settingItems?[section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            return settingOptions.count
        }
        return 0
    }
    
    public func settingOptionFor(indexPath: IndexPath) -> String? {
        if let settingItem = settingItems?[indexPath.section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            return settingOptions[indexPath.row]
        }
        return nil
    }
    
    public func isSelectedOptionAt(indexPath: IndexPath) -> Bool {
        if let settingItem = settingItems?[indexPath.section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            if let selectedOption = settingItem["SelectedOption"] as? String {
                if settingOptions.firstIndex(of: selectedOption) == indexPath.row {
                    return true
                }
            }
        }
        return false
    }
    
    public func isInfoPageOptionAt(indexPath: IndexPath) -> Bool {
        if let settingItem = settingItems?[indexPath.section] {
            if settingItem["HasDisclosureIndicator"] as? Bool ?? false {
                return true
            }
        }
        return false
    }
    
    public func settingNameForSection(section: Int) -> String? {
        if let settingItem = settingItems?[section],
            let settingName = settingItem["SettingName"] as? String {
            return settingName
        }
        return nil
    }
}
