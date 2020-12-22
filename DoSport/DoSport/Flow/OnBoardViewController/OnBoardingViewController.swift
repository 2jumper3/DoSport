//
//  OnBoardingViewController.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - Properties
    var pages: [OnBoardingModel] = [
        OnBoardingModel(image:Icons.onboardingIcons.firstIcon, textHeader: Texts.onBoardingText.headers.firstSlideText, textDescription: Texts.onBoardingText.description.firstSlideText),
        OnBoardingModel(image: Icons.onboardingIcons.secondIcon, textHeader: Texts.onBoardingText.headers.secondSlideText, textDescription: Texts.onBoardingText.description.secondSlideText),
        OnBoardingModel(image: Icons.onboardingIcons.thirdIcon, textHeader: Texts.onBoardingText.headers.thirdSlideText, textDescription: Texts.onBoardingText.description.thirdSlideText),
        OnBoardingModel(image: Icons.onboardingIcons.fourthIcon, textHeader: Texts.onBoardingText.headers.fourthSlideText, textDescription: Texts.onBoardingText.description.fourthSlideText)
    ]

    // MARK: - Outlets
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var pageControl = FlexiblePageControl()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        setupBottomControls()
        pageControlSetup()
    }
    override func viewDidLayoutSubviews() {

    }
    
    func pageControlSetup() {
        pageControl.numberOfPages = pages.count
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnBoardingViewCell.reuseId,
            for: indexPath) as? OnBoardingViewCell else {
            return UICollectionViewCell()
        }

        let page = pages[indexPath.row]
        cell.page = page

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.setProgress(contentOffsetX: collectionView.contentOffset.x, pageWidth: collectionView.bounds.width)
    }
}

// MARK: - SetupUI
extension OnBoardingViewController {

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnBoardingViewCell.self, forCellWithReuseIdentifier: OnBoardingViewCell.reuseId)
    }

    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    private func setupBottomControls() {
        pageControl.center = CGPoint(x: view.center.x, y: view.frame.maxY - 208)
        view.addSubview(pageControl)

    }
}
