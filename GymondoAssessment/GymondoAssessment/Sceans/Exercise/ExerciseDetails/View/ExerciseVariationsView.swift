//
//  ExerciseVariationsView.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI
import Gymondo

struct ExerciseVariationsView: View {
    @ObservedObject var viewModel: ExerciseDetailsViewModel
    var navigator: NavigatorType
    
    init(viewModel: ExerciseDetailsViewModel, navigator: NavigatorType) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    var body: some View {
        LazyVStack(spacing: 5){
            Text("Variations")
                .font(Font.system(size: 20,weight: .bold))
                .frame(maxWidth: .infinity,alignment: .leading)
            switch viewModel.variationsDetail {
            case .loading:
                Text("Loading..")
                    .font(Font.system(size: 14,weight: .light))
                    .frame(maxWidth: .infinity,alignment: .leading)
            case .variations(let exercise):
                if let exerciseDetails = exercise.exercises?.first(where: {$0.language == LanguageManager.default.language}) {
                    VariationsExerciseRow(exercise: exerciseDetails,exerciseImage: exercise.mainImage)
                        .background(Color.white).onTapGesture {
                            navigator.navigate(to: .exerciseDetails(exercise))
                        }
                }
                
            case .error(let errorMessage):
                Text(errorMessage)
                    .font(Font.system(size: 14,weight: .light))
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
        .padding()
    }
}

#Preview {
    ExerciseVariationsView(viewModel: ExerciseDetailsViewModel(exercises: ExercisesDetails(id: 1, uuid: "", images: [], exercises: [Exercise(id: 1, uuid: "", name: "", exerciseBase: 1, description: "", language: .english, created: "")], variations: 1), exerciseService: ExerciseService()), navigator: Navigator(navigationController: UINavigationController()))
}
