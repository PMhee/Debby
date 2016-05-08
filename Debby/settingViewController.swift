//
//  settingViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {

    @IBOutlet weak var upgrade: UIButton!
    @IBOutlet weak var trial: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        upgrade.layer.cornerRadius = 15
        upgrade.layer.borderWidth = 1
        upgrade.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1.0).CGColor
        trial.layer.cornerRadius = 15
        trial.layer.borderWidth = 1
        trial.layer.borderColor = UIColor(red: 159/255, green: 208/255, blue: 187/255, alpha: 1.0  ).CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
