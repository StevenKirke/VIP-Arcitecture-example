//
//  FirstRouter.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import UIKit

protocol IFirstRouter {
	func nextView(dataTransfer: TranswerAnimalModel)
	func errorView(errorText: String)
}

final class FirstRouter {
	weak var viewController: UIViewController?

	internal init(viewController: UIViewController?) {
		self.viewController = viewController
	}
}

extension FirstRouter: IFirstRouter {
	func nextView(dataTransfer: TranswerAnimalModel) {
		let secondVC = assemblySecondView()

		secondVC.dataTranswer(dataTranswer: dataTransfer)
		viewController?.navigationController?.pushViewController(secondVC, animated: true)
	}

	func errorView(errorText: String) {
		let alertView = createAlert(error: errorText)
		viewController?.present(alertView, animated: true, completion: nil)
	}
}

extension FirstRouter {
	func createAlert(error: String) -> UIAlertController {
		let alert = UIAlertController(
			title: "Alert",
			message: error,
			preferredStyle: .alert
		)
		alert.addAction(UIAlertAction(
			title: "OK",
			style: .default,
			handler: nil
		))
		return alert
	}
}
