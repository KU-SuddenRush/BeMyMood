//
//  TextEditorViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/15.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class TextEditorViewController: UIViewController {

    weak var delegate: TextEditorDelegate?
    
    var alignmentOptions: [NSTextAlignment] = [.left, .center, .right]
    let alignmentIcon : [UIImage?] = [UIImage(named: "left"),UIImage(named: "center"),UIImage(named: "right")]
    var currentAlignmentIndex = 1
    
    var buttonStartingY: CGFloat = 0.0
    var keyboardHeight: CGFloat = 0.0

    //MARK: - UIComponents
    
    let closeBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let textView = UITextView().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = ""
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.tintColor = .white
        $0.sizeToFit()
    }
    
    let textAlignmentBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "center")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let textColorBtn = UIButton().then{
        $0.setImage(UIImage.colorIcon[0], for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let textSizeBar = UIImageView().then{
        $0.image = UIImage(named: "textSizeBar")
        $0.contentMode = .scaleAspectFit
    }
    
    let textSizeEditIcon = UIImageView().then{
        $0.image = UIImage(named: "sizeButton")
        $0.contentMode = .scaleAspectFit
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 8
        $0.layer.masksToBounds = false
        $0.isUserInteractionEnabled = true
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#000000", alpha: 0.6)
        
        hierarchy()
        layout()
        
        self.textView.delegate = self
        
        //Button
        self.closeBtn.addTarget(self, action: #selector(closeBtnDidTab), for: .touchUpInside)
        
        // 드래그 제스처 설정
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        textSizeEditIcon.addGestureRecognizer(panGesture)
        
        // 키보드 나타남 이벤트에 대한 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 사라짐 이벤트에 대한 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textAlignmentBtn.addTarget(self, action: #selector(changeAlignment), for: .touchUpInside)
    }
    
    deinit {
        // 옵저버 해제
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TextView에 포커스를 주어 키보드를 자동으로 띄우기
        textView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let size = CGSize(width: textView.frame.width, height: textView.frame.height)
        let newSize = textView.sizeThatFits(size)

        // Update the existing height constraint
        for constraint in textView.constraints {
            if constraint.firstAttribute == .height {
                constraint.constant = newSize.height
                break
            }
        }
        textView.layoutIfNeeded()
    }
    
    @objc func closeBtnDidTab() {
        doneButtonTapped()
    }
    
    @objc func changeAlignment() {
        // 순환하도록 정렬을 변경
        currentAlignmentIndex = (currentAlignmentIndex + 1) % alignmentOptions.count
        let newAlignment = alignmentOptions[currentAlignmentIndex]
        textView.textAlignment = newAlignment
        textAlignmentBtn.setImage(alignmentIcon[currentAlignmentIndex]?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
           guard let userInfo = notification.userInfo,
                 let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
               return
           }
           
           // 키보드의 높이를 구함
           keyboardHeight = keyboardFrame.size.height
           
           // 텍스트 뷰의 현재 위치와 높이
           let textViewY = textView.frame.origin.y
           let textViewHeight = textView.frame.size.height
       }
    
    // 키보드가 사라질 때 호출되는 메서드
    @objc func keyboardWillHide(_ notification: Notification) {
        // 텍스트 뷰의 위치를 원래대로 복원
        self.view.frame.origin.y = 0
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            buttonStartingY = textSizeEditIcon.center.y
        } else if gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            let newButtonY = buttonStartingY + translation.y
            
            // 버튼의 X 좌표를 프로그레스 바 범위 내에서 제한하여 움직임
            let buttonHalfHeight = textSizeEditIcon.frame.size.height / 2.0
            let maxY = textSizeBar.frame.origin.y + textSizeBar.frame.size.height - buttonHalfHeight
            let minY = textSizeBar.frame.origin.y + buttonHalfHeight
            textSizeEditIcon.center.y = max(minY, min(maxY, newButtonY))
            
            // 버튼 위치에 따라 텍스트 크기 조절
            adjustTextSizeBasedOnButtonPosition()
        }
    }
    
    private func adjustTextSizeBasedOnButtonPosition() {
        let buttonY = textSizeEditIcon.frame.origin.y
        let textViewWidth = textView.frame.size.width
        let relativeY = 1.0 - (buttonY / textViewWidth)
        
        // relativeX 값을 이용하여 적절한 폰트 크기 계산
        let newSize = CGFloat(relativeY) * 30.0 + 20.0 // 최소 10부터 최대 40까지
        textView.font = UIFont.systemFont(ofSize: newSize, weight: .bold)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    func doneButtonTapped() {
        guard let enteredText = textView.text else {
            return
        }
        
        let style = TextStyle(alignment: alignmentOptions[currentAlignmentIndex], font: textView.font ?? UIFont.systemFont(ofSize: 16,weight: .bold),
                              textColor: textView.textColor ?? .white)
        
        delegate?.didAddText(enteredText, withStyle: style)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TextViewDelegate
extension TextEditorViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // Calculate the maximum content offset that prevents the text view from being hidden by the keyboard
        let maxContentOffset = CGPoint(x: 0, y: max(0, textView.contentSize.height - textView.bounds.size.height + textView.contentInset.bottom))
        
        // Calculate the keyboard's y position
        let keyboardY = self.view.frame.size.height - self.keyboardHeight
        
        // Calculate the top offset to adjust the text view's position
        let topOffset = max(0, textView.frame.origin.y + textView.contentInset.top - (keyboardY - maxContentOffset.y))
        
        // Adjust the content offset if necessary to keep the cursor visible above the keyboard
        if textView.contentOffset.y > maxContentOffset.y && topOffset > 0 {
            textView.contentOffset.y -= topOffset
        }
    }
}

struct TextEditorVCPreView:PreviewProvider {
    static var previews: some View {
        TextEditorViewController().toPreview()
    }
}
