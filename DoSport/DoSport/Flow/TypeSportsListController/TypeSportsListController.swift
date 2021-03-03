//
//  MainViewController.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//

import UIKit
import SnapKit

final class TypeSportsListController: UIViewController, UISearchBarDelegate {

    // MARK: - Outlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Виды спорта"
        label.font = Fonts.sfProRegular(size: 24)
        label.textColor = .white
        return label
    }()
    private lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar(frame: .zero)
        searchBar.textField?.delegate = self
        return searchBar
    }()
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Properties
    private var viewModel: TypeSportsListViewModelProtocol = TypeSportsListViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureUI()
        configureTapGesture()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Selectors actions
    @objc private func handleTapGesture() {
        searchBar.defaultColorSchemeSearchBar()
        view.endEditing(true)
    }
}

// MARK: - MainViewController
extension TypeSportsListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBar.changeColorSchemeSearchBar()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        viewModel.searchTypeOfSports(text: text, string: string) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension TypeSportsListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.returnCountOfItemsCollectionView()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeSportsViewCell.reuseId, for: indexPath) as! TypeSportsViewCell
        if viewModel.searching == true {
            cell.configureCell(typeOfSport: viewModel.fillteredTypeSports[indexPath.row])
        } else {
            cell.configureCell(typeOfSport: viewModel.countTypeSports[indexPath.row])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TypeSportsListController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension TypeSportsListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 32 - 16) / 3, height: (UIScreen.main.bounds.width - 32 - 16) / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

// MARK: - Cofigure UI
extension TypeSportsListController {
    private func configureUI() {
        view.backgroundColor = Colors.darkBlue
        collectionView.backgroundColor = Colors.darkBlue
        navigationController?.navigationBar.isHidden = true

        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(53)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(40)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(16)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view).offset(-88)
        }
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TypeSportsViewCell.self, forCellWithReuseIdentifier: TypeSportsViewCell.reuseId)
    }

    private func configureTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}
