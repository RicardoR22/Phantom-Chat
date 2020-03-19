//
//  ChatsViewConstraints.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/15/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit

extension ChatsView {
    
    func setViewConstraints() {
        
		// No Chats Container
		NoChatsContainer.translatesAutoresizingMaskIntoConstraints = false
		NoChatsContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		NoChatsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		NoChatsContainer.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
		NoChatsContainer.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
		
		
		// No Chats Label
		NoChatsLabel.translatesAutoresizingMaskIntoConstraints = false
		NoChatsLabel.centerYAnchor.constraint(equalTo: NoChatsContainer.centerYAnchor).isActive = true
		NoChatsLabel.centerXAnchor.constraint(equalTo: NoChatsContainer.centerXAnchor).isActive = true
		NoChatsLabel.widthAnchor.constraint(equalTo:safeAreaLayoutGuide.widthAnchor, multiplier: 0.6).isActive = true
		NoChatsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		// Find Phantom Button
		FindPhantomButton.translatesAutoresizingMaskIntoConstraints = false
		FindPhantomButton.centerXAnchor.constraint(equalTo: NoChatsContainer.centerXAnchor).isActive = true
		FindPhantomButton.topAnchor.constraint(equalTo: NoChatsLabel.bottomAnchor, constant: 100).isActive = true
		FindPhantomButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
		FindPhantomButton.heightAnchor.constraint(equalToConstant: 45).isActive = true

	}
    
}
