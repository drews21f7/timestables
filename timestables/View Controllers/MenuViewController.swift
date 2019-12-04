//
//  MenuViewController.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/26/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - VC Properties
    
    var timerInstance = TimerController.sharedInstance
    
    //Tracks the index of the stats array from StatsController
    var statsIDNumber = 0
    
    var timesTableSelected = false
    
    //MARK: - Button outlets
    
    @IBOutlet weak var setTimerButton: UIButton!
    
    
    
    //MARK: - Timer Properties
    
    var timerIsSet = false
    
    var numPad: Int16 = 0
    
    var tensOfMinutes: Int16 = 0
    var minutes: Int16 = 0
    var tensOfSeconds: Int16 = 0
    var seconds: Int16 = 0
    
    var timerPosition = 1
    
    
    // Timer labels, position 1 starts from the right
    

    @IBOutlet weak var timerPosition1Label: UILabel!
    @IBOutlet weak var timerPosition2Label: UILabel!
    @IBOutlet weak var timerPosition3Label: UILabel!
    @IBOutlet weak var timerPosition4Label: UILabel!
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timerFetch = TimerController.sharedInstance.fetchedResultsController
        if timerFetch.fetchedObjects?.isEmpty == true {
            DispatchQueue.main.async {
                self.timerPosition1Label.text = "0"
                self.timerPosition2Label.text = "0"
                self.timerPosition3Label.text = "0"
                self.timerPosition4Label.text = "0"
            }
            print ("No timer saved")
        } else {
            for timer in timerFetch.fetchedObjects! {
                timerInstance.timerData.append(timer)
            }
            DispatchQueue.main.async {
                self.timerPosition1Label.text = "\(self.timerInstance.timerData[0].seconds)"
                self.timerPosition2Label.text = "\(self.timerInstance.timerData[0].tensOfSeconds)"
                self.timerPosition3Label.text = "\(self.timerInstance.timerData[0].minutes)"
                self.timerPosition4Label.text = "\(self.timerInstance.timerData[0].tensOfMinutes)"
            }
            print ("Timer fetched")
        }

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Times tables action buttons
    
    // Stats ID number should be one less than the number selected i.e. twosButton should be 1, threesButton should be 2 ect. ect.
    
    @IBAction func twosButtonTapped(_ sender: Any) {
        statsIDNumber = 1
        timesTableSelected = true
    }
    @IBAction func threesButtonTapped(_ sender: Any) {
        statsIDNumber = 2
        timesTableSelected = true
    }
    @IBAction func foursButtonTapped(_ sender: Any) {
        statsIDNumber = 3
        timesTableSelected = true
    }
    @IBAction func fivesButtonTapped(_ sender: Any) {
        statsIDNumber = 4
        timesTableSelected = true
    }
    @IBAction func sixesButtonTapped(_ sender: Any) {
        statsIDNumber = 5
        timesTableSelected = true
    }
    @IBAction func sevensButtonTapped(_ sender: Any) {
        statsIDNumber = 6
        timesTableSelected = true
    }
    @IBAction func eightsButtonTapped(_ sender: Any) {
        statsIDNumber = 7
        timesTableSelected = true
    }
    @IBAction func ninesButtonTapped(_ sender: Any) {
        statsIDNumber = 8
        timesTableSelected = true
    }
    
    
    
    //MARK: - Timer action buttons
    
    @IBAction func numPad1ButtonTapped(_ sender: Any) {
        numPad = 1
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad2ButtonTapped(_ sender: Any) {
        numPad = 2
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad3ButtonTapped(_ sender: Any) {
        numPad = 3
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad4ButtonTapped(_ sender: Any) {
        numPad = 4
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad5ButtonTapped(_ sender: Any) {
        numPad = 5
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad6ButtonTapped(_ sender: Any) {
        numPad = 6
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad7ButtonTapped(_ sender: Any) {
        numPad = 7
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad8ButtonTapped(_ sender: Any) {
        numPad = 8
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad9ButtonTapped(_ sender: Any) {
        numPad = 9
        changeTimer(numPad: numPad)
    }
    @IBAction func numPad0ButtonTapped(_ sender: Any) {
        numPad = 0
        changeTimer(numPad: numPad)
    }
    
    @IBAction func setTimerButtonTapped(_ sender: Any) {
        if timerIsSet == false {
            if self.timerInstance.timerData.isEmpty == true {
                self.timerInstance.createTimer(tensOfMinutes: tensOfMinutes, minutes: minutes, tensOfSeconds: tensOfSeconds, seconds: seconds)
            } else {
                self.timerInstance.updateTimer(timer: self.timerInstance.timerData[0], tensOfMinutes: tensOfMinutes, minutes: minutes, tensOfSeconds: tensOfSeconds, seconds: seconds)
            }
            timerIsSet = true
            setTimerButton.titleLabel?.text = ("Disable Timer")
            
            
        } else {
            timerIsSet = false
            setTimerButton.titleLabel?.text = ("Set Timer")
        }
    }
    @IBAction func clearTimerButtonTapped(_ sender: Any) {
        timerPosition = 1
        seconds = 0
        tensOfSeconds = 0
        minutes = 0
        tensOfMinutes = 0
        DispatchQueue.main.async {
            self.timerPosition1Label.text = "0"
            self.timerPosition2Label.text = "0"
            self.timerPosition3Label.text = "0"
            self.timerPosition4Label.text = "0"
        }
    }
    
    @IBAction func deleteTimerButtonTapped(_ sender: Any) {
        timerInstance.deleteTimer(timer: timerInstance.timerData[0])
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

//MARK: - Extensions

extension MenuViewController {
    
    // Changes the position of the timer based on timer button pressed. Also keeps track of timer attributes to be made into Timer object later.
    func changeTimer(numPad: Int16) {
        if timerPosition == 1 {
            DispatchQueue.main.async {
                self.timerPosition1Label.text = "\(numPad)"
            }
            seconds = numPad
            timerPosition += 1
        }
        else if timerPosition == 2 {
            DispatchQueue.main.async {
                self.timerPosition2Label.text = self.timerPosition1Label.text
                self.timerPosition1Label.text = "\(numPad)"
            }
            tensOfSeconds = seconds
            seconds = numPad
            timerPosition += 1
        }
        else if timerPosition == 3 {
            DispatchQueue.main.async {
                self.timerPosition3Label.text = self.timerPosition2Label.text
                self.timerPosition2Label.text = self.timerPosition1Label.text
                self.timerPosition1Label.text = "\(numPad)"
            }
            minutes = tensOfSeconds
            tensOfSeconds = seconds
            seconds = numPad
            timerPosition += 1
        }
        else if timerPosition == 4 {
            DispatchQueue.main.async {
                self.timerPosition4Label.text = self.timerPosition3Label.text
                self.timerPosition3Label.text = self.timerPosition2Label.text
                self.timerPosition2Label.text = self.timerPosition1Label.text
                self.timerPosition1Label.text = "\(numPad)"
            }
            tensOfMinutes = minutes
            minutes = tensOfSeconds
            tensOfSeconds = seconds
            seconds = numPad
            timerPosition = 1
        }
    }
}
