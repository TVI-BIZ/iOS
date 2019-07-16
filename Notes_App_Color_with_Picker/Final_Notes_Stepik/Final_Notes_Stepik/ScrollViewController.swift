//
//  ScrollViewController.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 15/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageViews = [UIImageView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageNames = ["1","2","3","4","5"]
        
        for name in imageNames {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            //imageView.contentMode = .scaleAspectFit
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for (index, imageView) in imageViews.enumerated(){
            
            imageView.frame.size = scrollView.frame.size
            imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
