//
//  ViewController.swift
//  Sport_Stopwatch
//
//  Created by Vlad Tagunkov on 06/08/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    let cellIdentifier = "DataCell"
    var backgroundContext: NSManagedObjectContext!
    var context: NSManagedObjectContext! {
        didSet{
            tableView.refreshControl?.endRefreshing()
            setupFetchResultController(for: context)
            fetchData()
            
            
        }
    }
    var pressStop = false
    var timeStart: Date!
    var timerTimeArray = [TimerWatch]()
    
    private var fetchResultController: NSFetchedResultsController<TimerWatch>?
    
    
    
    
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var headTitle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        timeStart = Date()
        //headTitle.title = "Resalts"
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.beginRefreshing()
        
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextDidSave(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
        //tableView.reloadData()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
    }
    @objc func managedObjectContextDidSave(notification: Notification){
        context.perform {
            self.context.mergeChanges(fromContextDidSave: notification)
            
        }
    }
    
    
    func setupFetchResultController(for context: NSManagedObjectContext){
        //let sortDescriptor =  NSSortDescriptor(key: "laptime", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "addData", ascending: false)
        let request = NSFetchRequest<TimerWatch>(entityName: "TimerWatch")
        request.sortDescriptors = [ sortDescriptor2 ]
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController?.delegate = self
        
    }
    func fetchData(){
        //let sortDescriptor = NSSortDescriptor(key: "laptime", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "addData", ascending: false)
        let request = NSFetchRequest<TimerWatch>(entityName: "TimerWatch")
        request.sortDescriptors = [ sortDescriptor2 ]
        timerTimeArray = try! context.fetch(request)

        
        
        
        try! fetchResultController?.performFetch()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        
        
    }

    
    

    @IBAction func addButtonPressed(_ sender: Any) {
        
        
        let elapsed = Date().timeIntervalSince(timeStart).stringFromTimeInterval()
        print(elapsed)
        timeStart = Date()
 
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            guard let self = self else {return}
            let timeValue = TimerWatch(context: self.backgroundContext)
            timeValue.laptime = elapsed
            timeValue.addData = self.timeStart
            self.backgroundContext.performAndWait {
                do{
                    try self.backgroundContext.save()
                } catch{
                    print(error)
                }
            }
            
        }
        
        
    }
    
    @IBAction func puttonPressed(_ sender: Any) {
       
        if (!pressStop){
            pressStop = true
   
        } else if (pressStop) {
            pressStop = false
          
        }
        
        if (pressStop){
            headTitle.title = "Time started"
            buttonLabel.setTitle("Stop", for: .normal)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            headTitle.title = "Results"
            buttonLabel.setTitle("Start", for: .normal)
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
}



extension ViewController: UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultController?.sections else {
            return 0
        }
        return sections[section].numberOfObjects
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let timeVal = fetchResultController?.object(at: indexPath) else {
            return cell
        }
        cell.textLabel?.text = timeVal.laptime
        return cell
    }
    
    
}




extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [newIndexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
       
        }
    }
    
    
    
    
    
}
extension TimeInterval {
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}
