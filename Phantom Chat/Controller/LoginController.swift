//
//  LoginController.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 1/13/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
	
	var ref: DatabaseReference!
	var loginView: LoginView!
	var registerMode = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	// MARK: View setup
	
	func setup() {
		setupView()
		addButtonTarget()
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(self.swipeLeft(_:)))
		swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
		self.view.addGestureRecognizer(swipeLeft)
		
		let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.swipeRight(_:)))
		swipeRight.direction = UISwipeGestureRecognizer.Direction.right
		self.view.addGestureRecognizer(swipeRight)
	}
	
	
	
	func setupView() {
		let mainView = LoginView(frame: self.view.frame)
		self.loginView = mainView
		self.view.addSubview(loginView)
		
	}
	
	func addButtonTarget() {
	   loginView.loginRegisterButton.addTarget(self, action: #selector(loginOrRegisterUser), for: .touchUpInside)
	}
	
	
	@objc func loginOrRegisterUser() {
		
		if registerMode == true {
			registerUser()
		} else {
			loginUser()
		}
		
	}
	
	func loginUser() {
		
		guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { print("Invalid Form Data")
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
			
			if error != nil {
				print(error as Any)
				return
			}
			
			print("Login Successful")
			
			let nav = UINavigationController()
			nav.navigationBar.barTintColor = UIColor.init(named: "Primary")
			nav.viewControllers = [ChatsController()]
			UIApplication.shared.windows.first?.rootViewController = nav
			
		})
	}
	
	func registerUser() {
		
		guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { print("Invalid Form Data")
			return
		}
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			if error != nil {
				print(error as Any)
				return
			}
			
			print("Registration Successful")
			
			let nav = UINavigationController()
			nav.navigationBar.barTintColor = UIColor.init(named: "Primary")
			nav.viewControllers = [ChatsController()]
			UIApplication.shared.windows.first?.rootViewController = nav
		}
	}

	
	
	
	@objc func swipeLeft(_ sender: UISwipeGestureRecognizer){
		if registerMode == true {
			let animation = CATransition()
			animation.type = .fade
			animation.duration = 0.2
			animation.subtype = .fromRight
			self.view.window!.layer.add(animation, forKey: nil)
			self.loginView.loginRegisterButton.setTitle("Login", for: .normal)
			self.loginView.loginLabel.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Swipe Right to Register ➡️", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
			self.registerMode = false
		}
    }
	
	@objc func swipeRight(_ sender: UISwipeGestureRecognizer){
		if registerMode == false {
			let animation = CATransition()
			animation.type = .fade
			animation.duration = 0.2
			animation.subtype = .fromRight
			self.view.window!.layer.add(animation, forKey: nil)
			self.loginView.loginRegisterButton.setTitle("Register", for: .normal)
			self.loginView.loginLabel.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "⬅ Swipe Left for Login", attributes: [.foregroundColor: UIColor.init(named: "Text")!]))
			self.registerMode = true
		}
    }
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
}
