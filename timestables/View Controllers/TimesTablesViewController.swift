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
    
    
    
    //MARK: - Timer Properties and functions
    var timerData = TimerController.sharedInstance.timerData[0]
    var timer = TimerCounter()
    var timerIsSet: Bool?
    
    func updateLabel() {
        if timer.isOn {
            timerPosition1Label.text = "\(timerData.seconds)"
            timerPosition2Label.text = "\(timerData.tensOfSeconds)"
            timerPosition3Label.text = "\(timerData.minutes)"
            timerPosition4Label.text = "\(timerData.tensOfMinutes)"
        } else {
            timerPosition1Label.text = ""
            timerPosition2Label.text = ""
            timerPosition3Label.text = ""
            timerPosition4Label.text = ""
        }
    }
    
    
    
    //MARK: - Times Tables labels
    
    @IBOutlet weak var currentTimesTablesLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var practicingNumberLabel: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    //MARK: - Timer labels, position 1 starts from the right
    
    @IBOutlet weak var timerPosition1Label: UILabel!
    @IBOutlet weak var timerPosition2Label: UILabel!
    @IBOutlet weak var timerPosition3Label: UILabel!
    @IBOutlet weak var timerPosition4Label: UILabel!
    
    //MARK: = Button labels
    
    
    @IBOutlet weak var submitAnswerButton: UIButton!
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
        customBackButton()
        checkTimer()
        timerCounter()
        
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
    
    @objc func back(sender: UIBarButtonItem) {
        timer.stopTimer()
        print ("Timer stopped")
        _ = navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Extensions

extension TimesTablesViewController {
    func timerCounter() {
        if timerData.seconds >= 1 {
            timerData.seconds -= 1
        } else if timerData.tensOfSeconds >= 1 {
            timerData.tensOfSeconds -= 1
            timerData.seconds = 9
        } else if timerData.minutes >= 1 {
            timerData.minutes -= 1
            timerData.tensOfSeconds = 5
            timerData.seconds = 9
        } else if timerData.tensOfMinutes >= 1 {
            timerData.tensOfMinutes -= 1
            timerData.minutes = 9
            timerData.tensOfSeconds = 5
            timerData.seconds = 9
        }
    }
    /// Checks if timer was enabled from previous view
    func checkTimer() {
        if timerIsSet != nil {
            if timerIsSet == true {
                let timerSeconds = Double(timerData.secondsTotaled)
                timer.startTimer(timerSeconds)
            }
        } else {
            print ("timerIsSet came back nil")
            timerIsSet = false
        }
    }
    
    func customBackButton() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(TimesTablesViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
}

//MARK: Delegates

extension TimesTablesViewController: TimerCounterDelegate {
//    func timerStopped() {
//        <#code#>
//    }
    
    func timerCompleted() {
        StatsController.sharedInstance.updateStatsNonGlobal(stats: statsInstance[timesTables! - 1], score: score)
        submitAnswerButton.isHidden = true
        let alertController = UIAlertController.init(title: "Times Up!", message: "You ran out of time. Your score has been saved", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    func timerSecondTicked() {
        timerCounter()
        updateLabel()
    }
    
    
}
