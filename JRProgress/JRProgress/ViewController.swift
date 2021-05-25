//
//  ViewController.swift
//  JRProgress
//
//  Created by jackfrow on 2021/5/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progress = JRProgressView()
        progress.frame = CGRect(x: 100, y: 300, width: 200, height: 8)
        progress.layer.cornerRadius = 4
        progress.clipsToBounds = true
        progress.completeBlock = {
            print("completeBlock ")
        }
        progress.progressColors = [UIColor.yellow,UIColor.green,UIColor.green,UIColor.red,UIColor.blue]
        progress.backgroundColor = UIColor.gray
        view.addSubview(progress)
        progress.setProgress(1, animated: true)
       
    }


}

