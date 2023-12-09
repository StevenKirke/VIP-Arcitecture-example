//
//  SecondPresenter.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import Foundation

protocol ISecondPresenter: AnyObject {
	// Добавляем методы, показа дальнейших View например:
	func backFirstView(_ data: String)
}

final class SecondPresenter {
	// Подключаем текущее View
	weak var viewController: ISecondViewDisplay?
	internal init(viewController: ISecondViewDisplay?) {
		self.viewController = viewController
	}
}

extension SecondPresenter: ISecondPresenter {
	func backFirstView(_ data: String) {

	}
}
