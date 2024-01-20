//
//  Navigator.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo

enum UserFlowEntryPoint {
     case exerciseList
}

protocol NavigatorType {
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
    
    func navigate(to destination: Destinations) { }
    
}

