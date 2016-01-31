//
//  DetailViewController.swift
//  ParseTutorial
//
//  Created by Ian Bradbury on 06/02/2015.
//  Copyright (c) 2015 bizzi-body. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	// Container to store the view table selected object
	var currentObject : PFObject?
	
	// Some text fields
	@IBOutlet weak var Facility: UITextField!
	@IBOutlet weak var Department: UITextField!
	@IBOutlet weak var Email: UITextField!
	@IBOutlet weak var Telephone: UITextField!
	//@IBOutlet weak var flag: PFImageView!
	
	
	// The save button
	@IBAction func saveButton(sender: AnyObject) {
		
		if let updateObject = currentObject as PFObject? {
			
			// Update the existing parse object
			updateObject["Facility"] = Facility.text
			updateObject["Department"] = Department.text
			updateObject["Email"] = Email.text
			updateObject["Telephone"] = Telephone.text
			
			// Create a string of text that is used by search capabilites
			let searchText = (Email.text)!.lowercaseString
			updateObject["searchText"] = searchText
			
			// Save the data back to the server in a background task
			updateObject.saveEventually()
		} else {
			
			// Create a new parse object
			let updateObject = PFObject(className:"311talks")
			
			updateObject["Facility"] = Facility.text
			updateObject["Department"] = Department.text
			updateObject["Email"] = Email.text
			updateObject["Telephone"] = Telephone.text
			
			// Create a string of text that is used by search capabilites
			let searchText = (Email.text)!.lowercaseString
			updateObject["searchText"] = searchText
			
			updateObject.ACL = PFACL(user: PFUser.currentUser()!)
			
			// Save the data back to the server in a background task
			updateObject.saveEventually()
		}
		
		// Return to table view
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Unwrap the current object object
		if let object = currentObject {
			Facility.text = object["Facility"] as? String
			Department.text = object["Department"] as? String
			Email.text = object["Email"] as? String
			Telephone.text = object["Telephone"] as? String
			
//			let initialThumbnail = UIImage(named: "question")
//			flag.image = initialThumbnail
//			if let thumbnail = object["flag"] as? PFFile {
//				flag.file = thumbnail
//				flag.loadInBackground()
//			}
			
		}
	}
}
