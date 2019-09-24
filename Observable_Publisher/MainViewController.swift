//
//  MainViewController.swift
//  Observable_Publisher
//
//  Created by Alan Casas on 24/09/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func touchButtonPressed(_ sender: Any) {
        doAsyncTask { text in
            DispatchQueue.main.async {
                self.label.text = text
            }
        }
    }

    func doAsyncTask (_ task: @escaping (String?) -> Void) {
    
        task("3")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            task("2")
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                task("1")
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    task("Hi!")
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                        task(nil) //end

                    }
                }
            }
        }
        
    }
        
}
