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
		setViewConstraints()
	}

	func setupSubViews() {
	}
	
	
	


}
