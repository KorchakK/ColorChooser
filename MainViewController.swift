//
//  MainViewController.swift
//  ColorChooser
//
//  Created by Konstantin Korchak on 20.03.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setBackgroundColor(for color: UIColor)
}

class MainViewController: UIViewController, SettingViewControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        settingVC.mainScreenColor = view.backgroundColor
        settingVC.delegate = self
    }
    
    func setBackgroundColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
