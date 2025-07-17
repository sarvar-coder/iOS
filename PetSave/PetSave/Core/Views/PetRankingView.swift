//
//  PetRankingView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 17/07/25.
//

import SwiftUI

import SwiftUI
struct PetRankingView: View {
    // 1
    @ObservedObject var viewModel: PetRankingViewModel
    var animal: AnimalEntity
    // 2
    init(animal: AnimalEntity) {
        self.animal = animal
        viewModel = PetRankingViewModel(animal: animal)
    }
    // 3
    var body: some View {
        HStack {
            Text("Rank me!")
                .multilineTextAlignment(.center)
            ForEach(0...4, id: \.self) { index in
                PetRankImage(index: index, recentIndex: $viewModel.ranking)
            }
        }
    }
}


struct PetRankImage: View {
    let index: Int
    // 1
    @State var opacity: Double = 0.4
    @State var tapped = false
    @Binding var recentIndex: Int
    var body: some View {
        // 2
        Image("creature_dog-and-bone")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(opacity)
            .frame(width: 50, height: 50)
            .onTapGesture {
                opacity = tapped ? 0.4 : 1.0
                tapped.toggle()
                recentIndex = index
            }
            .onChange(of: recentIndex) { value in
                checkOpacity(value: value)
            }
            .onAppear {
                checkOpacity(value: recentIndex)
            }
    }
    // 3
    func checkOpacity(value: Int) {
        opacity = value >= index ? 1.0 : 0.4
        tapped.toggle()
    }
}

final class PetRankingViewModel: ObservableObject {
    var animal: AnimalEntity
    // 1
    @Published var ranking: Int {
        didSet {
            animal.ranking = Int32(ranking)
        }
    }
    // 2
    init(animal: AnimalEntity) {
        self.animal = animal
        self.ranking = Int(animal.ranking)
    }
}


struct PetRankingView_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            Group {
                PetRankingView(animal: animal)
                    .padding()
                    .previewLayout(.sizeThatFits)
                    .environment(\.sizeCategory, .extraSmall)
                    .previewDisplayName("Extra-Small")
                PetRankingView(animal: animal)
                    .padding()
                    .previewLayout(.sizeThatFits)
                    .previewDisplayName("Regular")
                PetRankingView(animal: animal)
                    .padding()
                    .previewLayout(.sizeThatFits)
                    .environment(\.sizeCategory, .extraLarge)
                    .previewDisplayName("Extra-Large")
            }
        }
    }
}
