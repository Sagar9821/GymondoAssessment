//
//  ExerciseCell.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo

class ExerciseCell: UITableViewCell {

    @IBOutlet private weak var lableExerciseName: UILabel!
    @IBOutlet private weak var imageViewExercise: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var exercise: Exercise?{
        didSet {
            lableExerciseName.text = exercise?.name
        }
    }
}
