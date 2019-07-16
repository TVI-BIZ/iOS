//
//  ViewController.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 14/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var EditButtonLabel: UIBarButtonItem!
    
    @IBAction func EditButtonPressed(_ sender: Any) {
        //print("Edit Button Tapped!")
        //tb.isEditing = true
        //print("Editing mode after tapping is \(tb.isEditing)")
        //print("Editing mode before tapping is \(tb.isEditing)")
        
        if tb.isEditing == false {
            tb.isEditing = true
            EditButtonLabel.title = "Save"
        } else {
            tb.isEditing = false
            EditButtonLabel.title = "Edit"
        }
        
        
         //print("Editing mode after tapping is \(tb.isEditing)")
    }
    
    @IBAction func PlusButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddNoteEdit", sender: nil)
        //ViewController.counter = Notes.allNotes.count + 1
    }
    
    //var notesCategories = Notes.allNotes

    @IBOutlet weak var tb: UITableView!
    static var counter: Int = 0
   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ColorPickerVC, segue.identifier == "AddNoteEdit" {
            Notes.allNotes.append(Note(title: "Default", noteText: "Default", noteColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
            controller.titleTextFromAdd = Notes.allNotes.last?.title
            controller.noteTextFromAdd = Notes.allNotes.last?.noteText
            ViewController.counter = Notes.allNotes.count - 1
            //print("Count notes is: \(Notes.allNotes.count)")
        }
        if let controller2 = segue.destination as? ColorPickerVC, segue.identifier == "EditScreen"{
            controller2.titleTextFromAdd = Notes.allNotes[ViewController.counter].title
            controller2.noteTextFromAdd = Notes.allNotes[ViewController.counter].noteText
            //print("Segue Counter")
            //print(counter)
        }
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { self.tb.reloadData() }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("Editing mode is \(tb.isEditing)")
        tb.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.allNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // standart cell variant. no custom cell!
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        let note = Notes.allNotes[indexPath.row]
//        let iconView = UIView()
//        iconView.frame.size = CGSize(width: 10, height: 10)
//        iconView.backgroundColor = note.noteColor
//
//        var imageIcon = iconView.asImage()
//
//        cell.textLabel?.text = note.title
//        cell.textLabel?.numberOfLines = 0
//        cell.detailTextLabel?.text = note.noteText
//        cell.detailTextLabel?.numberOfLines = 0
//
//        cell.imageView?.image = imageIcon
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let note = Notes.allNotes[indexPath.row]
        
        cell.cellTitle.text = note.title
        cell.cellText.text = note.noteText
        cell.cellNoteColor.backgroundColor = note.noteColor
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let mypicker = ColorPickerVC()
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        ViewController.counter = indexPath.row
        performSegue(withIdentifier: "EditScreen", sender: cell)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if tb.isEditing == true {
            if editingStyle == .delete {
                Notes.allNotes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}




