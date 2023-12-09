//
//  FirstViewController.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import UIKit

protocol IFirstViewDisplay: AnyObject {
	func render(_ viewModel: FirstModel.ViewModel)
}

final class FirstViewController: UIViewController {

	var iteractor: IFirstIterator?
	var router: IFirstRouter?

	private var displayData = "Select an animal"
	private var displayIcon = "❓"

	private lazy var label: UILabel = createLabel()
	private lazy var labelIcon: UILabel = createImageLabel()
	private lazy var buttonFirstName: UIButton = createButton(
		title: "CAT",
		action: #selector(tapFirstButton)
	)
	private lazy var buttonSecondName: UIButton = createButton(
		title: "MOUSE",
		action: #selector(tapSecondButton)
	)
	private lazy var buttonNextView: UIButton = createButton(
		title: "Next view",
		action: #selector(transwerDataSecondView)
	)

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func viewDidLoad() {
	 super.viewDidLoad()
		setupConficuration()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
	}
}

// Инициализация View
extension FirstViewController {
	func setupConficuration() {
		view.backgroundColor = .white
		title = "First screen"
		reloadDisplay()

		view.addSubview(buttonFirstName)
		view.addSubview(buttonSecondName)
		view.addSubview(buttonNextView)

		view.addSubview(labelIcon)
		view.addSubview(label)
	}
}

// Инициализация UI элементов
extension FirstViewController {
	func setupLayout() {
		NSLayoutConstraint.activate([
			buttonFirstName.widthAnchor.constraint(equalToConstant: 200),
			buttonFirstName.heightAnchor.constraint(equalToConstant: 40),
			buttonFirstName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonFirstName.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			buttonSecondName.widthAnchor.constraint(equalToConstant: 200),
			buttonSecondName.heightAnchor.constraint(equalToConstant: 40),
			buttonSecondName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonSecondName.topAnchor.constraint(equalTo: buttonFirstName.bottomAnchor, constant: 20),

			buttonNextView.widthAnchor.constraint(equalToConstant: 200),
			buttonNextView.heightAnchor.constraint(equalToConstant: 40),
			buttonNextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonNextView.topAnchor.constraint(equalTo: buttonSecondName.bottomAnchor, constant: 20),

			label.heightAnchor.constraint(equalToConstant: 20),
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			label.bottomAnchor.constraint(equalTo: buttonFirstName.topAnchor, constant: -20),

			labelIcon.heightAnchor.constraint(equalToConstant: 100),
			labelIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			labelIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			labelIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			labelIcon.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20)

		])
	}
}

// Создание UI элементов
private extension FirstViewController {
	private func createButton(title: String, action: Selector) -> UIButton {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = .gray
		button.configuration?.title = title
		button.addTarget(self, action: action, for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	private func createImageLabel() -> UILabel {
		let label = UILabel()
		label.font =  UIFont.systemFont(ofSize: 120)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}

	private func createLabel() -> UILabel {
		let label = UILabel()
		label.textColor = UIColor.black
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}

// Подключение протокола FirstViewDisplayLogicProtocol
extension FirstViewController: IFirstViewDisplay {
	func render(_ viewModel: FirstModel.ViewModel) {
		switch viewModel {
		case .error(let error):
				router?.errorView(errorText: error)
		case .success(let userData):
				displayData = userData.title
				displayIcon = userData.icon
				reloadDisplay()
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
					guard let self = self else { return }
					self.router?.nextView(dataTransfer: TranswerAnimalModel(
						titleAnimal: userData.title,
						iconAnimal: userData.icon
					))
				}
		}
	}
}

// Действие UI элементов
private extension FirstViewController {
	@objc private func tapFirstButton() {
		displayData = "CAT"
		buttonSecondName.configuration?.baseBackgroundColor = .gray
		buttonFirstName.configuration?.baseBackgroundColor = .lightGray
		reloadDisplay()
	}

	@objc private func tapSecondButton() {
		displayData = "MOUSE"
		buttonFirstName.configuration?.baseBackgroundColor = .gray
		buttonSecondName.configuration?.baseBackgroundColor = .lightGray
		reloadDisplay()
	}

	@objc private func transwerDataSecondView() {
		let request = FirstModel.Request(currernAnimal: displayData).currernAnimal
		self.iteractor?.featchData(FirstModel.Request(currernAnimal: request))
	}

	private func reloadDisplay() {
		label.text = displayData
		labelIcon.text = displayIcon
	}
}
