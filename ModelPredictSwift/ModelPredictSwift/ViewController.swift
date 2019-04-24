//
//  ViewController.swift
//  ModelPredictSwift
//
//  Created by yair hadad on 24/04/2019.
//  Copyright © 2019 yair hadad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var touchDrawView: TouchDrawView!
    @IBOutlet weak var predictLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        touchDrawView.setWidth(3)
    }
    
    @IBAction func onPredictPressed(_ sender: Any) {
        
    }
    
    @IBAction func onClearButtonPressed(_ sender: Any) {
        touchDrawView.clearDrawing()
    }
}

