//
//  SettingsViewController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/2/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let modelController = SettingsModelController()
    
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

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelController.settingItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if let settingItem = modelController.settingItems?[section],
            let settingOptions = settingItem["SettingOptions"] as? [String] {
            return settingOptions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        if let settingItem = modelController.settingItems?[indexPath.section],
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

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        if let settingItem = modelController.settingItems?[section],
            let settingName = settingItem["SettingName"] as? String {
            return settingName
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let settingItem = modelController.settingItems?[indexPath.section],
           let settingOptions = settingItem["SettingOptions"] as? [String] {
           if settingItem["HasDisclosureIndicator"] as? Bool ?? false {
               // No need to reload table view, since cells should not be updated
               print("Navigate to a new View(Controller) to display \(settingOptions[indexPath.row])")
           } else {
               // Update Model's data, then update UI to reflect latest Model changes
            modelController.updateSelectedOptionFor(section: indexPath.section,
                                                    optionIndex: indexPath.row)
               tableView.reloadData()
           }
        }
    }
}
