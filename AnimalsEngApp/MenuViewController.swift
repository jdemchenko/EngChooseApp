//
//  MenuViewController.swift
//  AnimalsEngApp
//
//  Created by macbook on 26.03.21.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var animalPackBtn: UIButton!
    @IBOutlet weak var flagsPackBtn: UIButton!
    @IBOutlet weak var clothesPackBtn: UIButton!
    
    var check = "animalPack"
    var identifire = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCornerRadius()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == identifire else { return }
        guard let destination = segue.destination as? ViewController else { return }
        destination.checkPack = check
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
    
    
    func buttonCornerRadius() {
        let cornerRadius: CGFloat = 20
        animalPackBtn.layer.cornerRadius = cornerRadius
        flagsPackBtn.layer.cornerRadius = cornerRadius
        clothesPackBtn.layer.cornerRadius = cornerRadius
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
