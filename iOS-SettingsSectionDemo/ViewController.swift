//
//  ViewController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/2/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

//
//  ViewController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/2/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var settingItems = [
        "Setting 0",
        "Setting 1",
        "Setting 2",
        "Setting 3",
        "Setting 4",
        "Setting 5",
        "Setting 6",
        "Setting 7",
        "Setting 8",
        "Setting 9"
    ]
    
    private var settingsTableView: UITableView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createViewsHierarchy()
        configureViewsConstraints()
    }
    
    private func createViewsHierarchy() {
        settingsTableView = UITableView(frame: .zero, style: .plain)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        settingsTableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = settingItems[indexPath.row]
        return cell
    }
}
