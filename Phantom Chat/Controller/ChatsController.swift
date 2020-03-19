//
//  ViewController.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/13/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit
import Firebase

class ChatsController: UIViewController {
	
	var ref: DatabaseReference!
	
	var chatsView: ChatsView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
		navigationItem.leftBarButtonItem?.tintColor = UIColor.init(named: "Text")
		setup()
		
		// Check if no user logged in
		if Auth.auth().currentUser?.uid == nil {
			logout()
		}
		
	}
	
	// MARK: View setup
	
	func setup() {
		setupView()
		addButtonTarget()
	}
	
	
	
	func setupView() {
		let mainView = ChatsView(frame: self.view.frame)
		self.chatsView = mainView
		self.view.addSubview(chatsView)
		
	}
	
	func addButtonTarget() {
	}
	
	@objc func logout() {
		
		do {
			try Auth.auth().signOut()
		}catch let logoutError {
			print(logoutError)
		}
		
		print("Logged out successfully")
		let loginVC = LoginController()
        UIApplication.shared.windows.first?.rootViewController = loginVC
	}
	
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	
}
