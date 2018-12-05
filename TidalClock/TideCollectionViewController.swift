//
//  ViewController.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/1/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import UIKit

class TideCollectionViewController: UICollectionViewController {

    private var longPressGestureRecognizer: UILongPressGestureRecognizer?
    
    let pixels = Pixels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.alwaysBounceVertical = false
        collectionView.register(PixelCollectionViewCell.self, forCellWithReuseIdentifier: PixelCollectionViewCell.reuseIdentifier)
        longPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPress(_:)))
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

// MARK - UICollectionViewDataSource
extension TideCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pixels.pixelArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pixels.pixelArray[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PixelCollectionViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = pixels.pixelArray[indexPath.section][indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
}

// MARK - UICollectionViewFlowLayoutDelegate
extension TideCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = self.view.bounds.inset(by: self.view.safeAreaInsets)
        
        let size = CGSize.init(width: screenSize.width / CGFloat(pixels.pixelArray[indexPath.section].count), height: screenSize.height / CGFloat(pixels.pixelArray.count))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pixels.setColor(.white, forItemAt: indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
}

// Mark - Rotation
extension TideCollectionViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewLayout.invalidateLayout()
    }
}

