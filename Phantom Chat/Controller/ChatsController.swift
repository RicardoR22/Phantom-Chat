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
	var timer = Timer()
	var timeInQueue = 0
	var searching = false
	let id = Auth.auth().currentUser?.uid
	
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
		chatsView.FindPhantomButton.addTarget(self, action: #selector(findPhantom), for: .touchDown)
	}
	
	func searchTimer(){
		timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {_ in
			self.timeInQueue += 2
			if (self.timeInQueue <= 10) {
				if(!self.checkIfInChat()) {
					self.searchForPhantom()
				}
			} else {
				self.resetView()
			}
		})
	}
	
	func resetView() {
        exitQueue()
    }
	
	func exitQueue() {
		if(searching) {
			timer.invalidate()
			let ref = Database.database().reference().child("Queue").child(id!)
			ref.setValue([])
			searching = false
		}
	}
	
	func searchForPhantom() {
		let ref = Database.database().reference().child("Queue")
		DispatchQueue.main.async {
			ref.observeSingleEvent(of: .value, with: { snapshot in
				
				if !snapshot.exists() {
					return
				}
				let value = snapshot.value as! [String : AnyObject]
				//Goes through the values inside the queue of users
				for(_, newvalue) in value {
					let currValue = newvalue as! [String : String]
					let currID = currValue["id"]!
					//if the id is not our own, connect to user
					if(currID != self.id) {
						print("Connecting to user: \(currID)")
						//Creates a chatRoom with the id's of both user's added together
						var chatRoomID = self.id!
						chatRoomID += currID
						let chatRoom = Database.database().reference().child("Chats").child(self.id!)
						chatRoom.setValue(["partner": currID])
						self.startConversation(partnerID: currID)
						return
					}
				}
				self.exitQueue()

			})
		}
	}
	
	func startConversation(partnerID: String) {
		let conversationVC = ConversationViewController()
		conversationVC.partnerID = partnerID
		navigationController?.pushViewController(conversationVC, animated: true)
	}
	
	func checkIfInChat()->Bool {
		//Checks the DB value inChat if true go to chat room!
		var found = false
		let ref = Database.database().reference().child("Queue").child(id!)
		DispatchQueue.main.async {
			ref.observeSingleEvent(of: .value, with: { snapshot in
				
				if !snapshot.exists() {
					return }
				let value = snapshot.value as! [String : AnyObject]
				let theValue = value as! [String : String]
				let foundString = theValue["inChat"]!
				if(foundString == "true")
				{
					found = true
					self.timer.invalidate()
					//					self.goToChat()
				}
			})
		}
		return found
	}
	
	@objc func findPhantom() {
		let ref = Database.database().reference().child("Queue").child(id!)
		ref.setValue(["inChat":"false", "id": id, "chatRoom": "nil"])//default queue values
		searching = true
		searchTimer()
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
