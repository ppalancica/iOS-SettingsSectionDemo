//
//  RootViewController.swift
//  iOS-SettingsSectionDemo
//
//  Created by Pavel Palancica on 1/3/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var goToSettingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createViewsHierarchy()
        configureViewsConstraints()
    }
    
    private func createViewsHierarchy() {
        goToSettingsButton = UIButton(type: .system)
        goToSettingsButton.setTitle("Go to Settings", for: .normal)
        goToSettingsButton.addTarget(self,
                                     action: #selector(goToSettingsButtonTap),
                                     for: .touchUpInside)
        view.addSubview(goToSettingsButton)
    }
    
    private func configureViewsConstraints() {
        goToSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goToSettingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            goToSettingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            goToSettingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            goToSettingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc
    private func goToSettingsButtonTap() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}
