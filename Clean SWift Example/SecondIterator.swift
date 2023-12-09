//
//  SecondIterator.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

protocol ISecondIterator {
	// Запрашиваем данные (сеть, мок, база данных и. т. п)
	func featch(request: SecondModel.Request)
}

final class SecondIterator {
	private var presenter: ISecondPresenter?

	internal init(presenter: ISecondPresenter? = nil) {
		self.presenter = presenter
	}
}

extension SecondIterator: ISecondIterator {
	// Приходят какие либо данные c First View
	func featch(request: SecondModel.Request) {
		print("request \(request.data)")
	}
}
