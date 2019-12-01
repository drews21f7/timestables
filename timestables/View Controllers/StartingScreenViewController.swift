//
//  StartingScreenViewController.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/25/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class StartingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if StatsController.sharedInstance.fetchedResultsController.fetchedObjects?.isEmpty == true {
            StatsController.sharedInstance.initializeStats()
            print ("Stats Initialized")
        } else {
            for stats in StatsController.sharedInstance.fetchedResultsController.fetchedObjects! {
                StatsController.sharedInstance.stats.append(stats)
            }
            print ("Stats appended to SOT")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
