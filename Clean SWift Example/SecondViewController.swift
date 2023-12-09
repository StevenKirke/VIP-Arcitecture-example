//
//  SecondViewController.swift
//  Clean SWift Example
//
//  Created by Steven Kirke on 06.12.2023.
//

import UIKit

protocol ISecondViewDisplay: AnyObject {
	func render()
}

protocol ITranswerView {
	func dataTranswer(dataTranswer: TranswerAnimalModel)
}

final class SecondViewController: UIViewController {

	// Подключаем SecondIteratorProtocol протокол
	// MARK: - External vars
	var router: ISecondRouterLogic?

	// MARK: - Internal vars
	var iteractor: ISecondIterator?

	private lazy var buttonFirstName: UIButton = createButton("DOG")
	private lazy var buttonSecondName: UIButton = createButton("BEAR")

	private lazy var labelTitle: UILabel = createLabel()
	private lazy var labelIcon: UILabel = createImageLabel()

	private lazy var navigationBar = UINavigationBar()
	private lazy var backButton: UIBarButtonItem = createButtonNav("Back")

	private lazy var hStack: UIStackView = createHStack()

	private var dataDisplay = TranswerAnimalModel(titleAnimal: "", iconAnimal: "")

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

extension SecondViewController: ITranswerView {
	func dataTranswer(dataTranswer: TranswerAnimalModel) {
		dataDisplay.titleAnimal = dataTranswer.titleAnimal
		dataDisplay.iconAnimal = dataTranswer.iconAnimal
		reloadDisplay()
	}
}

// Инициализация View
private extension SecondViewController {
	func setupConficuration() {
		view.backgroundColor = .white
		title = "Second screen"

		self.navigationItem.leftBarButtonItem = backButton

		backButton.action = #selector(didTapButtobBack)
		buttonFirstName.addTarget(
			self,
			action: #selector(answerDog),
			for: .touchUpInside)

		buttonSecondName.addTarget(
			self,
			action: #selector(answerBear),
			for: .touchUpInside
		)

		view.addSubview(labelTitle)
		view.addSubview(labelIcon)

		hStack.addArrangedSubview(buttonFirstName)
		hStack.addArrangedSubview(buttonSecondName)
		view.addSubview(hStack)
	}
}

// Подключение протокола SecondViewDisplayLogicProtocol
extension SecondViewController: ISecondViewDisplay {
	func render() { }
}

// Инициализация VIP
extension SecondViewController {
	private func setup() {

	}
}

// Создание UI элементов
private extension SecondViewController {
	private func createButton(_ text: String) -> UIButton {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = .gray
		button.configuration?.title = text
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}

	private func createButtonNav(_ text: String) -> UIBarButtonItem {
		let button = UIBarButtonItem()
		button.image = UIImage(systemName: "arrowshape.backward.fill")
		button.title = text
		button.style = .plain
		button.target = self
		button.tintColor = UIColor.black

		return button
	}

	private func createImageLabel() -> UILabel {
		let label = UILabel()
		label.text = ""
		label.font =  UIFont.systemFont(ofSize: 120)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}

	private func createLabel() -> UILabel {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = UIColor.black
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}

	private func createHStack() -> UIStackView {
		let hStach = UIStackView()
		hStach.distribution = .fillEqually
		hStach.axis = .horizontal
		hStach.spacing = 20
		hStach.translatesAutoresizingMaskIntoConstraints = false

		return hStach
	}
}

// Инициализация UI элементов
private extension SecondViewController {
	func setupLayout() {
		NSLayoutConstraint.activate([
			labelTitle.heightAnchor.constraint(equalToConstant: 20),
			labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			labelTitle.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 10
			),
			labelTitle.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -10
			),

			labelIcon.heightAnchor.constraint(equalToConstant: 100),
			labelIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			labelIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			labelIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			labelIcon.bottomAnchor.constraint(
				equalTo: labelTitle.topAnchor,
				constant: -20
			),

			hStack.heightAnchor.constraint(equalToConstant: 40),
			hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
			hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
			hStack.topAnchor.constraint(
				equalTo: labelTitle.bottomAnchor,
				constant: 20
			)
		])
	}
}

// Action UI элементов
extension SecondViewController {
	@objc private func answerDog() {
		dataDisplay.titleAnimal = "DOG"
		dataDisplay.iconAnimal = "🐶"
		reloadDisplay()
	}

	@objc private func answerBear() {
		dataDisplay.titleAnimal = "BEAR"
		dataDisplay.iconAnimal = "🐻"
		reloadDisplay()
	}

	@objc private func didTapButtobBack() {
		router?.returnFirstView(dataTranswer: dataDisplay)
	}

	private func reloadDisplay() {
		labelTitle.text = dataDisplay.titleAnimal
		labelIcon.text = dataDisplay.iconAnimal
	}
}
