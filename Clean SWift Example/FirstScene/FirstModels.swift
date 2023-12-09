//
//  FirstModels.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

// swiftlint:disable nesting
enum FirstModel {
	// Информация идущая из View в Iterator, далее или на сервер или БД
	struct Request {
		let currernAnimal: String
	}
	// Информация приходящая с сервера, БД в Presenter
	// обрабатывается для `ViewModel`
	struct Responce {
		let id: String
		let currentAnimal: String
		let discriptionAnimal: String
		let error: String?
	}
	// Информация передается во View
	enum ViewModel {
		case error(String)
		case success(UserData)

		struct UserData {
			let title: String
			let icon: String
		}
	}
}
// swiftlint:enable nesting
