//
//  ExerciseDetailsView.swift
//  GymondoAssessment
//
//  Created by psagc on 21/01/24.
//

import SwiftUI
import Gymondo

public struct ExerciseDetailsView: View {
    
    @ObservedObject var viewModel: ExerciseDetailsViewModel
    var navigator: NavigatorType
    public init(viewModel: ExerciseDetailsViewModel, navigator: NavigatorType) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    public var body: some View {
        
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            ScrollView {
                ExerciseAsyncImagesView(exerciseImages: viewModel.exercises.images)
                ExerciseVariationsView(viewModel: viewModel, navigator: navigator)
            }.task {
                viewModel.getExerciseVariations()
            }.navigationTitle(viewModel.exercises.exercises?.first(where: {$0.language == .english}).unsafelyUnwrapped.name.unsafelyUnwrapped ?? "")
        }
    }
}

#Preview {
    ExerciseDetailsView(viewModel: ExerciseDetailsViewModel(exercises: ExercisesDetails(id: 1, uuid: "", images: [], exercises: [Exercise(id: 1, uuid: "", name: "", exerciseBase: 3, description: "", language: .english, created: "")], variations: 1), exerciseService: ExerciseService()), navigator: Navigator(navigationController: UINavigationController()))
}
