//
//  Navigator.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo
import SwiftUI

public enum UserFlowEntryPoint {
     case exerciseList
}

public protocol NavigatorType {
    func startUserFlow(with entrypoint: UserFlowEntryPoint)
    func navigate(to destination: Destinations)
}

class Navigator: NavigatorType {
    
    private let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startUserFlow(with entrypoint: UserFlowEntryPoint) {
        switch entrypoint {
        case .exerciseList:
            let storyboard = GymondoStoryboard.exercise
            let exerciseService: ExerciseService = ExerciseService()
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
            let exerciseService: ExerciseService = ExerciseService()
            let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercises: exercise,exerciseService: exerciseService)
            let exerciseDetailsView = ExerciseDetailsView(viewModel: exerciseDetailsViewModel, navigator: self)
            let hostingVc = UIHostingController(rootView: exerciseDetailsView)
            navigationController.pushViewController(hostingVc, animated: true)
            break
        }
    }
    
}

