//
//  ExerciseAsyncImagesView.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI
import Gymondo

struct ExerciseAsyncImagesView: View {
    var exerciseImages: [ExerciseImage]?
    @State private var currentPage: Int = 0
    var body: some View {
        
        LazyVStack {
            if let images = exerciseImages, !images.isEmpty {
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack {
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
                    }
                    .offset(x: CGFloat(currentPage) * -UIScreen.main.bounds.width, y: 0)
                               .animation(.easeInOut, value: currentPage)
                }
                .gesture(
                    DragGesture().onEnded { value in
                                    let offset = value.translation.width
                                    let newIndex = (offset > 0) ? currentPage - 1 : currentPage + 1
                                    currentPage = min(max(newIndex, 0), images.count - 1)
                                }
                )
                PageControl(numberOfPages: images.count, currentPage: $currentPage)
            } else {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(1.0,contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .clipped()
            }
            
        }
    }
}

#Preview {
    ExerciseAsyncImagesView(exerciseImages: [])
}
