//
//  PlaceModel.swift
//  BestPlaces
//
//  Created by Vlad Tagunkov on 09/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
 
    
      let restaurantNames = [
            "Burger Heroes", "Kitchen", "Bonsai", "EastFood",
            "ChinaFood", "X.O", "Grill Bar", "Sherlock Holmes",
            "Speak Easy", "Morris Pub", "Tasty Story",
            "Classic", "Love&Life", "ShockFood", "BarrelBar"
        ]
    
    func savePlaces()  {
        
        
        
        for place in restaurantNames{
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else {return}
            
            
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "Boston"
            newPlace.type = "Bar"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
            
        }
        
      
    }
    
}
