//
//  TimesTablesViewController.swift
//  timestables
//
//  Created by Drew Seeholzer on 11/30/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class TimesTablesViewController: UIViewController {
    
    //MARK: - VC Properties
    
    var statsInstance = StatsController.sharedInstance.stats
    var timesTables: Int?
    var score: Double = 0 {
        didSet {
            currentScoreLabel.text = "\(score)"
        }
    }
    // answerInt is used to check if answer is correct, answerString is used to show user their answer via answerLabel. answerString becomes answerInt and label updates each time a numpad button is pressed
    var answerInt = 0
    var answerString: String = "" {
        didSet {
            answerLabel.text = answerString
            answerInt = Int(answerString) ?? 0
        }
    }
    
    
    
    //MARK: - Timer Properties
    var timerData = TimerController.sharedInstance.timerData[0]
    var timer = TimerCounter()
    var timerIsSet: Bool?
    
    
    
    //MARK: - Times Tables labels
    
    @IBOutlet weak var currentTimesTablesLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var practicingNumberLabel: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    //MARK: - Timer labels
    
    @IBOutlet weak var timerPosition1Label: UILabel!
    @IBOutlet weak var timerPosition2Label: UILabel!
    @IBOutlet weak var timerPosition3Label: UILabel!
    @IBOutlet weak var timerPosition4Label: UILabel!
    
    //MARK: = Button labels
    
    
    @IBOutlet weak var submitAnswerButton: UIButton!
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO - Make error message appear if times tables number isn't found
        guard let timesTables = timesTables else { print ("Error, no times tables number found"); return }
        beginPractice(timesTables: timesTables)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Times Tables Logic
    
    var rounds = 0
    var randomNumberArray: [Int] = [2,3,4,5,6,7,8,9]
    var currentQuestion = 0 {
        didSet {
            DispatchQueue.main.async {
                self.randomNumberLabel.text = "\(self.currentQuestion)"
            }
        }
    }
    
    /// Initializes the current practice run by randomizing practice numbers, setting the first question, and updating related labels.
    
    func beginPractice(timesTables: Int) {
        currentTimesTablesLabel.text = "\(timesTables)"
        currentScoreLabel.text = "0"
        practicingNumberLabel.text = "\(timesTables)"
        randomNumberArray = randomNumberArray.shuffled()
        randomNumberLabel.text = "\(randomNumberArray[0])"
        currentQuestion = randomNumberArray[0]
        submitAnswerButton.isHidden = false
    }
    
    /// Checks if the users answer is correct and adds to their score if it is. Also advances the users current practice run by updating the the question, labels, and how many questions are left. Answer info is from answerInt, question info is from currentQuestion
    
    func answerCheck(answer: Int, question: Int) {
        let stats = statsInstance[timesTables! - 1]
        let correctAnswer = timesTables! * question
        if answer == correctAnswer {
            answerString = ""
            rounds += 1
            randomNumberArray.remove(at: 0)
            score += 1
            if rounds < 8 {
                currentQuestion = randomNumberArray[0]
            } else {
                // Updates user's stats
                 StatsController.sharedInstance.updateStatsNonGlobal(stats: stats, score: score)
                 submitAnswerButton.isHidden = true
            }
            
        } else {
            answerString = ""
            rounds += 1
            randomNumberArray.remove(at: 0)
            if rounds < 8 {
                currentQuestion = randomNumberArray[0]
            } else {
                // Updates user's stats
                 StatsController.sharedInstance.updateStatsNonGlobal(stats: stats, score: score)
                 submitAnswerButton.isHidden = true
            }
        }
    }
    
    
    
    //MARK: - Answer Action Buttons
    
    @IBAction func numPad1ButtonTapped(_ sender: Any) {
        answerString += "1"
    }
    @IBAction func numPad2ButtonTapped(_ sender: Any) {
        answerString += "2"
    }
    @IBAction func numPad3ButtonTapped(_ sender: Any) {
        answerString += "3"
    }
    @IBAction func numPad4ButtonTapped(_ sender: Any) {
        answerString += "4"
    }
    @IBAction func numPad5ButtonTapped(_ sender: Any) {
        answerString += "5"
    }
    @IBAction func numPad6ButtonTapped(_ sender: Any) {
        answerString += "6"
    }
    @IBAction func numPad7ButtonTapped(_ sender: Any) {
        answerString += "7"
    }
    @IBAction func numPad8ButtonTapped(_ sender: Any) {
        answerString += "8"
    }
    @IBAction func numPad9ButtonTapped(_ sender: Any) {
        answerString += "9"
    }
    @IBAction func numPad0ButtonTapped(_ sender: Any) {
        answerString += "0"
    }
    
    
    @IBAction func clearAnswerButtonTapped(_ sender: Any) {
        answerString = ""
    }
    @IBAction func submitAnswerButtonTapped(_ sender: Any) {
        answerCheck(answer: answerInt, question: currentQuestion)
    }
    
}
