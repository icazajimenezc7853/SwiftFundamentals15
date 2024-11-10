//
//  ViewController.swift
//  ligth
//
//  Created by remotestudent on 11/10/24.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var lightButton: UIButton!
      
    var lightOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    fileprivate func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
        if lightOn {
//            view.backgroundColor = .white
            lightButton.setTitle("Carlos", for: .normal)
        } else {
//            view.backgroundColor = .black
            lightButton.setTitle("Icaza", for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn.toggle()
        updateUI()
    }
    
    
    
}

