//
//  ViewController.swift
//  Journey Compositional view
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let journeyManager = JourneyManager.shared
    private var currentLevel: Level!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLevel = journeyManager.getJourney().levels[0]
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        // Create compositional layout
        let layout = UICollectionViewCompositionalLayout { section, env in
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(650))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .absolute(650))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            
            return section
        }
        
        // Create collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        // Register cell
        collectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "DayCollectionViewCell")
        
        // Set delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        view.addSubview(collectionView)
        
        // Add constraints
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
        return 10  // Changed from currentLevel.days.count to 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell",
                                                          for: indexPath) as? DayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configure cell with day number
        cell.dayLabel.text = "DAY \(indexPath.item + 1)"
        
        // Update level label based on day number
        let levelNumber = (indexPath.item < 3) ? 1 : ((indexPath.item < 6) ? 2 : 3)
        if let levelLabel = cell.viewWithTag(1001) as? UILabel {
            levelLabel.text = "Level \(levelNumber)"
        }
        
        // Make cell background clear
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        return cell
    }
}

