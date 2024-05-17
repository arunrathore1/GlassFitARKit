
//  MainScreen.swift
//  Glass-Fit
//


import SwiftUI
import RealityKit

struct MainScreen : View {
    @StateObject var viewModel: MainViewModel
    @State private var capturedImage: IdentifiableUIImage?
    
    var body: some View {
        ZStack {
                ARViewContainer(controller: viewModel.arController).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        ForEach(viewModel.glassesTypes, id: \.rawValue) { item in
                            Button(action: {
                                viewModel.didSelectGlasses(item: item)
                            }, label: {
                                VStack {
                                    Image(item.rawValue)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        
                                        .frame(height: 25)
                                    
                                    Text(item.description)
                                    
                                }
                            })
                            .font(.title2)
                            .frame(minWidth: 120)
                            .padding()
                            .foregroundColor(viewModel.selectedGlassesType == item ? .black : .white)
                            .background(viewModel.selectedGlassesType?.rawValue == item.rawValue ? .yellow : .accentColor)
                            .cornerRadius(20)
                        }
                    }
                }
            }

            VStack {
                Button(action: {
                    captureScreenShot()
                }) {
                    Text("Capture Screenshot")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }.padding(.top, -500)

        } .sheet(item: $capturedImage) { imageWrapper in
            if let image = imageWrapper {
                Image(uiImage: image.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }

    private func captureScreenShot() {
        ARVariables.arView.snapshot(saveToHDR: false) { (image) in
            if let image = image {
                // Compress the image
                let compressedImage = UIImage(data: image.pngData() ?? Data())
                self.capturedImage = IdentifiableUIImage(image: compressedImage ?? UIImage())
                // Save in the photo album
                UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            }

        }
    }
}

#if DEBUG
struct MainScreen_Previews : PreviewProvider {
    static var previews: some View {
        PreviewStubs.mainScreen()
    }
}
#endif

// A custom Identifiable wrapper for UIImage
struct IdentifiableUIImage: Identifiable {
    let id = UUID()
    let image: UIImage
}

struct ARVariables {
  static var arView: ARView!
}
