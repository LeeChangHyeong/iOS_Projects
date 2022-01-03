import UIKit

class DetailViewController: UIViewController {
    
    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - imgView, nameLabel, bountylabel
    // > view들은 viewModel를 통해서 구성되기 ?
    
    
    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, BountyInfo 들
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
        
    }
    
    private func prepareAnimation(){
        // 화면의 크기만큼 조정해줘서 밖으로 보냄
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        // 우측에 있고 3배가 커져있고 180도 돌아가 있는 상태
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)

        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
        // 원래 자리가 0
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
//
////
////        UIView.animate(
////            // 진행 시간
////            withDuration: 0.3,
////            // 얼마나 있다가 실행 할 것인지
////            delay: 0.1,
////            // 애니매이션 옵션 (느리게 오다가 빨라지는지 빨리오다가 느려지는지 등)
////            options: .curveEaseIn,
////            animations: {
////            self.view.layoutIfNeeded()
////            },
////            // 애니메이션이 끝나고의 이벤트
////            completion: nil)
//
//
//    UIView.animate(withDuration: 0.5,
//                   delay: 0.2,
//                   usingSpringWithDamping: 0.6,
//                   initialSpringVelocity: 2,
//                   options: .allowUserInteraction,
//                   animations: {
//        // 레이아웃을 혹시 다시 해야하면 다시해라
//        self.view.layoutIfNeeded()
//        },
//                   completion: nil)
//
//
//    UIView.transition(with: imgView,
//                      duration: 0.3,
//                      options: .transitionFlipFromLeft,
//                      animations: nil,
//                      completion: nil)
        
        
        UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: .allowUserInteraction,
                           animations: {
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
              },
                           completion: nil)
        
        // 이름과 현상금 애니메이션을 따로 분리하여 딜레이를 주어 이름의 애니메이션이 먼저 나오고 현상금이 더 늦게 나온다
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: .allowUserInteraction,
                           animations: {
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha = 1
              },
                           completion: nil)
        
        
        UIView.transition(with: imgView,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)
        
    }
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
