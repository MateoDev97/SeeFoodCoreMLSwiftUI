//
//  ContentViewModel.swift
//  SeeFoodCoreMLSwiftUI
//
//  Created by Brian Ortiz on 2023-05-26.
//

import Foundation
import SwiftUI
import CoreML
import Vision


class ContentViewModel: ObservableObject {
    
    @Published var titleNavigationBar: String = ""
    @Published var navigationBarColor: Color = Color("LightGray")

    @Published var isImagePickerPresented: Bool = false
    
    @Published var imageSelected: UIImage?

    func imageChanged(image: UIImage) {
        if let ciImage = CIImage(image: image) {
            detect(ciImage: ciImage)
        }
    }
    
    func detect(ciImage: CIImage) {
        
        do {
            let model = try VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model)
            
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation] else {
                    return
                }
                dump(results.first)
                
                if let firstResult = results.first {
                    if firstResult.identifier.contains("hotdog") {
                        self?.titleNavigationBar = "Hot Dog!"
                        self?.navigationBarColor = Color.green
                    } else {
                        self?.titleNavigationBar = "Not Hot Dog!"
                        self?.navigationBarColor = Color.red
                    }
                }
                
            }
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            
            try handler.perform([request])
            
        } catch {
            print("Error \(error)")
        }
        
    }
}
