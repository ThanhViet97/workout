//
//  TrainingViewController.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

class TrainingViewController: BaseViewController, BindableType, AlertDisplayer {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: TrainingViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bindViewModel() {
        viewModel.viewModelState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .initial: break
                case .startLoading: break
                case .stopLoading: break
                case .failed(let error):
                    self?.tableView.reloadData()
                    self?.showErrorMessage(message: error)
                case .didChangeDataSuccess:
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        viewModel.getDayData()
    }
}

private extension TrainingViewController {
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(TrainingCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

extension TrainingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weekTrainingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrainingCell = tableView.dequeueReusableCell(for: indexPath)
        if 0..<viewModel.weekTrainingData.count ~= indexPath.row {
            let dayOfWeekTrainingData = viewModel.weekTrainingData[indexPath.row]
            cell.dayOfWeekTrainingData = dayOfWeekTrainingData
            cell.didTapWorkout = { [weak self] assignment in
                self?.viewModel.didChangeWorkout(assignment: assignment)
            }
        }
        return cell
    }
}
