//
//  ExerciseListViewController.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Combine

class ExerciseListViewController: UIViewController {

    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var tableViewExercises: UITableView!
    
    private var cancellable:Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let navigator: NavigatorType
    private let viewModel: ExerciseListViewModel
    required init?(coder: NSCoder, navigator: NavigatorType, viewModel: ExerciseListViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareView()
        bindViewModelToView()
    }
    
    private func prepareView() {
        title = "Exercises"
        tableViewExercises.dataSource = self
        viewModel.fetchExercise()
    }

    private func bindViewModelToView() {
       
        let stateValueHandler: (ViewState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.activityLoader.startAnimating()
            case .failure(let message):
                self?.activityLoader.stopAnimating()
            case .none,.success:
                self?.activityLoader.stopAnimating()
            }
        }
        
        viewModel.viewState
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: stateValueHandler)
                        .store(in: &cancellable)
        
        
        viewModel.exercisesSubject.sink { completion in
            switch completion {
            case .finished:
                print("complete")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { exercise in
            self.tableViewExercises.reloadData()
            
        }.store(in: &cancellable)
        
        
    }
    
    
}
// MARK: - TableView DataSource
extension ExerciseListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrayExercise.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(ExerciseCell.self) else { return UITableViewCell() }
        cell.exercise = viewModel.arrayExercise[indexPath.row]
        return cell
    }
}
