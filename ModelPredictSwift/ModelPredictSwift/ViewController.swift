//
//  ViewController.swift
//  ModelPredictSwift
//
//  Created by yair hadad on 24/04/2019.
//  Copyright © 2019 yair hadad. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var touchDrawView: TouchDrawView!
    @IBOutlet weak var predictLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        touchDrawView.setWidth(10)
    }
    
    var model : VNCoreMLModel? = {
        return try? VNCoreMLModel(for: coreml_model().model)
    }()
    
    lazy var classificationRequest: VNCoreMLRequest? = {
        guard let model = self.model else { return nil}
        let request = VNCoreMLRequest(model: model, completionHandler: handleClassification)
        request.imageCropAndScaleOption = .scaleFit
        return request
    }()
    
    
    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation] else { return }
        guard let best = observations.first else { return}
        
        DispatchQueue.main.async {
            self.predictLabel.text = best.identifier
        }
    }
    
    @IBAction func onPredictPressed(_ sender: Any) {
        print("onPredictPressed")
        guard let image = ModelUtils.captureView(touchDrawView)?.cgImage else {return}

        let handler = VNImageRequestHandler(cgImage: image)
        do {
            guard let request = classificationRequest else {return}
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func onClearButtonPressed(_ sender: Any) {
        print("onClearButtonPressed")
        touchDrawView.clearDrawing()
    }
}

