//  ViewController.swif
//  UITextView
//
//  Created by Vlad Tagunkov on 07/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        textView.isHidden = true
        //textView.alpha = 0
        
        // Do any additional setup after loading the view, typically from a nib.
        textView.font = UIFont(name: "Arial", size: 12)
        textView.backgroundColor = self.view.backgroundColor
        
        textView.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        stepper.value = 17
        stepper.minimumValue = 10
        stepper.maximumValue = 25
        
        stepper.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stepper.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        stepper.layer.cornerRadius = 5
        outletActivityIndicator.hidesWhenStopped = true
        outletActivityIndicator.color = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        outletActivityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
//
//        UIView.animate(withDuration: 0, delay: 3, options: .curveEaseIn, animations: {
//            self.textView.alpha = 1
//        }) { (finished) in
//            self.outletActivityIndicator.stopAnimating()
//            self.textView.isHidden = false
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
        
        progressView.setProgress(0, animated: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.progressView.progress != 1 {
                self.progressView.progress += 0.2
            } else {
                self.outletActivityIndicator.stopAnimating()
                self.textView.isHidden = false
                UIApplication.shared.endIgnoringInteractionEvents()
                self.progressView.isHidden = true
            }
        }
    }
    @objc func updateTextView(notification: Notification){
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: keyboardFrame.height - bottomConstraint.constant,
                                                 right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // hide keyboard
       // textView.resignFirstResponder()
        
    }
    @IBAction func sizeFont(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        
        textView.font = UIFont(name: font!, size: fontSize)
    }
}
extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = #colorLiteral(red: 0.006343360525, green: 0.003153810278, blue: 0.01266632602, alpha: 1)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        return textView.text.count + (text.count - range.length) <= 1650
    }
    
}


