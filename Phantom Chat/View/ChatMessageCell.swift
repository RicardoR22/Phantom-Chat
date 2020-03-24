//
//  ChatMessageCell.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 3/23/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
	    
	let textLabel: UITextView = {
		let textLabel = UITextView()
		textLabel.font = UIFont.systemFont(ofSize: 16)
		textLabel.textColor = UIColor.init(named: "Text")
		textLabel.backgroundColor = .clear
		textLabel.isScrollEnabled = false
		textLabel.isEditable = false
		
		
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		
		return textLabel
	}()
	
	let bubbleView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(named: "Primary")

		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	var bubbleWidthAnchor: NSLayoutConstraint?
	var bubbleViewRightAnchor: NSLayoutConstraint?
	var bubbleViewLeftAnchor: NSLayoutConstraint?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(bubbleView)
		addSubview(textLabel)
		
		bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
		bubbleViewRightAnchor?.isActive = true
		bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
		bubbleViewLeftAnchor?.isActive = false
		
		bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
		bubbleWidthAnchor?.isActive = true
		bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
//		textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		textLabel.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
		textLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
		textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//		textLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
		textLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
//		textLabel.preferredMaxLayoutWidth = 100
//		textLabel.sizeToFit()
//
//		textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//		textLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
