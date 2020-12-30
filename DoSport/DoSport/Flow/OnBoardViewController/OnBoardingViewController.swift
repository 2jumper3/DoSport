//
//  OnBoardingViewController.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    var coordinator: OnBoardingCoordinator?

    // MARK: - Properties
    var pages: [OnBoardingModel] = [
        OnBoardingModel(image:Icons.OnboardingIcons.firstIcon, textHeader: Texts.OnBoardingText.headers.firstSlideText, textDescription: Texts.OnBoardingText.Description.firstSlideText),
        OnBoardingModel(image: Icons.OnboardingIcons.secondIcon, textHeader: Texts.OnBoardingText.headers.secondSlideText, textDescription: Texts.OnBoardingText.Description.secondSlideText),
        OnBoardingModel(image: Icons.OnboardingIcons.thirdIcon, textHeader: Texts.OnBoardingText.headers.thirdSlideText, textDescription: Texts.OnBoardingText.Description.thirdSlideText),
        OnBoardingModel(image: Icons.OnboardingIcons.fourthIcon, textHeader: Texts.OnBoardingText.headers.fourthSlideText, textDescription: Texts.OnBoardingText.Description.fourthSlideText)
    ]

    // MARK: - Outlets
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var pageControl = FlexiblePageControl()
    
    //MARK: - UI
    private lazy var confirmButton: CommonButton = {
        $0.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        $0.backgroundColor = Colors.darkBlue
        return $0
    }(CommonButton(title: "OK", state: .normal))

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        setupBottomControls()
        pageControlSetup()
    }

    func pageControlSetup() {
        pageControl.numberOfPages = pages.count
    }
    //MARK: - Actions

    @objc func confirmButtonTapped() {
        let vc = MainMenuTabController()
        navigationController?.pushViewController(vc, animated: true)
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
        let currentPage = Int(round(collectionView.contentOffset.x / collectionView.bounds.width))
        if currentPage == 3 {
            confirmButton.isHidden = false
        } else {
            confirmButton.isHidden = true
        }
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
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        view.addSubview(confirmButton)
        confirmButton.isHidden = true
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-58)
            make.right.equalTo(view.snp.right).offset(-24)
            make.left.equalTo(view.snp.left).offset(24)
            make.height.equalTo(48)
        }
    }

    private func setupBottomControls() {
        pageControl.center = CGPoint(x: view.center.x, y: view.frame.maxY - 208)
        view.addSubview(pageControl)
    }
}
