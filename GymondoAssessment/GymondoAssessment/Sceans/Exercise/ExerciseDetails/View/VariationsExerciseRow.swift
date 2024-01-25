//
//  VariationsExerciseRow.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI
import Gymondo

struct VariationsExerciseRow: View {
    var exercise: Exercise
    var exerciseImage: ExerciseImage?
    var body: some View {
       RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay {
                HStack(alignment: .center, spacing: 10){
                    AsyncImage(url: URL(string: exerciseImage?.image ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(1.0,contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipped()
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(1.0,contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipped()
                    }
                    Text(exercise.name.unsafelyUnwrapped)
                        .font(Font.system(size: 16,weight: .bold))
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
            }
            .frame(height: 80)
            .padding()
    }
}

#Preview {
    VariationsExerciseRow(exercise: Exercise(id: 1, uuid: "", name: "Alzate Laterali", exerciseBase: 1, description: "", language: .english, created: ""), exerciseImage: nil)
}
