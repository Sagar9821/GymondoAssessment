//
//  PageControl.swift
//  GymondoAssessment
//
//  Created by psagc on 22/01/24.
//

import SwiftUI

struct PageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0...numberOfPages-1,id: \.self) { page in
                Circle()
                    .fill(page == currentPage ? Color.black : Color.gray)
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        currentPage = page
                    }
            }
        }
    }
}

#Preview {
    PageControl(numberOfPages: 4, currentPage: .constant(1))
}
