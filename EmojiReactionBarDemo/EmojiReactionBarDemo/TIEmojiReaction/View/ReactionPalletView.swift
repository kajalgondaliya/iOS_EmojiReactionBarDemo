//
//  ReactionPalletView.swift
//  EmojiReactionBarDemo
//
//  Created by Tecocraft on 21/11/22.
//

import UIKit

protocol ReactionPalletDelegate: AnyObject {
    func selectedReaction(_ emojiImage: UIImage, text: String)
}

class ReactionPalletView: UIView {
    
    @IBOutlet weak var emojisCollectionView: UICollectionView! {
        didSet {
            emojisCollectionView.dataSource = self
            emojisCollectionView.delegate = self
            emojisCollectionView.register(UINib(nibName: "EmojiCVCell", bundle: nil), forCellWithReuseIdentifier: "emojiCell")
        }
    }
    
    @IBOutlet weak var emojiConfettiView: TIReactionConfettiView!
    
    let nibName = "ReactionPalletView"
    var contentView: UIView?
    weak var emojiDelegate: ReactionPalletDelegate?
    var arrEmoji: [String] = [] // Here you can add your own emojis string

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Helper Methods
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: [:]).first as? UIView
    }
}

// MARK: - UICollection Delegate & Datasource Methods
extension ReactionPalletView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrEmoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as? EmojiCVCell else {
            return UICollectionViewCell()
        }
        
        cell.imgEmoji.image = arrEmoji[indexPath.row].textToImage() //UIImage(named: arrEmojiNames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EmojiCVCell,
              let emoji = cell.imgEmoji.image else {
                  return
              }
        emojiConfettiView.stopConfetti()
        emojiConfettiView.isHidden = true
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            cell.imgEmoji.transform = cell.imgEmoji.transform.scaledBy(x:  1.3, y:  1.3)
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, animations: {
                cell.imgEmoji.transform = CGAffineTransform.identity
            })
        })
        
        
        let duration = 0.2
        emojiConfettiView.isHidden = false
        emojiConfettiView.direction = .bottom
        emojiConfettiView.setImageForConfetti(image: emoji)
        emojiConfettiView.startConfetti(duration: duration)
        if let delegate = emojiDelegate {
            delegate.selectedReaction(emoji, text: arrEmoji[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/6), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
