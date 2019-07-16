//
//  ColorPickerVC.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 14/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var enterText2: UITextView!
    @IBOutlet weak var enterTextField: UITextField!
    @IBOutlet weak var colorPicker: ColorPicker!
    
    @IBOutlet weak var noteText: UITextView!
    
    @IBOutlet weak var multicolorSquare: UIView!
    @IBOutlet weak var greenSquare: UIView!
    @IBOutlet weak var redSquare: UIView!
    @IBOutlet weak var whiteSquare: UIView!
    
    let customMark = Square()
    let gradient = GradientView()
    var titleTextFromAdd: String?
    var noteTextFromAdd: String?
    
    
    
    
    
    
    //public let fileLogger: DDFileLogger = DDFileLogger()
    
    //    private func setupLogger() {
    //        DDLog.add(DDTTYLogger.sharedInstance)
    //
    //        // File logger
    //        fileLogger.rollingFrequency = TimeInterval(60*60*24)
    //        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    //        DDLog.add(fileLogger, with: .info)
    //    }
    
    private func blackStroke( _ square: UIView){
        square.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.003921568627, blue: 0.01176470588, alpha: 1)
        square.layer.borderWidth = 1
    }
    
    
    func showMark(_ colorSquare: UIView){
        if view.viewWithTag(4)?.alpha == 1 {
            let stackViewSub = view.subviews[2].subviews
            for i in 0...stackViewSub.count - 2 {
                stackViewSub[i].subviews.first?.alpha = 0
            }
            view.viewWithTag(4)?.alpha = 1
            colorSquare.subviews.first!.alpha = 1
            
        } else {
            let stackViewSub = view.subviews[2].subviews
            for i in 0...stackViewSub.count - 2 {
                stackViewSub[i].subviews.first?.alpha = 0
            }
            colorSquare.subviews.first!.alpha = 1
            view.subviews[2].subviews[3].subviews[1].alpha = 0
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logger from lumberjack
        //DDLogVerbose("Delete Note.")
        //DDLogError("Failed Delete Note")
        
        datePicker.isHidden = true
        
        // black stroke on the square
        blackStroke(whiteSquare)
        blackStroke(redSquare)
        blackStroke(greenSquare)
        blackStroke(multicolorSquare)
        
        //Circle drawing
        
        view.subviews.last!.alpha = 0
        
        colorPicker.topColor.layer.cornerRadius = 10
        colorPicker.topColor.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.003921568627, blue: 0.01176470588, alpha: 1)
        colorPicker.topColor.layer.borderWidth = 1
        
        //noteText resize depend of the content.
        noteText.sizeThatFits(CGSize(width: noteText.frame.size.width, height: noteText.frame.size.height))
        //moving keyboard with view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        enterTextField.text = titleTextFromAdd
        noteText.text = noteTextFromAdd
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //enterTextField.text = Notes.allNotes[ViewController.counter].title
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Notes.allNotes[ViewController.counter].noteText = noteText.text
        Notes.allNotes[ViewController.counter].title = enterTextField.text!
        // if multicolor change color = we change color also in model.
        
        if view.viewWithTag(1)?.alpha == 1{
            Notes.allNotes[ViewController.counter].noteColor = (view.viewWithTag(10)?.viewWithTag(111111)?.viewWithTag(1)?.backgroundColor)!
        } else if view.viewWithTag(2)?.alpha == 1{
            Notes.allNotes[ViewController.counter].noteColor = (view.viewWithTag(10)?.viewWithTag(222222)?.viewWithTag(2)?.backgroundColor)!
        } else if view.viewWithTag(3)?.alpha == 1{
            Notes.allNotes[ViewController.counter].noteColor = (view.viewWithTag(10)?.viewWithTag(333333)?.viewWithTag(3)?.backgroundColor)!
        } else if view.viewWithTag(24)?.alpha == 1{
            Notes.allNotes[ViewController.counter].noteColor = (view.viewWithTag(10)?.viewWithTag(14)?.viewWithTag(24)?.backgroundColor)!
        }
        
        
        
        //Notes.allNotes[ViewController.counter].noteColor = (view.viewWithTag(10)?.viewWithTag(14)?.viewWithTag(24)?.backgroundColor)!
        
        
        
        
//        print("Subviews multi  \(view.viewWithTag(10)?.viewWithTag(14)?.viewWithTag(24)?.backgroundColor)") // multicolor.
//        print("Subviews white  \(view.viewWithTag(10)?.viewWithTag(111111)?.viewWithTag(1)?.backgroundColor)") // white
//        print("Subviews white  \(view.viewWithTag(10)?.viewWithTag(222222)?.viewWithTag(2)?.backgroundColor)") // red
//        print("Subviews white  \(view.viewWithTag(10)?.viewWithTag(333333)?.viewWithTag(3)?.backgroundColor)") // green
        
        
        //(view.viewWithTag(10)?.viewWithTag(111111)?.viewWithTag(1)) // white
        //(view.viewWithTag(10)?.viewWithTag(222222)?.viewWithTag(2)) // red
        //(view.viewWithTag(10)?.viewWithTag(333333)?.viewWithTag(3)) // green
        
    }
    
    
    
    //dismiss keyboard - just tap in any place of view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        for i in 0...view.subviews.count - 1 {
            view.subviews[i].alpha = 0
        }
        if view.subviews.last!.isHidden == true {
            view.subviews.last!.isHidden = false
        }
        view.subviews.last!.alpha = 1
        //showMark(multicolorSquare)
        
        let stackViewSub = view.subviews[2].subviews
        for i in 0...stackViewSub.count - 1 {
            stackViewSub[i].subviews.first?.alpha = 0
        }
    }
    
    
    @IBAction func useSwicher(_ sender: Any) {
        if switcher.isOn == true{
            datePicker.isHidden = false
        } else{
            datePicker.isHidden = true
        }
    }
    @IBAction func greenButtonPressed(_ sender: Any) {
        showMark(greenSquare)
//        if view.viewWithTag(24)?.alpha == 1 {
//            if view.viewWithTag(4)?.alpha == 1 {
//                view.viewWithTag(4)?.alpha = 1
//                //view.viewWithTag(24)?.alpha = 0
//            } else {
//                view.viewWithTag(24)?.alpha = 0
//            }
//        }
        
        //view.viewWithTag(24)?.alpha = 0
    }
    @IBAction func redButtonPressed(_ sender: Any) {
        showMark(redSquare)
        if view.viewWithTag(24)?.alpha == 1{
            view.viewWithTag(24)?.alpha = 0
        }
        //view.viewWithTag(24)?.alpha = 0
    }
    @IBAction func whiteButtonPressed(_ sender: Any) {
        showMark(whiteSquare)
        if view.viewWithTag(24)?.alpha == 1{
            view.viewWithTag(24)?.alpha = 0
        }
        //view.viewWithTag(24)?.alpha = 0
    }

}
