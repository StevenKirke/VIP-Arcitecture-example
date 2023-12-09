//
//  FirstPresenter.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

protocol IFirstPresenter: AnyObject {
	// Добавляем методы, показа дальнейших View6 например:
	// При положительном ответе сервера показываем следующие View
	func present(_ responce: FirstModel.Responce)

}

final class FirstPresenter {
	// Подключаем текущее View
	private weak var viewController: IFirstViewDisplay?

	internal init(viewController: IFirstViewDisplay?) {
		self.viewController = viewController
	}
}

extension FirstPresenter: IFirstPresenter {
	// В зависимости от результата работы сервера, обрабатываем методы
	// Например добавим ! и текст
	func present(_ responce: FirstModel.Responce) {
		if let error = responce.error {
			viewController?.render(.error(error))

		} else {
			viewController?.render(.success(FirstModel.ViewModel.UserData(
				title: responce.currentAnimal,
				icon: responce.discriptionAnimal
			)))
		}
	}
}
