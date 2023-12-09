//
//  SecondModels.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

enum SecondModel {
	// Информация идущая из View в Iterator, далее или на сервер или БД
	struct Request {
		let data: String
	}
	// Информация приходящая с сервера, БД в Presenter
	// обрабатывается для `ViewModel`
	struct Responce {
		let data: String
	}
	// Информация передается во View
	struct ViewModel {
		let data: String
	}
}
