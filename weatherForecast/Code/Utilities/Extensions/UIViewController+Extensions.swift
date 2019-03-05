//
//  UIViewController+Extensions.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {

    func present(error: Error?) {
        let title: String?
        let message: String?

        if let error = error as? LocalizedError {
            title = error.errorDescription ?? error.localizedDescription
            message = error.failureReason
        } else if let error = error as? CLError {
            title = "Location error"
            message = error.localizedDescription
        } else {
            title = "Error"
            message = "An error ocurred."
        }

        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(
            UIAlertAction(
                title: "Dismiss",
                style: .cancel
            )
        )

        present(alertController, animated: true)
    }

    func present(error: Error?, retryAction: @escaping (Any?) -> Void, cancelAction: @escaping (Any?) -> Void) {
        let title: String?
        let message: String?

        if let error = error as? LocalizedError {
            title = error.errorDescription ?? error.localizedDescription
            message = error.failureReason
        } else if let error = error {
            title = error.localizedDescription
            message = nil
        } else {
            title = "Error"
            message = "An error ocurred"
        }

        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(
            UIAlertAction(
                title: "Dismiss",
                style: .cancel,
                handler: cancelAction
            )
        )

        alertController.addAction(
            UIAlertAction(
                title: "Retry",
                style: .default,
                handler: retryAction
            )
        )

        present(alertController, animated: true)
    }

}
