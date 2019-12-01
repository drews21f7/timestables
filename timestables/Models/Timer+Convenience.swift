//
//  Timer+Convenience.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/18/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CoreData

extension Timer {
    convenience init(seconds: Int16, tensOfSeconds: Int16, minutes: Int16, tensOfMinutes: Int16, secondsTotaled: Int16, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.seconds = seconds
        self.tensOfSeconds = tensOfSeconds
        self.minutes = minutes
        self.tensOfMinutes = tensOfMinutes
        self.secondsTotaled = secondsTotaled
    }
}
