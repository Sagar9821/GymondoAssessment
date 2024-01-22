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
                ExerciseAsyncImagesView(exerciseImages: viewModel.exercises.images)
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
