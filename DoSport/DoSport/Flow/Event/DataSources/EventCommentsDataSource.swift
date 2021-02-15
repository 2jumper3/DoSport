//
//  EventCommentsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

final class EventCommentsDataSource: NSObject {
    
    var onDidTapReplyButton: ((TableViewCommentCell) -> Void)?
    var onDidScroll: (() -> Void)?
    
    var viewModels: [Message]
    
    init(viewModels: [Message] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - Actions

@objc
private extension EventCommentsDataSource {

    func handleReplyButton(_ button: UIButton) {
        var superview = button.superview
        
        while let view = superview, !(view is TableViewCommentCell) {
            superview = view.superview
        }
        
        guard let cell = superview as? TableViewCommentCell else {
            print("button is not contained in a CollectionViewMessageCell")
            return
        }
        
        onDidTapReplyButton?(cell)
    }
}

//MARK: - UITableViewDataSource

extension EventCommentsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: TableViewCommentCell = tableView.cell(forRowAt: indexPath)
        cell.memberNameLabel.text = viewModel.userName
//        cell.memberAvatarImageView.image =
//        cell.commentCreatedTimeLabel.text = viewModel.createdDate
        cell.commentTextLabel.text = viewModel.text
        cell.replyButton.addTarget(self, action: #selector(handleReplyButton), for: .touchUpInside)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension EventCommentsDataSource: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onDidScroll?()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.deviceSize == .small ? 65 : 80
    }
}

