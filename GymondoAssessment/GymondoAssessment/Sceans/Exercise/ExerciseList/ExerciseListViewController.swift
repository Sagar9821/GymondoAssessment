//
//  ExerciseListViewController.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import UIKit
import Combine
import Gymondo

public class ExerciseListViewController: ViewControllerWithLanageChangeOption {

    @IBOutlet public weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet public weak var tableViewExercises: UITableView!
    @IBOutlet public weak var labelExercisePlaceholder: UILabel!
    
    private var cancellable:Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let navigator: NavigatorType
    private let viewModel: ExerciseListViewModelType
    
    public required init?(coder: NSCoder, navigator: NavigatorType, viewModel: ExerciseListViewModelType) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareView()
        bindViewModelToView()
    }
    
    private func prepareView() {
        title = "Exercises"
        setupExerciseTableView()
        viewModel.fetchExercise(refreshing: false)
    }

    private func bindViewModelToView() {
       
        let stateValueHandler: (ViewState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.activityLoader.startAnimating()
            case .failure(let message):
                self?.activityLoader.stopAnimating()
                self?.showAlert(title: "Error", message: message, retry: { [weak self] _ in
                    self?.viewModel.fetchExercise(refreshing: false)
                })
            case .none,.success:
                self?.activityLoader.stopAnimating()
            }
        }
        
        viewModel.viewState
                        .receive(on: RunLoop.main)
                        .sink(receiveValue: stateValueHandler)
                        .store(in: &cancellable)
        
        
        viewModel.exercisesSubject.sink {  completion in
            switch completion {
            case .finished:
                print("complete")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] exercise in
            self?.labelExercisePlaceholder.isHidden = !exercise.isEmpty
            self?.tableViewExercises.reloadWithAnimation()
            
        }.store(in: &cancellable)
        
        
    }
    
    private func setupExerciseTableView() {
        tableViewExercises.accessibilityIdentifier = "exerciseTableView"
        tableViewExercises.dataSource = self
        tableViewExercises.delegate = self
        labelExercisePlaceholder.isHidden = true
        let refreshController = UIRefreshControl()
        tableViewExercises.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshExerciseList), for: .valueChanged)
        viewModel.refreshing.sink { _ in } receiveValue: { [weak self] value in
            value == true ? self?.tableViewExercises.refreshControl?.beginRefreshing() : self?.tableViewExercises.refreshControl?.endRefreshing()
        }.store(in: &cancellable)

    }
    
    @objc func refreshExerciseList() {
        viewModel.fetchExercise(refreshing: true)
    }
    
    public override func didUserChangedLanaguage(lanaguage: Exercise.Language) {
        viewModel.changeLanaguage(lanaguage: lanaguage)
    }
}
// MARK: - TableView DataSource
extension ExerciseListViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrayExercise.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(ExerciseCell.self) else { return UITableViewCell() }
        cell.exercise = viewModel.arrayExercise[indexPath.row]
        return cell
    }
}
//MARK: TableView Delegate
extension ExerciseListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let exerciseCell = cell as? ExerciseCell {
            exerciseCell.loadImage()
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let details = viewModel.getExerciseDetails(exercise: viewModel.arrayExercise[indexPath.row]) {
            navigator.navigate(to: .exerciseDetails(details))
        }
    }
}

