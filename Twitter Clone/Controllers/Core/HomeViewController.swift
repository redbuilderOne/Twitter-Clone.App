//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 26.10.2022.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {

    private var viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    private func configureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "twitterLogo")

        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView

        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }

    @objc func didTapProfile() {
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let viewController = UINavigationController.init(rootViewController: OnboardingViewController())
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: false)
        }
    }

    func completeUserOnboarding() {
        let viewController = ProfileDataFormViewController()
        present(viewController, animated: true)
    }

    func bindViews() {
        viewModel.$user
            .sink { [weak self] user in
                guard let user = user else { return }
                if !user.isUserOnboarded {
                    self?.completeUserOnboarding()
                }
            }
            .store(in: &subscriptions)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        bindViews()
    }

    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retreiveUser()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }

}

extension HomeViewController: TweetTableViewCellDelegate {

    func tweetTableViewCellDidTapReply() {
        print("Reply")
    }

    func tweetTableViewCellDidTapRetweet() {
        print("Retweet")
    }

    func tweetTableViewCellDidTapLike() {
        print("Like")
    }

    func tweetTableViewCellDidTapShare() {
        print("Share")
    }

}
