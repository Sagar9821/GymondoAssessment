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
            if viewModel.variations.isEmpty {
                Text("No Variation exercise")
                    .font(Font.system(size: 14,weight: .light))
                    .frame(maxWidth: .infinity,alignment: .leading)
            } else {
                ForEach(viewModel.variations) { exercise in
                    VariationsExerciseRow(exercise: exercise)
                        .background(Color.white).onTapGesture {
//                            self.navigator.navigate(to: .exerciseDetails(exercise, viewModel.))
                        }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ExerciseVariationsView(viewModel: ExerciseDetailsViewModel(exercises: ExercisesDetails(id: 1, uuid: "", images: [], exercises: [Exercise(id: 1, uuid: "", name: "", exerciseBase: 1, description: "", language: .english, images: nil, created: "")], variations: 1), exerciseService: ExerciseService()), navigator: Navigator(navigationController: UINavigationController()))
}
