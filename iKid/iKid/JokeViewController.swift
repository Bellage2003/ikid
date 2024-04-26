//
//  JokeViewController.swift
//  iKid
//
//  Created by 小戈 on 2024/4/25.
//

import UIKit

class JokeViewController: UIViewController {
    // Jokes are now categorized in a dictionary
    var jokes: [String: [(String, String)]] = [
        "Good": [
            ("What do you call fake spaghetti?", "An impasta!")
        ],
        "Pun": [
            ("I would avoid the sushi if I were you.", "It’s a little fishy.")
        ],
        "Dad": [
            ("Can February March?", "No, but April May!")
        ]
    ]
    
    var currentCategory: String
    var currentJokeIndex = 0
    var isShowingPunchline = false

    let jokeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        return button
    }()

    // Initialize with a category
    init(category: String) {
        self.currentCategory = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        showJoke()
    }

    private func setupLayout() {
        view.backgroundColor = .white  // Ensure background color is set for visibility
        view.addSubview(jokeLabel)
        view.addSubview(nextButton)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func nextTapped() {
        if isShowingPunchline {
            currentJokeIndex = (currentJokeIndex + 1) % jokes[currentCategory]!.count
            showJoke()
        } else {
            showPunchline()
        }
    }

    private func showJoke() {
        jokeLabel.text = jokes[currentCategory]![currentJokeIndex].0
        isShowingPunchline = false
    }

    private func showPunchline() {
        jokeLabel.text = jokes[currentCategory]![currentJokeIndex].1
        isShowingPunchline = true
    }
}



