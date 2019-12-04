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
    
    var fetchedResultsController: NSFetchedResultsController<TimerData>
    
    init() {
        
        let fetchRequest: NSFetchRequest<TimerData> = TimerData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "secondsTotaled", ascending: true)]
        
        let resultsController: NSFetchedResultsController<TimerData> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print ("There was an error performing the fetch! \(error.localizedDescription)")
        }
    }
    
    var timerData: [TimerData] = []
    
    //MARK: - CRUD
    
    
    // Takes in a traditional timer number, converts it into seconds, and turns it into a timer object
    
    func createTimer(tensOfMinutes: Int16, minutes: Int16, tensOfSeconds: Int16, seconds: Int16) {
        var timeInSeconds: Int16 = 0
        timeInSeconds += tensOfMinutes * 10 * 60
        timeInSeconds += minutes * 60
        timeInSeconds += tensOfSeconds * 10
        timeInSeconds += seconds
        let newTimer = TimerData(seconds: seconds, tensOfSeconds: tensOfSeconds, minutes: minutes, tensOfMinutes: tensOfMinutes, secondsTotaled: timeInSeconds)
        timerData.append(newTimer)
        saveToPersistentStore()
        print ("Timer created")
    }
    
    func updateTimer(timer: TimerData, tensOfMinutes: Int16, minutes: Int16, tensOfSeconds: Int16, seconds: Int16) {
        var timeInSeconds: Int16 = 0
        timeInSeconds += tensOfMinutes * 10 * 60
        timeInSeconds += minutes * 60
        timeInSeconds += tensOfSeconds * 10
        timeInSeconds += seconds
        timer.tensOfMinutes = tensOfMinutes
        timer.minutes = minutes
        timer.tensOfSeconds = tensOfSeconds
        timer.seconds = seconds
        timer.secondsTotaled = timeInSeconds
        saveToPersistentStore()
        print ("Timer Updated")
    }
    
    func deleteTimer(timer: TimerData) {
        CoreDataStack.managedObjectContext.delete(timer)
        saveToPersistentStore()
        print ("buhleeted")
    }
    
    //MARK: - Persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print ("Error saving managed object. Item not saved!")
        }
    }
}
