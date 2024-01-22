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
        ScrollView {
            Text(viewModel.exercises.name ?? "")
            
            ForEach(viewModel.variations, id: \.self) { variations in
                Text(variations.name ?? "")
            }
        }.task {
            viewModel.getExerciseVariations()
        }
    }
}

#Preview {
    ExerciseDetailsView(viewModel: ExerciseDetailsViewModel(exercises: Exercise(id: 1, uuid: "", name: "", exerciseBase: 3, description: "", images: nil, created: "", variations: []), exerciseService: ExerciseService()))
}
