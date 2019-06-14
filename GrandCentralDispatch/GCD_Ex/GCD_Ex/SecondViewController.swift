//
//  SecondViewController.swift
//  GCD_Ex
//
//  Created by Vlad Tagunkov on 13/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ImageViews: UIImageView!
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
         return ImageViews.image
        }
        set{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            ImageViews.image = newValue
            ImageViews.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        loginAlert()
        delay(3) {
            self.loginAlert()
        }
    }
    fileprivate func delay(_ delay: Int, closure: @escaping()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() +  .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert(){
        let ac = UIAlertController(title: "Already registered?", message: "Enter your login and password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Enter login"
        }
        ac.addTextField { (userPasswordTf) in
            userPasswordTf.placeholder = "Enter password"
            userPasswordTf.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
        
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://javarush.ru/images/lectures/image-ru-00-14.png")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        }
    }

