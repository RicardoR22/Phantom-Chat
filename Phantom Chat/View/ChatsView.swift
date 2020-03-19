//
//  ChatsView.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/15/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit

class ChatsView: UIView {

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
		addSubview(NoChatsContainer)
		NoChatsContainer.addSubview(NoChatsLabel)
		NoChatsContainer.addSubview(FindPhantomButton)
	}
	
	
	let NoChatsContainer: UIView = {
		let container = UIView()
		
		return container
	}()
	
	
	let NoChatsLabel: UILabel = {
		let label = UILabel()
		label.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Find a phantom to start chatting!", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
		label.backgroundColor = .clear
		label.textAlignment = .center
		label.font = label.font.withSize(20)
		label.numberOfLines = 5
		
		return label
	}()
	
	let FindPhantomButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor.init(named: "Secondary")
		button.setTitle("Find Phantom", for: .normal)
		button.tintColor = UIColor (named: "Text")
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.titleLabel?.textAlignment = .center
		
		return button
	}()

}
