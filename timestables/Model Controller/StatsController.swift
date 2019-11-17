//
//  StatsController.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/13/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CoreData

class StatsController {
    
    static let sharedInstance = StatsController()
    
    var fetchedResultsController: NSFetchedResultsController<Stats>
    
    init() {
        
        let fetchRequest: NSFetchRequest<Stats> = Stats.fetchRequest()
        
        let resultsController: NSFetchedResultsController<Stats> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print ("There was an error performing the fetch! \(error.localizedDescription)")
        }
    }
    
    // TODO: - Initialize these all at once once user starts. Just check if stats array is empty or not, if empty then initialize, otherwise just fetch the current stats for that times table.
    

    
    var stats: [Stats] = []
    
    //CRUD
    
    // Initializes stats and stats array on the first practice
    func initializeStats() {
        let statsGlobal = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsTwos = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsThrees = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsFours = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsFives = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsSixes = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsSevens = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsEights = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        let statsNines = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, scoresArray:[])
        stats.append(statsGlobal)
        stats.append(statsTwos)
        stats.append(statsThrees)
        stats.append(statsFours)
        stats.append(statsFives)
        stats.append(statsSixes)
        stats.append(statsSevens)
        stats.append(statsEights)
        stats.append(statsNines)
    }
    
    // Function to be called each time a practice run is completed. Updates all stats attributes except average score. That is to be calculated when the stats view is loaded.
    func updateStatsNonGlobal(stats: Stats, score: Double) {
        stats.attempts += 1
        if score > stats.highestScore {
            stats.highestScore = score
        }
        stats.lastScore = stats.currentScore
        stats.currentScore = score
        stats.scoresArray?.append(score)
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
