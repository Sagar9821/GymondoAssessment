//
//  ExerciseDetailsView.swift
//  GymondoAssessment
//
//  Created by psagc on 21/01/24.
//

import SwiftUI
import Gymondo

struct ExerciseDetailsView: View {
    
    @ObservedObject var viewModel: ExerciseDetailsViewModel

    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            ScrollView {
                ScrollView(.horizontal) {
                    VStack {
                        HStack {
                            ForEach(viewModel.variations, id: \.self) { variations in
                                ExerciseAsyncImagesView(exercise: variations)
                            }
                        }.background(Color.white)
                    }
                }
                ExerciseVariationsView(variations: viewModel.variations)
            }.task {
                viewModel.getExerciseVariations()
            }.navigationTitle(viewModel.exercises.name.unsafelyUnwrapped)
        }
    }
}

#Preview {
    ExerciseDetailsView(viewModel: ExerciseDetailsViewModel(exercises: Exercise(id: 1, uuid: "", name: "", exerciseBase: 3, description: "", images: nil, created: "", variations: []), exerciseService: ExerciseService()))
}
