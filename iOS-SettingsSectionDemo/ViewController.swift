//
//  ViewController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/2/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var settingItems: [[String: Any]]? = [
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
    
    private var settingsTableView: UITableView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createViewsHierarchy()
        configureViewsConstraints()
    }
    
    private func createViewsHierarchy() {
        settingsTableView = UITableView(frame: .zero, style: .grouped)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        view.addSubview(settingsTableView)
    }
    
    private func configureViewsConstraints() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: UITableViewDataSource methods

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let settingItem = settingItems?[section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            return settingOptions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        if let settingItem = settingItems?[indexPath.section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            cell.textLabel?.text = settingOptions[indexPath.row]
            // Verify if current Section can contain a Checkmarked row
            if let selectedOption = settingItem["SelectedOption"] as? String {
                if settingOptions.firstIndex(of: selectedOption) == indexPath.row {
                    cell.accessoryType = .checkmark
                }
            }
            // Verify if current Section should display Disclosure Indicator icons on its rows
            else if settingItem["HasDisclosureIndicator"] as? Bool ?? false {
                cell.accessoryType = .disclosureIndicator
            }
        }
        return cell
    }
}

// MARK: UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let settingItem = settingItems?[section],
            let settingName = settingItem["SettingName"] as? String {
            return settingName
        }
        return nil
    }
}
