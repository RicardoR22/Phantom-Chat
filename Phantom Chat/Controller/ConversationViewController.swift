//
//  ConversationViewController.swift
//  Phantom Chat
//
//  Created by Ricardo Rodriguez on 3/23/20.
//  Copyright © 2020 Ricardo Rodriguez. All rights reserved.
//

import UIKit
import Firebase

class ConversationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
	
	var ref: DatabaseReference!
	let id = Auth.auth().currentUser?.uid
	var partnerID: String!
	let cellID = "MessageCell"
	
	
	var messages: [Message] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "End Conversation", style: .plain, target: self, action: #selector(endConversation))
		navigationItem.leftBarButtonItem?.tintColor = UIColor.init(named: "Text")

		
		setup()
		perform(#selector(listenForPartnerLeave), with: nil, afterDelay: 10)
		observeMessages()
	}
	
	// MARK: View setup
	
	func setup() {
		setupView()
		inputTextField.delegate = self
	}
	
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
	
	
	func setupView() {
		
		self.view.addSubview(inputContainer)
		inputContainer.translatesAutoresizingMaskIntoConstraints = false
		inputContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
		inputContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
		inputContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		inputContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		inputContainer.addSubview(sendButton)
		sendButton.translatesAutoresizingMaskIntoConstraints = false
		sendButton.rightAnchor.constraint(equalTo: inputContainer.rightAnchor).isActive = true
		sendButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor).isActive = true
		sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
		sendButton.heightAnchor.constraint(equalTo: inputContainer.heightAnchor).isActive = true
		
		
		inputContainer.addSubview(inputTextField)
		inputTextField.translatesAutoresizingMaskIntoConstraints = false
		inputTextField.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
		inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
		inputTextField.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor).isActive = true
		inputTextField.heightAnchor.constraint(equalTo: inputContainer.heightAnchor).isActive = true
		
		inputContainer.addSubview(seperatorLine)
		seperatorLine.translatesAutoresizingMaskIntoConstraints = false
		seperatorLine.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
		seperatorLine.rightAnchor.constraint(equalTo: inputContainer.rightAnchor).isActive = true
		seperatorLine.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
		seperatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
		collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
		collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
		
		collectionView.backgroundColor = UIColor.init(named: "Background")
		collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellID)
		

	}
	
	
	

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	@objc func sendMessage() {
		
		guard let text = inputTextField.text else { return }
		
		let ref = Database.database().reference().child("Messages").child(self.id!)
		let childRef = ref.childByAutoId()
		
		let recepientRef = Database.database().reference().child("Messages").child(partnerID)
		let recepientChildRef = recepientRef.childByAutoId()
		
		childRef.setValue(["text": text, "toID": partnerID, "fromID": self.id!])
		recepientChildRef.setValue(["text": text, "toID": partnerID, "fromID": self.id!])
		
		inputTextField.text = ""
	}
	
	func observeMessages() {
		let ref = Database.database().reference().child("Messages").child(self.id!)
		DispatchQueue.main.async {
			ref.observe(.childAdded, with: { snapshot in
				guard let messages = snapshot.value as? [String: AnyObject] else { return }
				
				let message = Message()
				message.fromID = messages["fromID"] as? String
				message.toID = messages["toID"] as? String
				message.text = messages["text"] as? String
				
				self.messages.append(message)
				
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
				
			})
		}
	}
	
	@objc func endConversation() {
		let ref = Database.database().reference().child("Chats")
		ref.child(self.id!).removeValue()
		
		let messagesRef = Database.database().reference().child("Messages").child(self.id!)
		messagesRef.removeValue()
		
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
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		sendMessage()
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatMessageCell
		cell.textLabel.text = messages[indexPath.row].text
		
		cell.bubbleWidthAnchor?.constant = estimatedFrameForText(text: messages[indexPath.row].text!).width + 32
		
		if messages[indexPath.row].fromID == self.id {
			cell.bubbleView.backgroundColor = UIColor.init(named: "Primary")
			cell.bubbleViewRightAnchor?.isActive = true
			cell.bubbleViewLeftAnchor?.isActive = false
		} else {
			cell.bubbleView.backgroundColor = UIColor.init(named: "Secondary")
			cell.bubbleViewRightAnchor?.isActive = false
			cell.bubbleViewLeftAnchor?.isActive = true
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var height: CGFloat = 80
		
		// Get estimated height
		if let text = messages[indexPath.item].text {
			height = estimatedFrameForText(text: text).height + 20
		}
		
		return CGSize(width: view.frame.width, height: height)
	}
	
	private func estimatedFrameForText(text: String) -> CGRect {
		let size = CGSize(width: 200, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		
		return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
}
