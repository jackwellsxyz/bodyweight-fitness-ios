import UIKit

class DashboardDoubleItemCell: UITableViewCell {
    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var rightTitle: UILabel!
    
    @IBOutlet weak var leftView: ActionView!
    @IBOutlet weak var rightView: ActionView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var dashboardViewController: DashboardViewController?
    
    fileprivate var _leftExercise: Exercise? = nil
    var leftExercise: Exercise? {
        get {
            return _leftExercise
        }
        
        set {
            self._leftExercise = newValue
            
            if let exercise = newValue {
                if (exercise.isTimed()) {
                    self.leftButton.setImage(UIImage(named: "timed"), for: UIControl.State())
                } else {
                    self.leftButton.setImage(UIImage(named: "weighted"), for: UIControl.State())
                }
            }
        }
    }
    
    fileprivate var _rightExercise: Exercise? = nil
    var rightExercise: Exercise? {
        get {
            return _rightExercise
        }
        
        set {
            self._rightExercise = newValue
            
            if let exercise = newValue {
                if (exercise.isTimed()) {
                    self.rightButton.setImage(UIImage(named: "timed"), for: UIControl.State())
                } else {
                    self.rightButton.setImage(UIImage(named: "weighted"), for: UIControl.State())
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leftView.layer.cornerRadius = self.leftView.frame.size.width / 2
        self.leftView.clipsToBounds = true
        
        self.rightView.layer.cornerRadius = self.rightView.frame.size.width / 2
        self.rightView.clipsToBounds = true
        
        self.leftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DashboardDoubleItemCell.onLeftClick(_:))))
        self.rightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DashboardDoubleItemCell.onRightClick(_:))))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onLeftClick(_ sender: UITapGestureRecognizer) {
        self.dashboardViewController?.dismissWithExercise(leftExercise!)
    }
    
    @objc func onRightClick(_ sender: UITapGestureRecognizer) {
        self.dashboardViewController?.dismissWithExercise(rightExercise!)
    }
}
