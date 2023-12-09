//
//  SecondRouter.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import UIKit

protocol ISecondRouterLogic {
	func returnFirstView(dataTranswer: TranswerAnimalModel)
}

final class SecondRouter {

	weak var viewController: UIViewController?

	internal init(viewController: UIViewController?) {
		self.viewController = viewController
	}
}

extension SecondRouter: ISecondRouterLogic {
	func returnFirstView(dataTranswer: TranswerAnimalModel) {
		print("dataTranswer \(dataTranswer)")
		viewController?.navigationController?.popViewController(animated: true)
	}
}
