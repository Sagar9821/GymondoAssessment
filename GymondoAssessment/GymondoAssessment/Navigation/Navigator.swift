//
//  Navigator.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo
import SwiftUI

enum UserFlowEntryPoint {
     case exerciseList
}

protocol NavigatorType {
     func startUserFlow(with entrypoint: UserFlowEntryPoint)
     func navigate(to destination: Destinations)
}

class Navigator: NavigatorType {
    
    private let navigationController: UINavigationController
    let exerciseService: ExerciseService = ExerciseService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startUserFlow(with entrypoint: UserFlowEntryPoint) {
        switch entrypoint {
        case .exerciseList:
            let storyboard = GymondoStoryboard.exercise
            
            let viewModel = ExerciseListViewModel(excerciseServices: exerciseService)
            let viewController = storyboard.instantiateViewController(identifier: ExerciseListViewController.storyboardID) { coder in
                return ExerciseListViewController(coder: coder, navigator: self, viewModel: viewModel)
            }
            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
    func navigate(to destination: Destinations) {
        switch destination {
        case .exerciseDetails(let exercise):
            let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercises: exercise,exerciseService: exerciseService)
            let exerciseDetailsView = ExerciseDetailsView(viewModel: exerciseDetailsViewModel)
            let hostingVc = UIHostingController(rootView: exerciseDetailsView)
            navigationController.pushViewController(hostingVc, animated: true)
            break
        }
    }
    
}

