//
//  UICollectionView+cellForRow.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func cell<T: ReusableCellIdentifiable>(forRowAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    func cell<T: ReusableCellIdentifiable>(forClass cellClass: T.Type, _ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    func registerReusableView<T: UICollectionReusableView>(_ type: T.Type) {
        register(
            type.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: type.description()
        )
    }
    
    func dequeReusabeView<T: UICollectionReusableView>(of kind: String, at indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.description(),
            for: indexPath
        ) as! T
    }
}

extension UICollectionViewCell: ReusableCellIdentifiable {}

extension ReusableCellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
