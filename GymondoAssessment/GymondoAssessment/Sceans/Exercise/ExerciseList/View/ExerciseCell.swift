//
//  ExerciseCell.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Gymondo
import SDWebImage
import Combine

public class ExerciseCell: UITableViewCell {

    @IBOutlet public weak var lableExerciseName: UILabel!
    @IBOutlet public weak var imageViewExercise: UIImageView!
    @IBOutlet public weak var imageWidthConstant:NSLayoutConstraint!
    
  
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var exercise: ExerciseCellViewModel?{
        didSet {
            lableExerciseName.text = exercise?.exercise.name
        }
    }
    
    func loadImage() {
        if let exercise = exercise,let url = exercise.image?.image ,
            let url = URL(string: url){
            self.imageViewExercise.sd_setImage(with: url,placeholderImage: UIImage(named: "placeholder")) { [weak self] image, error, type, url in
                if type == .none {
                    self?.imageViewExercise.alpha = 0
                    UIView.animate(withDuration: 2.0) {
                        self?.imageViewExercise.alpha = 1.0
                    }
                }
            }
        } else {
            self.imageViewExercise.image = UIImage(named: "placeholder")
        }
    }
   
}
