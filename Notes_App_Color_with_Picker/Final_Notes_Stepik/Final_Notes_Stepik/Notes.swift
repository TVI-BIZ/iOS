//
//  Notes.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 14/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

struct Notes{
    var notes: [Note]
}


//struct Note{
//    var title: String
//    var noteText: String
//
//}
//
//extension Notes {
//    static var allNotes:[Note] =
//
//                        [Note(title: "ShortNote1", noteText: "This is a short note 1."),
//                        Note(title: "ShortNote2", noteText: "This is a short note 2."),
//                        Note(title: "ShortNote3", noteText: "This is a short note 3."),
//                        Note(title: "MiddleNote1", noteText: "Middle1"),
//                        Note(title: "MiddleNote2", noteText: "Middle2"),
//                        Note(title: "MiddleNote3", noteText: "Middle3"),
//                        Note(title: "LongNote1", noteText: "Long1"),
//                        Note(title: "LongNote2", noteText: "Long2"),
//                        Note(title: "LongNote3", noteText: "Long3")
//                        ]
//}

struct Note{
    var title: String
    var noteText: String
    var noteColor: UIColor
    
}

extension Notes {
    static var allNotes:[Note] =
        
        [Note(title: "ShortNote1", noteText: "This is a short note 1.", noteColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
         Note(title: "ShortNote2", noteText: "This is a short note 2.", noteColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
         Note(title: "ShortNote3", noteText: "This is a short note 3.", noteColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
         Note(title: "MiddleNote1", noteText: "This is a middle note 1.This is a middle note 1.", noteColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
         Note(title: "MiddleNote2", noteText: "This is a middle note 2.This is a middle note 2.", noteColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
         Note(title: "MiddleNote3", noteText: "This is a middle note 3.This is a middle note 3.", noteColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
         Note(title: "LongNote1", noteText: "This is a long note 1.This is a long note 1.This is a long note 1.", noteColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
         Note(title: "LongNote2", noteText: "This is a long note 2.This is a long note 2.This is a long note 2.", noteColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
         Note(title: "LongNote3", noteText: "This is a long note 3.This is a long note 3.This is a long note 3.", noteColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    ]
}

