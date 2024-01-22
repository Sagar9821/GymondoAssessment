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
    var navigator: NavigatorType
    init(viewModel: ExerciseDetailsViewModel, navigator: NavigatorType) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    var body: some View {
        
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            ScrollView {
                ExerciseAsyncImagesView(exerciseImages: viewModel.exercises.images)
//                ExerciseVariationsView(variations: viewModel.variations)
            }.task {
                viewModel.getExerciseVariations()
            }.navigationTitle(viewModel.exercises.exercises.unsafelyUnwrapped.first.unsafelyUnwrapped.name ?? "")
        }
    }
}

#Preview {
    ExerciseDetailsView(viewModel: ExerciseDetailsViewModel(exercises: ExercisesDetails(id: 1, uuid: "", images: [], exercises: [Exercise(id: 1, uuid: "", name: "", exerciseBase: 3, description: "", language: .english, images: nil, created: "", variations: [])], variations: 1), exerciseService: ExerciseService()), navigator: Navigator(navigationController: UINavigationController()))
}
