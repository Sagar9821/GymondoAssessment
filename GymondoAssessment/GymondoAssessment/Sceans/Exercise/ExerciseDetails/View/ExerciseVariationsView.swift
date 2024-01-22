//
//  ExerciseVariationsView.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI
import Gymondo

struct ExerciseVariationsView: View {
    var variations: [Exercise]
    var body: some View {
        VStack(spacing: 5){
            Text("Variations")
                .font(Font.system(size: 20,weight: .bold))
                .frame(maxWidth: .infinity,alignment: .leading)
            if variations.isEmpty {
                Text("No Variation exercise")
                    .font(Font.system(size: 14,weight: .light))
                    .frame(maxWidth: .infinity,alignment: .leading)
            } else {
                ForEach(variations) { exercise in
                    VariationsExerciseRow(exercise: exercise)
                        .background(Color.white)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ExerciseVariationsView(variations: [])
}
