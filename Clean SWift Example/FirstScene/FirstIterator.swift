//
//  FirstIterator.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

protocol IFirstIterator: AnyObject {
	// Запрашиваем данные (сеть, мок, база данных и. т. п)
	func featchData(_ request: FirstModel.Request)
}

final class FirstIterator {
	// Подключаем Presenter протокол
	private var presenter: IFirstPresenter?

	internal init(presenter: IFirstPresenter? = nil) {
		self.presenter = presenter
	}
}

extension FirstIterator: IFirstIterator {
	func featchData(_ request: FirstModel.Request) {
		// Приходят какие либо данные
		// Для примера массив с задержкой 1 секунда
		// Моделирум обработку сервера,
		// например положительный и отрицательный результат
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			guard let self = self else { return }
			let currentAnimal = request.currernAnimal.components(separatedBy: " ")
			let lowerText = currentAnimal[0].lowercased()
			let currentModel: FirstModel.Responce

			switch lowerText {
			case "cat":
					currentModel = FirstModel.Responce(
						id: "1",
						currentAnimal: "CAT",
						discriptionAnimal: "😸",
						error: nil
					)
			case "mouse":
					currentModel = FirstModel.Responce(
						id: "2",
						currentAnimal: "MOUSE",
						discriptionAnimal: "🐭",
						error: nil
					)
			default:
					currentModel = FirstModel.Responce(
						id: "",
						currentAnimal: "",
						discriptionAnimal: "",
						error: "No animal selected!"
					)
			}
			presenter?.present(currentModel)
		}
	}
}
