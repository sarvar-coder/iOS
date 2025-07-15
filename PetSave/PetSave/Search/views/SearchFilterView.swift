//
//  SearchFilterView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import SwiftUI

struct SearchFilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        Form {
            Section {
                
                Picker("Age", selection: $viewModel.ageSelection) {
                    ForEach(AnimalSearchAge.allCases, id: \.self) { age in
                        Text(age.rawValue.capitalized)
                    }
                }
                
                .onChange(of: viewModel.ageSelection) {
                    viewModel.search()
                    
                }
                
                Picker("Type", selection: $viewModel.typeSelection) {
                    ForEach(AnimalSearchType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                
                .onChange(of: viewModel.typeSelection) {
                    viewModel.search()
                
                }
            } footer: {
               
                Text("You can mix both, age and type, to make a more accurate search.")
            }
            
            Button("Clear", role: .destructive, action:
                    viewModel.clearFilters)
            Button("Done") {
                dismiss()
            }
        }
        .navigationBarTitle("Filters")
        .toolbar {
            
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    NavigationView {
        SearchFilterView(
            viewModel: SearchViewModel(
                animalSearcher: AnimalSearcherMock(),
                animalStore: AnimalStoreService(context: context)
            )
        )
    }
}
