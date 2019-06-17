//
//  ViewController.swift
//  FireB
//
//  Created by Vlad Tagunkov on 16/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let sequeIdentifier: String = "tasksSegue"
    var ref: DatabaseReference!
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        warnLabel.alpha = 0
        Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.sequeIdentifier)!, sender: nil)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.text = ""
        passwordTextfield.text = ""
    }
    
    @objc func kbDidShow(notification: Notification){
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        
    }
    @objc func kbDidHide(){
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    func displayWarningLabel(with text: String){
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextfield.text, email != "", password != "" else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(with: "Error accured!")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(with: "No such user")
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextfield.text, email != "", password != "" else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: {  (user, error) in
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                return
            }
            
            //let userRef = self?.ref.
            //userRef?.setValue(["email": user?.email])
            let userRef = self.ref.child((user?.user.uid)!)
            userRef.setValue(["email":user?.user.email])
        })
    }
}

