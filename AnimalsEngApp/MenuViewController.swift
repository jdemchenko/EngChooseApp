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
    
    var check = "animalPack"
    override func viewDidLoad() {
        super.viewDidLoad()
        animalPackBtn.layer.cornerRadius = 20
        flagsPackBtn.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "animalPackIdentifire" ||
                segue.identifier == "flagsPackIdentifire"  else { return }
        guard let destination = segue.destination as? ViewController else { return }
        destination.checkPack = check
    }
    
    @IBAction func animalPackBtnPressed() {
        check = "animalsPack"
    }
    @IBAction func flagsPackBtnPressed() {
        check = "flagsPack"
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
