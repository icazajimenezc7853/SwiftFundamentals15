//
//  ViewController.swift
//  IntBulBas
//
//  Created by remotestudent on 11/5/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var changeTitle: UIButton!
     
    @IBAction func pressButton(_ sender: Any) {
        mainLabel.text = "This app rocks!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeTitle.tintColor = .red
    }


}

