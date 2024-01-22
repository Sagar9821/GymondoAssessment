//
//  ExerciseAsyncImagesView.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI
import Gymondo

struct ExerciseAsyncImagesView: View {
    var exercise: Exercise
    var body: some View {
        if let images = exercise.images {
            ForEach(images,id: \.self) { image in
                AsyncImage(url: URL(string: image.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(1.0,contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .clipped()
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(1.0,contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .clipped()
                }
            }
        } else {
            Image("placeholder")
                .resizable()
                .aspectRatio(1.0,contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .clipped()
        }
    }
}

#Preview {
    ExerciseAsyncImagesView(exercise: .init(id: 0, uuid: "", name: "", exerciseBase: 1, description: "", images: nil, created: "", variations: []))
}
