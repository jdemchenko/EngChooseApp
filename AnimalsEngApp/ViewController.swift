//
//  ViewController.swift
//  AnimalsEngApp
//
//  Created by Ivan Demchenko on 3/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - ID Outlets
    @IBOutlet weak var AnimalText: UILabel!
    @IBOutlet weak var ScoreCount: UILabel!
    @IBOutlet weak var YouWin: UILabel!
    
    @IBOutlet weak var heartOne: UIImageView!
    @IBOutlet weak var heartTwo: UIImageView!
    @IBOutlet weak var heartThree: UIImageView!
    @IBOutlet weak var heartFour: UIImageView!
    
    @IBOutlet weak var ScoreStack: UIStackView!
    
    @IBOutlet weak var AnimalBtnFirst: UIButton!
    @IBOutlet weak var AnimalBtnSecond: UIButton!
    @IBOutlet weak var AnimalBtnThird: UIButton!
    @IBOutlet weak var AnimalBtnFour: UIButton!
    
    
    
    
    // MARK: - Public Properties
    var animalsImage: [String : UIImage?] = [:]
    var animalsName = [""]
    
    
    
    var notChooseAnimals = [""]
    var randAnimal = ""
    var animalOfBtnFirst = ""
    var animalOfBtnSecond = ""
    var animalOfBtnThird = ""
    var animalOfBtnFour = ""
    var score = 0
    var life = 4
    var answersWithoutMistakes = 0
    
    var checkFirst = "Not correctly"
    var checkSecond = "Not correctly"
    var checkThird = "Not correctly"
    var checkFour = "Not correctly"
    
    var checkPack = ""
    
    // MARK: Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePack()
        animalsName = Array(animalsImage.keys)
        YouWin.isHidden = true
        ScoreCount.text = "0"
        setAnimalText()
        setArrayWithoutChooseAnimal()
        randBtn()
        setImage()
    }
    
    
    
    
    
    // MARK: ID Action
    @IBAction func BtnFirstPress(_ sender: Any) {
        btnPressAction(whichCheck: checkFirst)
        answerCheck(check: checkFirst, btn: AnimalBtnFirst)
    }
    
    @IBAction func BtnSecondPress(_ sender: Any) {
        btnPressAction(whichCheck: checkSecond)
        answerCheck(check: checkSecond, btn: AnimalBtnSecond)
    }
    
    
    @IBAction func BtnThirdPress(_ sender: Any) {
        btnPressAction(whichCheck: checkThird)
        answerCheck(check: checkThird, btn: AnimalBtnThird)
    }
    
    
    @IBAction func BtnFourPress(_ sender: Any) {
        btnPressAction(whichCheck: checkFour)
        answerCheck(check: checkFour, btn: AnimalBtnFour)
    }
    
    
    // MARK: - Public Methods
    private func reduceLives() {
        switch life {
        case 4:
            heartOne.isHidden = false
            heartTwo.isHidden = false
            heartThree.isHidden = false
            heartFour.isHidden = false
        case 3:
            heartOne.isHidden = false
            heartTwo.isHidden = false
            heartThree.isHidden = false
            heartFour.isHidden = true
        case 2:
            heartOne.isHidden = false
            heartTwo.isHidden = false
            heartThree.isHidden = true
        case 1:
            heartOne.isHidden = false
            heartTwo.isHidden = true
        case ...0:
            heartOne.isHidden = true
            hideElementsOfInterface()
            youLoseShow()
        default:
            life = 4
        }
    }
    
    func addLifes() {
        if answersWithoutMistakes == 3 {
            life += 1
            answersWithoutMistakes = 0
        }
    }
    
    func choosePack() {
        switch checkPack {
        case "animalsPack":
            animalsImage = [
                "Pig" : #imageLiteral(resourceName: "icons8-pig"), "Horse" : #imageLiteral(resourceName: "icons8-trotting_horse"), "Elephant" : #imageLiteral(resourceName: "icons8-elephant"),
                "Sheep" : #imageLiteral(resourceName: "icons8-sheep"), "Rat" : #imageLiteral(resourceName: "icons8-rat_silhouette"), "Bird" : #imageLiteral(resourceName: "icons8-dove"),
                
                "Cat" : #imageLiteral(resourceName: "icons8-pet_commands_stay"), "Cow" : #imageLiteral(resourceName: "icons8-cow"), "Monkey" : #imageLiteral(resourceName: "icons8-harambe_the_gorilla"),
                "Goat" : #imageLiteral(resourceName: "icons8-year_of_goat"), "Hippopotamus" : #imageLiteral(resourceName: "icons8-hippopotamus")
            ]
        case "flagsPack":
            animalsImage = [
                "Afganistan" : #imageLiteral(resourceName: "icons8-afghanistan"), "Bahrain" : #imageLiteral(resourceName: "icons8-bahrain"), "Brunei" : #imageLiteral(resourceName: "icons8-brunei"),
                "Alands Islands" : #imageLiteral(resourceName: "icons8-aland_islands"), "Albania" : #imageLiteral(resourceName: "icons8-albania"), "Angola" : #imageLiteral(resourceName: "icons8-angola"),
                "Antarctica" : #imageLiteral(resourceName: "icons8-antarctica"), "Aruba" : #imageLiteral(resourceName: "icons8-aruba"), "Azerbaijan" : #imageLiteral(resourceName: "icons8-azerbaijan"),
                "Barbados" : #imageLiteral(resourceName: "icons8-barbados"), "Belarus" : #imageLiteral(resourceName: "icons8-belarus"), "Belgium" : #imageLiteral(resourceName: "icons8-belgium"),
                "Bosnia Herzegovina" : #imageLiteral(resourceName: "icons8-bosnia_herzegovina"), "Bulgaria" : #imageLiteral(resourceName: "icons8-bulgaria"), "Burkina Faso" : #imageLiteral(resourceName: "icons8-burkina_faso"),
                "Cape Verde" : #imageLiteral(resourceName: "icons8-cape_verde"), "Caribbean Netherlands" : #imageLiteral(resourceName: "icons8-caribbean_netherlands"), "Central African Republic" : #imageLiteral(resourceName: "icons8-central_african_republic"),
                "Christmas Island" : #imageLiteral(resourceName: "icons8-christmas_island"), "France" : #imageLiteral(resourceName: "icons8-clipperton_island"), "Cocos Keeling Islands" : #imageLiteral(resourceName: "icons8-cocos_keeling_islands"),
                "Costa Rica" : #imageLiteral(resourceName: "icons8-costa_rica"), "Cuba" : #imageLiteral(resourceName: "icons8-cuba"), "Cyprus" : #imageLiteral(resourceName: "icons8-cyprus"),
                "Dominica" : #imageLiteral(resourceName: "icons8-dominica"), "Dominican Republic" : #imageLiteral(resourceName: "icons8-dominican_republic"), "Ecuador" : #imageLiteral(resourceName: "icons8-ecuador"),
                "Ethiopia" : #imageLiteral(resourceName: "icons8-ethiopia"), "European Union" : #imageLiteral(resourceName: "icons8-european_union"), "Germany" : #imageLiteral(resourceName: "icons8-germany"),
                "Mexico" : #imageLiteral(resourceName: "icons8-mexico"), "Switzerland" : #imageLiteral(resourceName: "icons8-switzerland"), "United Arab Emirates" : #imageLiteral(resourceName: "icons8-united_arab_emirates"),
                "United States of America" : #imageLiteral(resourceName: "icons8-united_states"), "Algeria" : #imageLiteral(resourceName: "icons8-algeria"), "American Samoa" : #imageLiteral(resourceName: "icons8-american_samoa"),
                "Andorra" : #imageLiteral(resourceName: "icons8-andorra"), "Argentina" : #imageLiteral(resourceName: "icons8-argentina"), "Armenia" : #imageLiteral(resourceName: "icons8-armenia"),
                "Bahamas" : #imageLiteral(resourceName: "icons8-bahamas"), "Bangladesh" : #imageLiteral(resourceName: "icons8-bangladesh"), "Belize" : #imageLiteral(resourceName: "icons8-belize"),
                "Benin" : #imageLiteral(resourceName: "icons8-benin"), "Bermuda" : #imageLiteral(resourceName: "icons8-bermuda"), "Botswana" : #imageLiteral(resourceName: "icons8-botswana"),
                "Bouvet Island" : #imageLiteral(resourceName: "icons8-bouvet_island"), "Brazil" : #imageLiteral(resourceName: "icons8-brazil"), "Burundi" : #imageLiteral(resourceName: "icons8-burundi"),
                "Cameroon" : #imageLiteral(resourceName: "icons8-cameroon"), "Canada" : #imageLiteral(resourceName: "icons8-canada"), "Bolivia" : #imageLiteral(resourceName: "icons8-bolivia"),
                "Chile" : #imageLiteral(resourceName: "icons8-chile"), "China" : #imageLiteral(resourceName: "icons8-china"), "Colombia" : #imageLiteral(resourceName: "icons8-colombia"),
                "Czechia" : #imageLiteral(resourceName: "icons8-czechia"), "Djibouti" : #imageLiteral(resourceName: "icons8-djibouti"), "Egypt" : #imageLiteral(resourceName: "icons8-egypt"),
                "Eritrea" : #imageLiteral(resourceName: "icons8-eritrea"), "Estonia" : #imageLiteral(resourceName: "icons8-estonia"), "Faroe Islands" : #imageLiteral(resourceName: "icons8-faroe_islands"),
                "Fiji" : #imageLiteral(resourceName: "icons8-fiji"), "Finland" : #imageLiteral(resourceName: "icons8-finland"), "Micronesia" : #imageLiteral(resourceName: "icons8-micronesia"),
                "St. Barthelemy" : #imageLiteral(resourceName: "icons8-st_barthelemy"), "Spain" : #imageLiteral(resourceName: "icons8-ceuta_melilla"),
            ]
        default:
            break
        }
    }
    
    func next() {
        hideBtnForAnimation()
        AnimalText.alpha = 0
        setAnimalText()
        setArrayWithoutChooseAnimal()
        randBtn()
        setImage()
        btnEnableIsTrue()
        animatingBtn()
        animateLabel(chooseWhatsAnimate: AnimalText)
    }
    
    func setAnimalText() {
        randAnimal = animalsName.randomElement()!
        AnimalText.text = randAnimal
    }
    
    func btnPressAction(whichCheck: String) {
        scoreCheck(check: whichCheck)
        checkWinsScores()
        addLifes()
        reduceLives()
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
    
    
    
    
    func animateLabel(chooseWhatsAnimate: UILabel) {
        UIView.animate(withDuration: 0.5, animations:{
            chooseWhatsAnimate.alpha = 1
        } )
    }
    
    func animateBtn(chooseWhatsAnimate: UIButton) {
        UIView.animate(withDuration: 0.7, animations:{
            chooseWhatsAnimate.alpha = 1
        } )
    }
    
    
    func btnEnableIsTrue() {
        AnimalBtnFirst.isEnabled = true
        AnimalBtnSecond.isEnabled = true
        AnimalBtnThird.isEnabled = true
        AnimalBtnFour.isEnabled = true
    }
    
    func scoreCheck(check: String) {
        if check == "Correctly" {
            score += 1
            answersWithoutMistakes += 1
        } else {
            life -= 1
            answersWithoutMistakes = 0
        }
        ScoreCount.text = String(score)
    }
    
    func answerCheck(check: String, btn: UIButton) {
        if check == "Correctly" {
            next()
        } else {
            btn.isEnabled = false
        }
    }
    
    
    func checkWinsScores() {
        if score > 19 {
            youWinShow()
        }
    }
    
    func hideElementsOfInterface() {
        ScoreStack.isHidden = true
        AnimalText.isHidden = true
        AnimalBtnFirst.isHidden = true
        AnimalBtnSecond.isHidden = true
        AnimalBtnThird.isHidden = true
        AnimalBtnFour.isHidden = true
    }
    
    func youWinShow() {
        YouWin.isHidden = false
        hideElementsOfInterface()
        YouWin.text = "You Win!"
    }
    
    func youLoseShow() {
        YouWin.isHidden = false
        hideElementsOfInterface()
        YouWin.text = "Game Over"
    }
    
    func hideBtnForAnimation() {
        AnimalBtnFirst.alpha = 0
        AnimalBtnSecond.alpha = 0
        AnimalBtnThird.alpha = 0
        AnimalBtnFour.alpha = 0
    }
    
    func animatingBtn() {
        animateBtn(chooseWhatsAnimate: AnimalBtnFirst)
        animateBtn(chooseWhatsAnimate: AnimalBtnSecond)
        animateBtn(chooseWhatsAnimate: AnimalBtnThird)
        animateBtn(chooseWhatsAnimate: AnimalBtnFour)
    }
    
    
}


