let THERESOLD_MARGIN = (UIScreen.main.bounds.size.width/2) * 0.5
let SCALE_STRENGTH : CGFloat = 4
let SCALE_RANGE : CGFloat = 0.90

import UIKit

class SwipeCard: UIView {
    
    private var xCenter: CGFloat = 0.0
    private var yCenter: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    private var imageViewStatus = UIImageView()
    private var overLayImage = UIImageView()
    private var isLiked = false
    
    weak var delegate: SwipeCardDelegate?
    
    public init(frame: CGRect, value: String) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView(at: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup ImageView
    func setupView(at value:String) {
        //layer.cornerRadius = 20
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.5, height: 3)
        layer.shadowColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        layer.masksToBounds = true
        
        //이거 false로 하면 첫번째 카드만 반응함
        isUserInteractionEnabled = true
        originalPoint = center
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
        
        let imageURL = URL(string: value)
        overLayImage = UIImageView(frame:bounds)
        overLayImage.alpha = 0
        
        DispatchQueue.main.async { [weak self] in
            ImageNetworkManager.shared.getImageByCache(imageURL: imageURL!) { image, error in
                self?.overLayImage.image = image
                self?.addSubview(self?.overLayImage ?? .init())
            }
        }
    }
    
    //여기서 컨트롤 할 수 있어야 카드의 움직임을 제한할 수 있습니다.
    @objc func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        
        switch gestureRecognizer.state {
        case .began:
            originalPoint = self.center
        case .changed:
            let rotationStrength = min( xCenter / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8*rotationStrength
            let scale = max(1 - abs(rotationStrength) / SCALE_STRENGTH, SCALE_RANGE)
            center = CGPoint(x: originalPoint.x + xCenter, y: originalPoint.y + yCenter)
            
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            updateOverlay(xCenter)
            
        case .ended:
            afterSwipeAction()
        case .possible, .cancelled, .failed:
            break
        }
        
    }
    
    //좋아요 되는동안 바뀌는 부분
    func updateOverlay(_ distance: CGFloat) {
        
        overLayImage.image = distance > 0 ? #imageLiteral(resourceName: "imgMainSwipeO") : #imageLiteral(resourceName: "imgMainSwipeX")
        
        imageViewStatus.alpha = min(abs(distance) / 100, 1)
        
        overLayImage.alpha = min(abs(distance) / 100, 1)
    }
    
    //스와이프 끝남
    func afterSwipeAction() {
        if xCenter > THERESOLD_MARGIN {
            rightAction()
        } else if xCenter < -THERESOLD_MARGIN {
            leftAction()
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.imageViewStatus.alpha = 0
                self.overLayImage.alpha = 0
            })
        }
    }
    
    //오른쪽 스와이프 , 좋아요
    func rightAction() {
        let finishPoint = CGPoint(x: frame.size.width * 2, y: 2 * yCenter + originalPoint.y)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.center = finishPoint
            self.layoutIfNeeded()
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        isLiked = true
        delegate?.cardGoesRight(card: self)
    }
    
    //왼쪽 스와이프
    func leftAction() {
        let finishPoint = CGPoint(x: -frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
            self.layoutIfNeeded()
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        isLiked = false
        delegate?.cardGoesLeft(card: self)
    }
    
    /// Right Like Button
    func rightClickAction() {
        overLayImage.image = #imageLiteral(resourceName: "imgMainSwipeO")
        let finishPoint = CGPoint(x: center.x + frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: 1)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
            self.layoutIfNeeded()
        }, completion: {(_ complete: Bool) -> Void in
            self.removeFromSuperview()
        })
        
        isLiked = true
        delegate?.cardGoesRight(card: self)
    }
    
    /// Left Dislike Button
    func leftClickAction() {
        overLayImage.image = #imageLiteral(resourceName: "imgMainSwipeX")
        let finishPoint = CGPoint(x: center.x - frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 1.0
        
        UIView.animate(withDuration: 0.15, animations: {() -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: -1)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
            self.layoutIfNeeded()
        }, completion: {(_ complete: Bool) -> Void in
            self.removeFromSuperview()
        })
        
        isLiked = false
        delegate?.cardGoesLeft(card: self)
    }
    
}


