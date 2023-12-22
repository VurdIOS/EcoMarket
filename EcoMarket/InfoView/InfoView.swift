//
//  InfoView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class InfoView: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        // asd
        let pr = CoreDataManager.shared.fetchProducts()
        
        pr.forEach {print($0.title)}

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
