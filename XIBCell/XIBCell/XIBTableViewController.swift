//
//  XIBTableViewController.swift
//  SW4Temp
//
//  Created by Don Mag on 6/27/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

import UIKit

class XIBCell: UITableViewCell, UITextViewDelegate {
	
	@IBOutlet var theTextView: UITextView!
	
	var callBack: (() -> ())?
	
	func textViewDidChange(_ textView: UITextView) {
		print("change")
		callBack?()
	}
	
}

class XIBTableViewController: UITableViewController {

	let rightButtonItem = UIBarButtonItem.init(
		title: "Done Editing",
		style: .done,
		target: self,
		action: #selector(rightButtonAction(sender:))
	)
	
	@objc func rightButtonAction(sender: UIBarButtonItem) {
		self.view.endEditing(true)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.register(UINib(nibName: "XIBCell", bundle: nil), forCellReuseIdentifier: "XIBCell")
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 300
	
		// show "Done Editing" button in NavBar
		if self.navigationController != nil {
			self.navigationItem.rightBarButtonItem = rightButtonItem
		}
		
    }

	// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "XIBCell", for: indexPath) as! XIBCell

		// pre-fill the text view with some text
		let nLines = Int(arc4random_uniform(5)) + 2
		cell.theTextView.text = (1...nLines).map({ "Line \($0)" }).joined(separator: "\n")

		cell.callBack = {
			self.tableView.beginUpdates()
			self.tableView.endUpdates()
		}
		
        return cell
    }

}
