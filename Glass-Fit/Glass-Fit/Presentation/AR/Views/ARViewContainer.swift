
//  ARViewContainer.swift
//  Glass-Fit


import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    var controller: ARController
    
    
    func makeUIView(context: Context) -> ARView {
        ARVariables.arView = ARView(frame: .zero)
        context.coordinator.view =  ARVariables.arView
        return ARVariables.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeCoordinator() -> ARViewCoordinator {
        ARViewCoordinator(controller: controller)
    }
}
