//
//  SceneDelegate.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions) {

			guard let scene = (scene as? UIWindowScene) else { return }
			let window = UIWindow(windowScene: scene)

			window.rootViewController = UINavigationController(rootViewController: assemblyFirstView())
			window.makeKeyAndVisible()

			self.window = window
		}
}

func assemblyFirstView() -> FirstViewController {
	let viewController = FirstViewController()
	let presenter = FirstPresenter(viewController: viewController)
	let iteractor = FirstIterator(presenter: presenter)
	let router = FirstRouter(viewController: viewController)

	viewController.iteractor = iteractor
	viewController.router = router
	return viewController
}

func assemblySecondView() -> SecondViewController {
	let viewController = SecondViewController()
	let presenter = SecondPresenter(viewController: viewController)
	let iteractor = SecondIterator(presenter: presenter)
	let router = SecondRouter(viewController: viewController)

	viewController.iteractor = iteractor
	viewController.router = router
	return viewController
}
