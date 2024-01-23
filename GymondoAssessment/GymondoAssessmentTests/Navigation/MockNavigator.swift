//
//  MockNavigator.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import UIKit
import GymondoAssessment

class MockNavigator: NavigatorType {
    
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func startUserFlow(with entrypoint: UserFlowEntryPoint) {
        
    }
    
    func navigate(to destination: Destinations) {
        
    }
    
    
}
