//
//  FilterList.swift
//  TikTok
//
//  Created by vishal singh on 04/01/19.
//  Copyright © 2019 Deep. All rights reserved.
//

import UIKit
import CoreMedia

class FilterList: UIViewController {

    let ColorControl = CIFilter(name: "CIColorControls", withInputParameters: ["inputSaturation" : 1.5])
  //  let ColorControl = CIFilter(name: "CIColorCrossPolynomial")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
