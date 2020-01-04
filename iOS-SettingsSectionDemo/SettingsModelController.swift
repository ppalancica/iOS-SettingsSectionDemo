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
}
