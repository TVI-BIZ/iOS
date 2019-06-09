//
//  PlaceModel.swift
//  BestPlaces
//
//  Created by Vlad Tagunkov on 09/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var restaurantImage: String?
    var image: UIImage?
    
      static  let restaurantNames = [
            "Burger Heroes", "Kitchen", "Bonsai", "EastFood",
            "ChinaFood", "X.O", "Grill Bar", "Sherlock Holmes",
            "Speak Easy", "Morris Pub", "Tasty Story",
            "Classic", "Love&Life", "ShockFood", "BarrelBar"
        ]
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        for place in restaurantNames{
            places.append(Place(name: place, location: "Buffalo", type: "Restaurant", restaurantImage: place, image:nil))
        }
        
        
        return places
    }
    
}
