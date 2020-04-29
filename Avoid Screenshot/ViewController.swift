//
//  ViewController.swift
//  Avoid Screenshot
//
//  Created by omrobbie on 30/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        avoidScreenRecording()
    }

    func avoidScreenRecording() {
        let blankView: UIView = {
            let v = UIView()
            v.frame = UIScreen.main.bounds
            v.backgroundColor = .label
            v.isHidden = true
            return v
        }()

        view.addSubview(blankView)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            UIScreen.screens.forEach {
                blankView.isHidden = !$0.isCaptured
            }
        })
    }
}
