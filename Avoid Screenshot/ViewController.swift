//
//  ViewController.swift
//  Avoid Screenshot
//
//  Created by omrobbie on 30/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        avoidScreenshot()
        avoidScreenRecording()
    }

    func avoidScreenshot() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: nil) { (_) in
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                let options = PHFetchOptions()
                options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                options.fetchLimit = 1

                let result = PHAsset.fetchAssets(with: .image, options: options)

                if result.count > 0 {
                    PHPhotoLibrary.shared().performChanges({
                        if let asset = result.firstObject {
                            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
                        }
                    }, completionHandler: nil)
                }
            }
        }
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
