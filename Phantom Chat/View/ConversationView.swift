//
//  ConversationView.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 3/23/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit

class ConversationView: UIView {
	
	
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
	}

	func setupSubViews() {
		addSubview(messagesCV)
		addSubview(inputContainer)
		inputContainer.addSubview(sendButton)
		inputContainer.addSubview(inputTextField)
		inputContainer.addSubview(seperatorLine)
	}
	
	let messagesCV: UICollectionView = {
		let collectionView = UICollectionView()
		
		return collectionView
	}()
	
	let inputContainer: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(named: "Primary")
		
		return view
	}()
	
	let sendButton: UIButton = {
		let btn = UIButton(type: .system)
		btn.setTitle("Send", for: .normal)
		
		return btn
	}()
	
	let inputTextField: UITextField = {
		let textField = UITextField()
		textField.attributedPlaceholder = NSAttributedString(string: "Enter Message..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: "Text")!])
		textField.textColor = UIColor.init(named: "Text")
		textField.setLeftPaddingPoints(10)
		
		return textField
	}()
	
	let seperatorLine: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(named: "Text")
		
		return view
	}()


}
