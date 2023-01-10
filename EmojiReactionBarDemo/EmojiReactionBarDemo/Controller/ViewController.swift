//
//  ViewController.swift
//  EmojiReactionBarDemo
//
//  Created by Tecocraft on 21/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emojiConfettiView: ReactionPalletView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiConfettiView.emojiDelegate = self
        emojiConfettiView.arrEmoji = ["❤️", "😆", "😯", "😢", "😠", "👍"]
    }
}

extension ViewController: ReactionPalletDelegate {
    func selectedReaction(_ emojiImage: UIImage, text: String) {
        print("this is added reaction --> \(text)")
    }
}

