//
//  ViewController.swift
//  AnimalsEngApp
//
//  Created by Ivan Demchenko on 3/23/21.
//
import UIKit
import AVFoundation

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
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    
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
    var backgroundColor = #colorLiteral(red: 0.1411584616, green: 0.141189754, blue: 0.1582941115, alpha: 1)
    var btnColor = #colorLiteral(red: 0.3332971931, green: 0.3333585858, blue: 0.3332890868, alpha: 1)
    var checkSwitch = false
    
    var utterance = AVSpeechUtterance(string: "Error")
    let synthesizer = AVSpeechSynthesizer()
    
    let systemSoundNotCorrectlyAnswer: SystemSoundID = 1053
    let systemSoundGameOver: SystemSoundID  = 1334
    let systemSoundWin: SystemSoundID  = 1325
    
    // MARK: Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        switchColor()
        choosePack()
        animalsName = Array(animalsImage.keys)
        YouWin.isHidden = true
        ScoreCount.text = "0"
        setAnimalText()
        setArrayWithoutChooseAnimal()
        randBtn()
        setImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "menuViewIdentifire" else { return }
        guard let destination = segue.destination as? MenuViewController else { return }
        destination.checkSwitch = checkSwitch
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
            AudioServicesPlaySystemSound(systemSoundGameOver)
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
        case "clothingPack":
            animalsImage = [
                "Bag" : #imageLiteral(resourceName: "icons8-bag-100.png"), "Beret" : #imageLiteral(resourceName: "icons8-beret-100.png"), "Boots" : #imageLiteral(resourceName: "icons8-boots-100.png"),
                "Hat" : #imageLiteral(resourceName: "icons8-bowler-hat-100.png"), "Bra" : #imageLiteral(resourceName: "icons8-bra-100.png"), "Cap" : #imageLiteral(resourceName: "icons8-cap-100.png"),
                "Coat" : #imageLiteral(resourceName: "icons8-coat-100.png"), "Ring" : #imageLiteral(resourceName: "icons8-diamond-ring-100.png"), "Earrings" : #imageLiteral(resourceName: "icons8-earrings-100.png"),
                "Bow tie" : #imageLiteral(resourceName: "icons8-filled-bow-tie-100.png"), "Flip flops" : #imageLiteral(resourceName: "icons8-flip-flops-100.png"), "Glasses" : #imageLiteral(resourceName: "icons8-glasses-100.png"),
                "Dress" : #imageLiteral(resourceName: "icons8-green-dress-100.png"), "Jacket" : #imageLiteral(resourceName: "icons8-jacket-100.png"), "Jeans" : #imageLiteral(resourceName: "icons8-jeans-100.png"),
                "Belt" : #imageLiteral(resourceName: "icons8-mens-belt-100.png"), "Mitten" : #imageLiteral(resourceName: "icons8-mitten-100.png"), "Helmet" : #imageLiteral(resourceName: "icons8-motorbike-helmet-100.png"),
                "Necklace" : #imageLiteral(resourceName: "icons8-necklace-100.png"), "Panama hat" : #imageLiteral(resourceName: "icons8-panama-hat-100.png"), "Puffer Jacket" : #imageLiteral(resourceName: "icons8-puffer-jacket-100.png"),
                "Sandals" : #imageLiteral(resourceName: "icons8-sandals-100.png"), "Scarf" : #imageLiteral(resourceName: "icons8-scarf-100.png"), "Backpack" : #imageLiteral(resourceName: "icons8-school-backpack-100.png"),
                "Shirt" : #imageLiteral(resourceName: "icons8-shirt-100.png"), "Shorts" : #imageLiteral(resourceName: "icons8-shorts-100.png"), "Skirt" : #imageLiteral(resourceName: "icons8-skirt-100.png"),
                "Socks" : #imageLiteral(resourceName: "icons8-socks-100.png"), "Sunglasses" : #imageLiteral(resourceName: "icons8-sun-glasses-100.png"), "Sweater" : #imageLiteral(resourceName: "icons8-sweater-100.png"),
                "T-shirt" : #imageLiteral(resourceName: "icons8-t-shirt-100.png"), "Tie" : #imageLiteral(resourceName: "icons8-tie-100.png"), "Trainers" : #imageLiteral(resourceName: "icons8-trainers-100.png"),
                "Umbrella" : #imageLiteral(resourceName: "icons8-umbrella-100.png"), "Watch" : #imageLiteral(resourceName: "icons8-watches-front-view-100.png"), "High heels" : #imageLiteral(resourceName: "icons8-women`s-shoe-100.png"),
                "Blouse" : #imageLiteral(resourceName: "icons8-womens-blouse-100.png"), "Pink Pants" : #imageLiteral(resourceName: "icons8-womens-pants-100.png")
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
            textToSpeech(text: AnimalText.text ?? "Error")
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
            AudioServicesPlaySystemSound(systemSoundNotCorrectlyAnswer)
            btn.isEnabled = false
        }
    }
    
    
    func checkWinsScores() {
        if score > 19 {
            youWinShow()
            AudioServicesPlaySystemSound(systemSoundWin)
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
    
    func switchColor() {
        view.backgroundColor = backgroundColor
        if checkSwitch {
            heartOne.tintColor = .red
            heartTwo.tintColor = .red
            heartThree.tintColor = .red
            heartFour.tintColor = .red
        } else {
            heartOne.tintColor = .white
            heartTwo.tintColor = .white
            heartThree.tintColor = .white
            heartFour.tintColor = .white
        }
    }
    
    func textToSpeech(text: String) {
        utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB") //also you can use en-en, en, eb-GB
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
}


