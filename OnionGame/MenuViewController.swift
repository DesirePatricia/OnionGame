//
//  MenuViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019/10/11.
//  Copyright © 2019 DesGui. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func touchPeel(_ sender: UIButton) {
         performSegue(withIdentifier: "menuShowPeel", sender: nil)
    }
    
    @IBAction func touchChop(_ sender: UIButton) {
         performSegue(withIdentifier: "menuShowChop", sender: nil)
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
