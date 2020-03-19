//
//  LoginViewConstraints.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/13/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//


import UIKit

extension LoginView {
    
    func setViewConstraints() {
		
		// Logo
		logoImage.translatesAutoresizingMaskIntoConstraints = false
		logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
		logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
		logoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
		logoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
		// Input Container
		inputContainer.translatesAutoresizingMaskIntoConstraints = false
		inputContainer.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
		inputContainer.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
		inputContainer.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -25).isActive = true
		inputContainer.heightAnchor.constraint(equalTo:safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
		
		// Email Text Field
		emailTextField.translatesAutoresizingMaskIntoConstraints = false
		emailTextField.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
		emailTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 0.5).isActive = true
		
		// Email Seperator
		
		emailSeperator.translatesAutoresizingMaskIntoConstraints = false
		emailSeperator.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
		emailSeperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailSeperator.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
		emailSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		// Password Text Field
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false
		passwordTextField.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailSeperator.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
		passwordTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 0.5).isActive = true
		
		
		// Register Button
		loginRegisterButton.translatesAutoresizingMaskIntoConstraints = false
		loginRegisterButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
		loginRegisterButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 50).isActive = true
		loginRegisterButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		loginRegisterButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
		
		
		// Login Label
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		loginLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
		loginLabel.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 50).isActive = true
		loginLabel.widthAnchor.constraint(equalTo:safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
		loginLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
	}
    
}
