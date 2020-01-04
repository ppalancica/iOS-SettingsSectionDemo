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
        return modelController.numberOfSettings()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return modelController.numberOfOptionsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        if let settingOption = modelController.settingOptionFor(indexPath: indexPath) {
            cell.textLabel?.text = settingOption
        }
        if modelController.isSelectedOptionAt(indexPath: indexPath) {
            cell.accessoryType = .checkmark
        } else if modelController.isInfoPageOptionAt(indexPath: indexPath) {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
}

// MARK: UITableViewDelegate methods

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return modelController.settingNameForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if modelController.isInfoPageOptionAt(indexPath: indexPath) {
            // No need to reload table view, since cells should not be updated
            if let settingName = modelController.settingNameForSection(section: indexPath.row) {
                print("Navigate to a new View(Controller) to display \(settingName)")
            }
        } else {
            // Update Model's data, then update UI to reflect latest Model changes
            modelController.updateSelectedOptionFor(section: indexPath.section,
                                                    optionIndex: indexPath.row)
            tableView.reloadData()
        }
    }
}
