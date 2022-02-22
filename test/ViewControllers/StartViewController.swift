import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var words: UIImageView!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var book: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        words.center.x -= view.bounds.width
        book.center.x -= view.bounds.width
        startButton.center.x -= view.bounds.width
        self.circle.rotate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 1, delay: 0.5, animations: {
            self.words.center.x += self.view.bounds.width
        })
        UIView.animate(withDuration: 1, delay: 1.5, animations: {
            self.book.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 2.5, animations: {
            self.startButton.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideImageAfterTime(time: 3.2, imageView: circle)
    }
    
    func hideImageAfterTime(time: CFTimeInterval, imageView: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.circle.isHidden = true
        }
    }
}

extension UIView {
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.isRemovedOnCompletion = false
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.infinity
        self.layer.add(rotation, forKey: nil)
    }
}
