//
//  LoadingAnimation.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 16/07/25.
//

import Foundation
import SwiftUI

struct LoadingAnimation: UIViewRepresentable {
    let animatedFrames: UIImage
    let image: UIImageView
    let squareDimension: CGFloat = 125
    
    init() {
        var images: [UIImage] = []
        
        for i in 1...127 {
            guard let image =
                    UIImage(named: "dog_\(String(format: "%03d", i))")
            else { continue }
            images.append(image)
        }
        
        animatedFrames = UIImage.animatedImage(with: images,duration: 4) ?? UIImage()
        
        image = UIImageView(frame: CGRect(x: 0, y: 0, width:squareDimension, height: squareDimension))
    }
    // 6
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: squareDimension, height: squareDimension))
        image.clipsToBounds = true
        image.autoresizesSubviews = true
        image.contentMode = .scaleAspectFit
        image.image = animatedFrames
        image.center = CGPoint(x: view.frame.width / 2,
                               y: view.frame.height / 2)
        view.backgroundColor = .red
        view.addSubview(image)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // no code here; just for protocol
    }
}

/// SwiftUI View
struct LoadingAnimationView: View {
    var body: some View {
        VStack {
            LoadingAnimation()
        }
    }
}

// Preview
struct LoadingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationView()
    }
}
