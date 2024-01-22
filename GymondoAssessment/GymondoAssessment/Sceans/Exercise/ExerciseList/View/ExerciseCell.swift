//
//  ExerciseCell.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo
import SDWebImage
class ExerciseCell: UITableViewCell {

    @IBOutlet private weak var lableExerciseName: UILabel!
    @IBOutlet private weak var imageViewExercise: UIImageView!
    @IBOutlet private weak var imageWidthConstant:NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var exercise: ExercisesDetails?{
        didSet {
            lableExerciseName.text = exercise?.exercises?.first(where: {$0.language == .english})?.name
        }
    }
    
    func loadImage() {
        if let exercise = exercise,let url = exercise.mainImage?.image ,
            let url = URL(string: url){
            self.imageViewExercise.sd_setImage(with: url,placeholderImage: UIImage(named: "placeholder")) { image, error, type, url in
                if type == .none {
                    self.imageViewExercise.alpha = 0
                    UIView.animate(withDuration: 2.0) {
                        self.imageViewExercise.alpha = 1.0
                    }
                }
            }
        } else {
            self.imageViewExercise.image = UIImage(named: "placeholder")
        }
    }
   
}
