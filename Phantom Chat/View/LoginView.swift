//
//  LoginView.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/13/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit

class LoginView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		backgroundColor = UIColor.init(named: "Background")
		setupSubViews()
		setViewConstraints()
	}

	func setupSubViews() {
		addSubview(inputContainer)
		addSubview(loginRegisterButton)
		addSubview(loginLabel)
		addSubview(logoImage)
		inputContainer.addSubview(emailTextField)
		inputContainer.addSubview(emailSeperator)
		inputContainer.addSubview(passwordTextField)
	}
	
	let logoImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage.init(named: "Logo")
			
		return imageView
	}()
	
	let inputContainer: UIView = {
		let container = UIView()
		container.backgroundColor = UIColor.init(named: "Primary")
		container.layer.cornerRadius = 5
		
		return container
	}()
	
	let loginRegisterButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor.init(named: "Secondary")
		button.setTitle("Register", for: .normal)
		button.tintColor = UIColor (named: "Text")
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.titleLabel?.textAlignment = .center
		
		return button
	}()
	
	let emailTextField: UITextField = {
		let textField = UITextField()
		textField.attributedPlaceholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
		textField.textColor = UIColor.init(named: "Text")
		textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
		return textField
	}()
	
	let emailSeperator: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(named: "Text")
		
		return view
	}()
	
	let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.attributedPlaceholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
		textField.textColor = UIColor.init(named: "Text")
		textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
		textField.isSecureTextEntry = true
		return textField
	}()
	
	let loginLabel: UILabel = {
		let label = UILabel()
		label.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "⬅ Swipe Left for Login", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
		label.backgroundColor = .clear
		label.textAlignment = .center
		
		return label
	}()
	

}
