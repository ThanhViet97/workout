//
//  WorkoutView.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

class WorkoutView: UIView {
    
    @IBOutlet private weak var workoutNameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var selectedImageView: UIImageView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var selectButton: UIButton!
    
    var didTapWorkout: ((Assignment) -> Void)?
    
    private var assignment: Assignment?
    private var isWorkoutPastDate = false
    private var isWorkoutFutureDate = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadViewFromNib()
    }
    
    // MARK: - Configure
    func configure(isWorkoutPastDate: Bool, isWorkoutFutureDate: Bool, assignment: Assignment) {
        self.isWorkoutPastDate = isWorkoutPastDate
        self.isWorkoutFutureDate = isWorkoutFutureDate
        self.assignment = assignment
        setupUI()
    }
    
    // MARK: - Load Nib
    private func loadViewFromNib() {
        let nib = UINib(nibName: WorkoutView.className, bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }
}

// MARK: - Actions
extension WorkoutView {
    
    @IBAction private func didTapWorkout(_ sender: Any) {
        guard let assignment else { return }
        didTapWorkout?(assignment)
    }
}
// MARK: - Handle UI Change
extension WorkoutView {
    
    private func setupUI() {
        setupFont()
        guard let assignment else { return }
        workoutNameLabel.text = assignment.title
        configureWorkoutStatus(isWorkouted: assignment.isWorkouted ?? false)
        statusLabel.attributedText = getStatusAttributedText(for: assignment)
    }
    
    private func setupFont() {
        workoutNameLabel.font = AppFont.bold.withSize(15)
        statusLabel.font = AppFont.regular.withSize(13)
    }
    
    private func configureWorkoutStatus(isWorkouted: Bool) {
        selectedImageView.isHidden = !isWorkouted
        contentView.backgroundColor = isWorkouted ? AppColor.purple : AppColor.lightGray
        let isFutureDate = isWorkoutFutureDate
        setupTextColor(isFutureDate: isFutureDate, isSelected: isWorkouted)
    }
    
    private func setupTextColor(isFutureDate: Bool, isSelected: Bool) {
        let unselectedColor = isFutureDate ? AppColor.primaryGray : AppColor.purpleDark
        let textColor = isSelected ? AppColor.white : unselectedColor
        workoutNameLabel.textColor = textColor
        statusLabel.textColor = textColor
    }
    
    private func getStatusAttributedText(for assignment: Assignment) -> NSAttributedString {
        switch assignment.getWorkoutStatus() {
        case .inProgress:
            return NSAttributedString(string: Strings.Workout.inProgress)
        case .complete:
            return NSAttributedString(string: Strings.Workout.completed)
        case .assign:
            return getAttributedAssignText(for: assignment)
        }
    }
    
    private func getAttributedAssignText(for assignment: Assignment) -> NSAttributedString {
        let exerciseText = Strings.Workout.exercises(assignment.exercisesCount)
        
        if !isWorkoutPastDate {
            return NSAttributedString(string: exerciseText)
        }
        
        // Missed workout case
        let missedText = Strings.Workout.missed
        let fullText = "\(missedText) • \(exerciseText)"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Highlight "missed" text in red
        let missedRange = (fullText as NSString).range(of: missedText, options: .caseInsensitive)
        attributedText.addAttribute(.foregroundColor, value: AppColor.bordRed, range: missedRange)
        
        return attributedText
    }
}
