//
//  ViewController.swift
//  AnimalsEngApp
//
//  Created by Ivan Demchenko on 3/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var AnimalText: UILabel!
    
    @IBOutlet weak var AnimalBtnFirst: UIButton!
    @IBOutlet weak var AnimalBtnSecond: UIButton!
    @IBOutlet weak var AnimalBtnThird: UIButton!
    @IBOutlet weak var AnimalBtnFour: UIButton!
    @IBOutlet weak var ScoreCount: UILabel!
    
    
    
    let animalsImage: [String : UIImage?] = ["Pig" : #imageLiteral(resourceName: "icons8-pig"), "Horse" : #imageLiteral(resourceName: "icons8-trotting_horse"), "Elephant" : #imageLiteral(resourceName: "icons8-elephant"), "Sheep" : #imageLiteral(resourceName: "icons8-sheep"), "Rat" : #imageLiteral(resourceName: "icons8-rat_silhouette"), "Bird" : #imageLiteral(resourceName: "icons8-top_view_bird")]
    
    let animalsName = ["Pig", "Horse", "Elephant", "Sheep", "Rat", "Bird"]
    var notChooseAnimals = [""]
    var randAnimal = ""
    var animalOfBtnFirst = ""
    var animalOfBtnSecond = ""
    var animalOfBtnThird = ""
    var animalOfBtnFour = ""
    var score = 0
    
    var checkFirst = "Not correctly"
    var checkSecond = "Not correctly"
    var checkThird = "Not correctly"
    var checkFour = "Not correctly"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ScoreCount.text = "0"
        setAnimalText()
        setArrayWithoutChooseAnimal()
        randBtn()
        setImage()
        
    }
    
    func setAnimalText() {
        randAnimal = animalsName.randomElement()!
        AnimalText.text = randAnimal
    }
    
    func setImage() {
        AnimalBtnFirst.setImage(animalsImage[animalOfBtnFirst] as? UIImage, for: .normal)
        AnimalBtnSecond.setImage(animalsImage[animalOfBtnSecond] as? UIImage, for: .normal)
        AnimalBtnThird.setImage(animalsImage[animalOfBtnThird] as? UIImage, for: .normal)
        AnimalBtnFour.setImage(animalsImage[animalOfBtnFour] as? UIImage, for: .normal)
    }
    
    func setArrayWithoutChooseAnimal() {
        notChooseAnimals = animalsName.filter {
            animal in
            return animal != randAnimal
        }
        notChooseAnimals.shuffle()
    }
    
    
    
    func randBtn() {
        switch Int.random(in: 1...4) {
        case 1:
            animalOfBtnFirst = randAnimal
            animalOfBtnSecond = notChooseAnimals[1]
            animalOfBtnThird = notChooseAnimals[2]
            animalOfBtnFour = notChooseAnimals[3]
            checkFirst = "Correctly"
            checkSecond = "Not correctly"
            checkThird = "Not correctly"
            checkFour = "Not correctly"
        case 2:
            animalOfBtnFirst = notChooseAnimals[1]
            animalOfBtnSecond = randAnimal
            animalOfBtnThird = notChooseAnimals[2]
            animalOfBtnFour = notChooseAnimals[3]
            
            checkFirst = "Not correctly"
            checkSecond = "Correctly"
            checkThird = "Not correctly"
            checkFour = "Not correctly"
        case 3:
            animalOfBtnFirst = notChooseAnimals[1]
            animalOfBtnSecond = notChooseAnimals[2]
            animalOfBtnThird = randAnimal
            animalOfBtnFour = notChooseAnimals[3]
            
            checkFirst = "Not correctly"
            checkSecond = "Not correctly"
            checkThird = "Correctly"
            checkFour = "Not correctly"
        case 4:
            animalOfBtnFirst = notChooseAnimals[1]
            animalOfBtnSecond = notChooseAnimals[2]
            animalOfBtnThird = notChooseAnimals[3]
            animalOfBtnFour = randAnimal
            
            checkFirst = "Not correctly"
            checkSecond = "Not correctly"
            checkThird = "Not correctly"
            checkFour = "Correctly"
        default: AnimalText.text = "Error"
        }
    }
    
    
    
    
    func animate() {
        UIView.animate(withDuration: 1.5, animations:{
            self.AnimalText.alpha = 1
        } )
    }
    
    func btnEnableIsFalse() {
        AnimalBtnFirst.isEnabled = false
        AnimalBtnSecond.isEnabled = false
        AnimalBtnThird.isEnabled = false
        AnimalBtnFour.isEnabled = false
    }
    
    func scoreCheck(check: String) {
        if check == "Correctly" {
            score += 1
        } else {
            score -= 1
        }
        ScoreCount.text = String(score)
    }
    
    @IBAction func BtnNextPress() {
        setAnimalText()
        setArrayWithoutChooseAnimal()
        randBtn()
        setImage()
        AnimalBtnFirst.isEnabled = true
        AnimalBtnSecond.isEnabled = true
        AnimalBtnThird.isEnabled = true
        AnimalBtnFour.isEnabled = true
    }
    
    
    @IBAction func BtnFirstPress(_ sender: Any) {
        AnimalText.alpha = 0
        AnimalText.text = checkFirst
        animate()
        btnEnableIsFalse()
        scoreCheck(check: checkFirst)
    }
    
    @IBAction func BtnSecondPress(_ sender: Any) {
        AnimalText.alpha = 0
        AnimalText.text = checkSecond
        animate()
        btnEnableIsFalse()
        scoreCheck(check: checkSecond)
    }
    
    
    @IBAction func BtnThirdPress(_ sender: Any) {
        AnimalText.alpha = 0
        AnimalText.text = checkThird
        animate()
        btnEnableIsFalse()
        scoreCheck(check: checkThird)
    }
    
    
    @IBAction func BtnFourPress(_ sender: Any) {
        AnimalText.alpha = 0
        AnimalText.text = checkFour
        animate()
        btnEnableIsFalse()
        scoreCheck(check: checkFour)
    }
}

