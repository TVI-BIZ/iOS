//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Vlad Tagunkov on 06/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.font = label.font.withSize(14)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
    }


    @IBAction func choiceSegmented(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment "
            label.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        case 1:
            label.text = "The second segment"
            label.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case 2:
            label.text = "The third segment "
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            print("Something wrong!")
        }
    }
}

