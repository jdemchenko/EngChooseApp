//
//  MenuViewController.swift
//  AnimalsEngApp
//
//  Created by macbook on 26.03.21.
//
import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var animalPackBtn: UIButton!
    @IBOutlet weak var flagsPackBtn: UIButton!
    @IBOutlet weak var clothesPackBtn: UIButton!
    @IBOutlet weak var colorSwitch: UISwitch!
    

    let systemSoundSlider: SystemSoundID = 1150
 
    
    var check = "animalPack"
    var identifire = ""
    
    var backgroundColor = #colorLiteral(red: 0.9103912711, green: 0.7921295762, blue: 0.5059833527, alpha: 1)
    var btnColor = #colorLiteral(red: 0.9962832332, green: 0.4213231802, blue: 0.6217779517, alpha: 1)
    var checkSwitch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSwitchOn()
        switchColor()
        buttonCornerRadius()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == identifire else { return }
        guard let destination = segue.destination as? ViewController else { return }
        destination.checkPack = check
        destination.backgroundColor = backgroundColor
        destination.btnColor = btnColor
        destination.checkSwitch = checkSwitch
    }
    
    @IBAction func animalPackBtnPressed() {
        check = "animalsPack"
        identifire = "animalPackIdentifire"
    }
    @IBAction func flagsPackBtnPressed() {
        check = "flagsPack"
        identifire = "flagsPackIdentifire"
    }
    @IBAction func clothesPackBtnPressed() {
        check = "clothingPack"
        identifire = "clothesPackidentifire"
    }
    @IBAction func colorSwitchSwitch() {
        AudioServicesPlaySystemSound(systemSoundSlider)
        switchColor()
    }
        

    
    
    func buttonCornerRadius() {
        let cornerRadius: CGFloat = 20
        animalPackBtn.layer.cornerRadius = cornerRadius
        flagsPackBtn.layer.cornerRadius = cornerRadius
        clothesPackBtn.layer.cornerRadius = cornerRadius
    }
    
    func checkSwitchOn() {
        if checkSwitch {
            colorSwitch.isOn = true
        }
    }
    
    func switchColor() {
        if colorSwitch.isOn {
            backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            btnColor = #colorLiteral(red: 0.9962832332, green: 0.4213231802, blue: 0.6217779517, alpha: 1)
            checkSwitch = true
        }
        else {
            backgroundColor = #colorLiteral(red: 0.1411584616, green: 0.141189754, blue: 0.1582941115, alpha: 1)
            btnColor = #colorLiteral(red: 0.3332971931, green: 0.3333585858, blue: 0.3332890868, alpha: 1)
            checkSwitch = false
        }
        view.backgroundColor = backgroundColor
        animalPackBtn.backgroundColor = btnColor
        clothesPackBtn.backgroundColor = btnColor
        flagsPackBtn.backgroundColor = btnColor
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
