//
//  DayCollectionViewCell.swift
//  Journey Compositional view
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var dayLabel: UILabel!
    
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var exerciseNode1: UIView!
    
    @IBOutlet var exerciseNode2: UIView!
    
    
    @IBOutlet var exerciseNode3: UIView!
    
    
    @IBOutlet var exerciseNode4: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addTapGestureToNode(exerciseNode1, action: #selector(exerciseNodeTapped(_:)))
                addTapGestureToNode(exerciseNode2, action: #selector(exerciseNodeTapped(_:)))
                addTapGestureToNode(exerciseNode3, action: #selector(exerciseNodeTapped(_:)))
                addTapGestureToNode(exerciseNode4, action: #selector(exerciseNodeTapped(_:)))
            }
    private func addTapGestureToNode(_ node: UIView, action: Selector) {
            let tapGesture = UITapGestureRecognizer(target: self, action: action)
            node.addGestureRecognizer(tapGesture)
            node.isUserInteractionEnabled = true
        }
        
        @objc private func exerciseNodeTapped(_ sender: UITapGestureRecognizer) {
            guard let tappedNode = sender.view else { return }
            print("Tapped on exercise node: \(tappedNode)")
            
            // Optionally, you can trigger a delegate or closure here to communicate with the ViewController
        }
    }


