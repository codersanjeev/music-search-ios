//
//  ViewController.swift
//  music-search-ios
//
import UIKit
import SwiftUI

class ViewController: UIViewController {
	// MARK:- IBOutlets
	@IBOutlet weak var uikitButton: UIButton!
	@IBOutlet weak var swiftuiButton: UIButton!
	
	// MARK: Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "UIKit vs SwiftUI"
	}
	
	// MARK:- IBActions
	@IBAction func buttonClickHandler(_ sender: UIButton) {
		if sender == uikitButton {
			if let searchViewController = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController {
				self.navigationController?.pushViewController(searchViewController, animated: true)
			}
		} else if sender == swiftuiButton {
			let searchView = SearchView()
			let searchViewController = UIHostingController(rootView: searchView)
			self.navigationController?.pushViewController(searchViewController, animated: true)
		}
	}
}
