//
//  UITableViewController+showNetworkError.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit

extension UITableViewController {
    func showNetworkError() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Ошибка загрузки данных. Попытайтесь еще раз",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
