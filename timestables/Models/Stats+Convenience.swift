//
//  Stats+Convenience.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/11/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CoreData

extension Stats {
    convenience init(attempts: Int64, averageScore: Double, highestScore: Double, lastScore: Double, currentScore: Double, scoresArray: [Double], context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.attempts = attempts
        self.averageScore = averageScore
        self.highestScore = highestScore
        self.lastScore = lastScore
        self.currentScore = currentScore
        self.scoresArray = scoresArray
    }
}
