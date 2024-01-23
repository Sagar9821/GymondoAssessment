//
//  ExerciseListViewController+TestHelper.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import UIKit
import GymondoAssessment

extension ExerciseListViewController {
    var viewTitle: String? {
        return title
    }
    
    var numberRenderedExerciseView: Int {
        return tableViewExercises.numberOfRows(inSection: exerciseRowsSections)
    }
    
    func getExerciseRowView(at row: Int) -> ExerciseCell? {
        tableViewExercises.cellForRow(at: IndexPath(row: row, section: exerciseRowsSections)) as? ExerciseCell
    }
    
    var exerciseRowsSections: Int {
        0
    }
}

