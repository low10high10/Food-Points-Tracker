//
//  DailyDevilDealsViewController.swift
//  DukeDining
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 Duke University. All rights reserved.
//

import UIKit

class DailyDevilDealsViewController: UIViewController {

    @IBAction func BrowserButton(_ sender: Any) {
        if let link = URL(string: "https://studentaffairs.duke.edu/sites/default/files/2017-10/DevilDeals2sm.pdf") {
          UIApplication.shared.open(link)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
