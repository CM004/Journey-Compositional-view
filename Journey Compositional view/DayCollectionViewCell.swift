//
//  DayCollectionViewCell.swift
//  Journey Compositional view
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

// Add this protocol at the top of the file
protocol DayCollectionViewCellDelegate: AnyObject {
    
    func didTapExerciseNode(_ node: Int, in cell: DayCollectionViewCell)
}

class DayCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet var dayLabel: UILabel!
    
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var exerciseNode1: UIView!
    
    @IBOutlet var exerciseNode2: UIView!
    
    @IBOutlet var exerciseNode3: UIView!
    
    @IBOutlet var exerciseNode4: UIView!
    
    weak var delegate: DayCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNodeInteractions()
    }
    
    private func setupNodeInteractions() {
        let nodes = [exerciseNode1, exerciseNode2, exerciseNode3, exerciseNode4]
        
        for (index, node) in nodes.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nodeTapped(_:)))
            node?.tag = index + 1
            node?.addGestureRecognizer(tapGesture)
            node?.isUserInteractionEnabled = true
        }
    }
    
    @objc private func nodeTapped(_ sender: UITapGestureRecognizer) {
        guard let nodeView = sender.view else { return }
        delegate?.didTapExerciseNode(nodeView.tag, in: self)
    }
}


