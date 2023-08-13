//
//  UIViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import Foundation
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

#if DEBUG
extension UICollectionViewCell {
    
    struct Preview: UIViewRepresentable {
        let collectionviewCell: UICollectionViewCell
        // UICollectionViewCell을 SwiftUI 뷰로 wrapping하는 프로토콜 구현
        func makeUIView(context: Context) -> UICollectionViewCell {
            return collectionviewCell
        }

        func updateUIView(_ uiView: UICollectionViewCell, context: Context) {
            // 업데이트 논리를 구현 (필요하다면)
        }
    }
    
    func toPreview() -> some View {
        Preview(collectionviewCell: self)
    }
}
#endif
