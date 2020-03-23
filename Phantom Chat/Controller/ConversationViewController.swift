//
//  ConversationViewController.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 3/23/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController {
	
	var ref: DatabaseReference!
	var conversationView: ConversationView!
	let id = Auth.auth().currentUser?.uid
	var partnerID: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "End Conversation", style: .plain, target: self, action: #selector(endConversation))
		navigationItem.leftBarButtonItem?.tintColor = UIColor.init(named: "Text")
		setup()
		perform(#selector(listenForPartnerLeave), with: nil, afterDelay: 10)
		
	}
	
	// MARK: View setup
	
	func setup() {
		setupView()
		addButtonTarget()
	}
	
	
	
	func setupView() {
		let mainView = ConversationView(frame: self.view.frame)
		self.conversationView = mainView
		self.view.addSubview(conversationView)
		
	}
	
	func addButtonTarget() {
	}
	
	

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	@objc func endConversation() {
		let ref = Database.database().reference().child("Chats")
		ref.child(self.id!).removeValue()
//		ref.child(partnerID).removeValue()
		
		navigationController?.popToRootViewController(animated: true)
	}
	
	@objc func listenForPartnerLeave() {
		let ref = Database.database().reference().child("Chats").child(partnerID)
		
		DispatchQueue.main.async {
			ref.observe(.value, with: { snapshot in
				if !snapshot.exists() {
					self.endConversation()
				}
			})
		}
		
	}
	
}
