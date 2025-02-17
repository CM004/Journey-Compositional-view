//
//  ViewController.swift
//  Journey Compositional view
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class ViewController: UIViewController {
    // Properties
    var exercisesCompleted = 0 {
        didSet {
            UserDefaults.standard.set(exercisesCompleted, forKey: "exercisesCompleted")
        }
    }
    
    var streakCount = 0 {
        didSet {
            UserDefaults.standard.set(streakCount, forKey: "streakCount")
        }
    }
    
    var lastExercisedate: Date? = nil {
        didSet {
            UserDefaults.standard.set(lastExercisedate, forKey: "lastExerciseDate")
        }
    }
    
    // Outlets
    @IBOutlet var profileButton: UIImageView!
    @IBOutlet var streaksLabel: UILabel!
    @IBOutlet var trophiesLabel: UILabel!
    
    // Private properties
    private var collectionView: UICollectionView!
    private let journeyManager = JourneyManager.shared
    private var currentLevel: Level!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved values
        exercisesCompleted = UserDefaults.standard.integer(forKey: "exercisesCompleted")
        streakCount = UserDefaults.standard.integer(forKey: "streakCount")
        lastExercisedate = UserDefaults.standard.object(forKey: "lastExerciseDate") as? Date
        
        currentLevel = journeyManager.getJourney().levels[0]
        setupCollectionView()
        updateLabels()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(650))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .absolute(650))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = -150 // Keep this adjustment for proper spacing
            
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "DayCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.tag = indexPath.item
        cell.dayLabel.text = "DAY \(indexPath.item + 1)"
        
        if indexPath.item == 0 {
            cell.levelLabel.text = "Level 1"
            cell.levelLabel.isHidden = false
        } else {
            cell.levelLabel.isHidden = true
        }
        
        // Setup tap gestures for exercise nodes
        setupExerciseNodeTaps(in: cell, forDay: indexPath.item + 1)
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        return cell
    }
    
    // Add these new methods
    private func setupExerciseNodeTaps(in cell: DayCollectionViewCell, forDay day: Int) {
        let exerciseNodes = [cell.exerciseNode1, cell.exerciseNode2, cell.exerciseNode3, cell.exerciseNode4]
        
        for (index, node) in exerciseNodes.enumerated() {
            // Make sure the node is user interactive
            node?.isUserInteractionEnabled = true
            
            // Remove any existing gesture recognizers
            if let existingGestures = node?.gestureRecognizers {
                for gesture in existingGestures {
                    node?.removeGestureRecognizer(gesture)
                }
            }
            
            // Add new tap gesture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exerciseNodeTapped(_:)))
            tapGesture.cancelsTouchesInView = false
            node?.tag = (day * 10) + index
            node?.addGestureRecognizer(tapGesture)
            
            // Ensure the node's subviews don't interfere with the tap
            node?.subviews.forEach { $0.isUserInteractionEnabled = false }
        }
    }
    
    @objc private func exerciseNodeTapped(_ gesture: UITapGestureRecognizer) {
        guard let nodeView = gesture.view else { return }
        let day = nodeView.tag / 10
        let exerciseIndex = nodeView.tag % 10
        
        // Only first exercise of day 1 is unlocked
        let isLocked = !(day == 1 && exerciseIndex == 0)
        
        print("Tapped Day \(day), Exercise \(exerciseIndex + 1)")
        let timeRequired = getTimeRequired(for: exerciseIndex)
        showExercisePopUp(forDay: day, exerciseIndex: exerciseIndex, timeRequired: timeRequired, isLocked: isLocked)
    }
    
    private func getTimeRequired(for exerciseIndex: Int) -> Int {
        // Exercise times between 4-6 minutes
        switch exerciseIndex {
            case 0: return 4
            case 1: return 5
            case 2: return 6
            case 3: return 4
            default: return 5
        }
    }
    
    private func showExercisePopUp(forDay day: Int, exerciseIndex: Int, timeRequired: Int, isLocked: Bool) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.tag = 999
        view.addSubview(overlayView)
        
        // Pop-up size and position
        let popUpWidth: CGFloat = 283
        let popUpHeight: CGFloat = 389
        let popUpX = (view.bounds.width - popUpWidth) / 2
        let popUpY = (view.bounds.height - popUpHeight) / 2
        let popUpView = UIView(frame: CGRect(x: popUpX, y: popUpY, width: popUpWidth, height: popUpHeight))
        popUpView.backgroundColor = .white
        popUpView.layer.cornerRadius = 12
        overlayView.addSubview(popUpView)
        
        // Background Image
        let backgroundImage = UIImageView(frame: popUpView.bounds)
        backgroundImage.image = UIImage(named: "cardBackground")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        popUpView.addSubview(backgroundImage)
        
        // Exercise Image
        let exerciseImage = UIImageView(frame: CGRect(
            x: (popUpView.bounds.width - 200) / 2,  // Adjusted width for better visibility
            y: 40,  // Position from top
            width: 200,  // Increased width
            height: 180  // Increased height
        ))
        exerciseImage.image = UIImage(named: "exerciseImage\(exerciseIndex + 1)")
        exerciseImage.contentMode = .scaleAspectFit
        exerciseImage.clipsToBounds = true
        popUpView.addSubview(exerciseImage)
        
        // Exercise Label - Adjusted position to accommodate new image size
        let exerciseLabel = UILabel(frame: CGRect(x: 10, y: 240, width: popUpView.bounds.width - 20, height: 30))
        
        exerciseLabel.text = "Exercise \(exerciseIndex + 1)"
        exerciseLabel.textAlignment = .center
        exerciseLabel.font = UIFont.boldSystemFont(ofSize: 20)
        exerciseLabel.textColor = .black
        popUpView.addSubview(exerciseLabel)
        
        // Time Required Label
        let timeLabel = UILabel(frame: CGRect(x: 10, y: 280, width: popUpView.bounds.width - 20, height: 30))
        timeLabel.text = "Time Required: \(timeRequired) minutes"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = .darkGray
        popUpView.addSubview(timeLabel)
        
        // Day Label
        let dayLabel = UILabel(frame: CGRect(x: 10, y: 310, width: popUpView.bounds.width - 20, height: 30))
        dayLabel.text = "Day \(day)"
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 16)
        dayLabel.textColor = .darkGray
        popUpView.addSubview(dayLabel)
        
        // Continue Button or Locked Label
        if !isLocked {
            let continueButton = UIButton(type: .system)
            continueButton.setTitle("Continue", for: .normal)
            continueButton.frame = CGRect(x: 20, y: 345, width: popUpView.bounds.width - 40, height: 40)
            continueButton.backgroundColor = .systemBlue
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.layer.cornerRadius = 8
            continueButton.tag = (day * 10) + exerciseIndex
            continueButton.addTarget(self, action: #selector(continueToExercise(_:)), for: .touchUpInside)
            popUpView.addSubview(continueButton)
        } else {
            // Single locked message
            let lockedLabel = UILabel(frame: CGRect(x: 10, y: 345, width: popUpView.bounds.width - 20, height: 40))
            lockedLabel.text = "Finish previous exercise to Unlock."
            lockedLabel.textAlignment = .center
            lockedLabel.textColor = .red
            lockedLabel.font = UIFont.systemFont(ofSize: 14)
            popUpView.addSubview(lockedLabel)
        }
        
        // Locked Status Label (for locked exercises)
//        if isLocked {
//            let lockedLabel = UILabel(frame: CGRect(x: 10, y: 315, width: popUpView.bounds.width - 20, height: 40))
//            lockedLabel.text = "This exercise is locked."
//            lockedLabel.textAlignment = .center
//            lockedLabel.textColor = .red
//            lockedLabel.font = UIFont.systemFont(ofSize: 14)
//            popUpView.addSubview(lockedLabel)
//        }
        
        // Dismiss Button
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("✕", for: .normal)
        dismissButton.frame = CGRect(x: popUpView.bounds.width - 40, y: 10, width: 30, height: 30)
        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        popUpView.addSubview(dismissButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissPopUp() {
        if let overlayView = view.viewWithTag(999) {
            overlayView.removeFromSuperview()
        }
    }
    
    @objc private func continueToExercise(_ sender: UIButton) {
        let day = sender.tag / 10
        let exerciseIndex = sender.tag % 10
        print("Continue to Day \(day), Exercise \(exerciseIndex + 1)")
        dismissPopUp()
        // Add your navigation logic here
        
        exercisesCompleted += 1
        updateStreaks()
        updateLabels()
    }
    private func updateLabels() {
            trophiesLabel.text = "\(exercisesCompleted)"
            streaksLabel.text = "\(streakCount)"
        }
    private func updateStreaks() {
            let currentDate = Calendar.current.startOfDay(for: Date())
            
            if let lastDate = lastExercisedate {
                if Calendar.current.isDateInYesterday(lastDate) {
                    streakCount += 1
                } else if !Calendar.current.isDateInToday(lastDate) {
                    streakCount = 1 // Reset streak if a day is missed
                }
            } else {
                streakCount = 1 // First day of exercise
            }
            
            lastExercisedate = currentDate
        }
}

