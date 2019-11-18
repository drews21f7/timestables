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
        let statsGlobal = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsTwos = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsThrees = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsFours = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsFives = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsSixes = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsSevens = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsEights = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
        let statsNines = Stats(attempts: 0, averageScore: 0, highestScore: 0, lastScore: 0, currentScore: 0, cumulativeScore: 0)
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
    
    // Function to be called each time a practice run is completed. Updates all stats attributes. It also updates the global lastScore and currentScore.
    
    func updateStatsNonGlobal(stats: Stats, score: Double) {
        let globalStats = StatsController.sharedInstance.stats[0]
        stats.attempts += 1
        stats.cumulativeScore += score
        if score > stats.highestScore {
            stats.highestScore = score
        }
        globalStats.lastScore = globalStats.currentScore
        globalStats.currentScore = score
        stats.lastScore = stats.currentScore
        stats.currentScore = score
        stats.averageScore = stats.cumulativeScore / stats.attempts
        saveToPersistentStore()
    }
    
    // Function to be called whenever the stats view is brought up. Adds all the stats together for a global count across all times tables practices.
    
    func updateStatsGlobal(globalStats: Stats) {
        let statsArray = StatsController.sharedInstance.stats
        for stats in statsArray where stats != statsArray[0] {
            globalStats.attempts += stats.attempts
            if stats.highestScore > globalStats.highestScore {
                globalStats.highestScore = stats.highestScore
            }
            globalStats.cumulativeScore += stats.cumulativeScore
        }
        globalStats.averageScore = globalStats.cumulativeScore / globalStats.attempts
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
