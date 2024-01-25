//
//  ViewControllerWithLanageChangeOption.swift
//  GymondoAssessment
//
//  Created by psagc on 25/01/24.
//

import UIKit
import Gymondo

public class ViewControllerWithLanageChangeOption: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLangegeChangeOption()
    }
    
    private func setupLangegeChangeOption() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LanguageManager.default.language.displayName, style: .plain, target: self, action: #selector(showLanguageOptions))
    }
    
    @objc func showLanguageOptions() {
        let alertController = UIAlertController(title: "Select lanaguage", message: "Please note that it only show you the available exercise in selected lanagege", preferredStyle: .actionSheet)
        for language in Exercise.Language.allCases {
            alertController.addAction(UIAlertAction(title: language.displayName, style: .default,handler: { [weak self] _ in
                LanguageManager.default.language = language
                self?.didUserChangedLanaguage(lanaguage: language)
                self?.navigationItem.rightBarButtonItem?.title = language.displayName
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    
    func didUserChangedLanaguage(lanaguage: Exercise.Language) {   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
