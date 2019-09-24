//
//  MainViewController.swift
//  Observable_Publisher
//
//  Created by Alan Casas on 24/09/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var cancellable: Cancellable?
    
    @Published var publishedValue: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func touchButtonPressed(_ sender: Any) {
        cancellable = asyncTaskPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: label)
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
    
    func asyncTaskPublisher() -> AnyPublisher<String?, Never> {
        doAsyncTask { text in
            self.publishedValue = text
        }        
        return $publishedValue.eraseToAnyPublisher()
    }
        
}
