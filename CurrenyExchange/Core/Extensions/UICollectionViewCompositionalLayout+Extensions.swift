//
//  UICollectionViewCompositionalLayout+Extensions.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import Foundation
import UIKit

extension UICollectionViewCompositionalLayout {

    public static var gridLayout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(3)),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(24)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let layout = UICollectionViewCompositionalLayout { index, _ in
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 8)
            if index > 0 {
                section.boundarySupplementaryItems = [sectionHeader]
            }
            return section
        }
        return layout
    }

    public static func listLayout(backgroundColor: UIColor? = nil) -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
        configuration.backgroundColor = backgroundColor
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }

}
