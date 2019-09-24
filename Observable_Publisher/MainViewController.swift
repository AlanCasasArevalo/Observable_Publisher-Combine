//
//  MainViewController.swift
//  Observable_Publisher
//
//  Created by Alan Casas on 24/09/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func touchButtonPressed(_ sender: Any) {
        rxAsyncTask()
            .observeOn(MainScheduler.instance)
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
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
    
    func rxAsyncTask() -> Observable<String?> {
        return Observable.create { emitter in
            self.doAsyncTask { text in
                
                guard let textFromAsyncTask = text else {
                    emitter.onNext(text)
                    emitter.onCompleted()
                    return
                }
                
                emitter.onNext(textFromAsyncTask)
                
            }
            
            return Disposables.create()
        }
    }
        
}
