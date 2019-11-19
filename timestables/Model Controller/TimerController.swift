//
//  TimerController.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/18/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CoreData

class TimerController {
    
    static let sharedInstance = TimerController()
    
    var fetchedResultsController: NSFetchedResultsController<Timer>
    
    init() {
        
        let fetchRequest: NSFetchRequest<Timer> = Timer.fetchRequest()
        
        let resultsController: NSFetchedResultsController<Timer> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print ("There was an error performing the fetch! \(error.localizedDescription)")
        }
    }
    
    var timer: [Timer] = []
    
    //CRUD
    
    
    // Takes in a traditional timer number, converts it into seconds, and turns it into a timer object
    
    func createTimer(tensOfMinutes: Int16, minutes: Int16, tensOfSeconds: Int16, seconds: Int16) {
        var timeInSeconds: Int16 = 0
        timeInSeconds += tensOfMinutes * 10 * 60
        timeInSeconds += minutes * 60
        timeInSeconds += tensOfSeconds * 10
        timeInSeconds += seconds
        let newTimer = Timer(seconds: timeInSeconds)
        timer.append(newTimer)
        saveToPersistentStore()
    }
    
    func updateTimer(timer: Timer, tensOfMinutes: Int16, minutes: Int16, tensOfSeconds: Int16, seconds: Int16) {
        var timeInSeconds: Int16 = 0
        timeInSeconds += tensOfMinutes * 10 * 60
        timeInSeconds += minutes * 60
        timeInSeconds += tensOfSeconds * 10
        timeInSeconds += seconds
        timer.seconds = timeInSeconds
        saveToPersistentStore()
    }
    
    // Save to Coredata
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print ("Error saving managed object. Item not saved!")
        }
    }
}
