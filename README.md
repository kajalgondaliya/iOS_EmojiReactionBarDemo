# EmojiReactionBarDemo
### Animated Floating Reactions 

## Usage

Put `TIEmojiReaction` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

### Storyboard

1. Set 'ReactionPalletView' to a custom class of UIView.

![Usage_1](/uploads/def633a71c952242233d7cb356616653/ReactionPallet.png)

## OR

### Code

```
let emojiConfettiView = ReactionPalletView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
self.view.addSubview(emojiConfettiView)
```

### Assign emojis and delegate

```
emojiConfettiView.emojiDelegate = self
emojiConfettiView.arrEmoji = ["❤️", "😆", "😯", "😢", "😠", "👍"]
```

### Get selected emoji using Delegate method

```
extension ViewController: ReactionPalletDelegate {
    func selectedReaction(_ emojiImage: UIImage, text: String) {
        print("this is added reaction --> \(text)")
    }
}
```
## Preview
![preview](/uploads/2af657489dbf2dcec96bb313a1e05f4a/ezgif.com-optimize.gif)
