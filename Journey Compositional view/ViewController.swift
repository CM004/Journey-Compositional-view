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
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        return cell
    }
}

