//
//  PullRequestsViewController.swift
//  NaviAssignment
//
//  Created by Athul Sai on 21/07/22.
//

import UIKit

class PullRequestsViewController: UIViewController {

    let viewModel: PullRequestsViewModel

    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var dataSource = makeDataSource()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        return indicator
    }()

    init?(coder: NSCoder, viewModel: PullRequestsViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a viewModel.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Closed Pull Requests"
        navigationController?.navigationBar.topItem?.prompt = "github.com/twostraws/wwdc"
        collectionView.dataSource = dataSource
        collectionView.contentInset.bottom = 50 // Required for loading indicator
        registerCell()
        setupListLayout()
        setupLoadingIndicator()
        getData()
    }

    private func registerCell() {
        collectionView.register(UINib(nibName: String(describing: PullRequestCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PullRequestCollectionViewCell.self))
    }

    private func setupLoadingIndicator() {
        let layoutGuide = view.safeAreaLayoutGuide
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            layoutGuide.centerXAnchor.constraint(equalTo: loadingIndicator.centerXAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 10)
        ])
    }

    private func setupListLayout(withEstimatedHeight estimatedHeight: CGFloat = 120) {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let verticalInset: CGFloat = 4
            let horizontalInset: CGFloat = 16

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: verticalInset, leading: horizontalInset, bottom: verticalInset, trailing: horizontalInset)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(4)

            let section = NSCollectionLayoutSection(group: group)

            return UICollectionViewCompositionalLayout(section: section)
        }()

        collectionView.collectionViewLayout = compositionalLayout
    }

    private func getData() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }

        viewModel.getPullRequests(completionHandler: { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    let alertVC = UIAlertController(title: error.getFormattedError(message: error.localizedDescription), message: nil, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                        self?.getData()
                    }))
                    alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    self.present(alertVC, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.update(with: self.viewModel.allPullRequests)
                }
            }
        })
    }
}

extension PullRequestsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.allPullRequests.count - 1 {
            viewModel.page += 1
            getData()
        }
    }
}

extension PullRequestsViewController {
    enum Section: CaseIterable {
        case main
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, PullRequestsResponse> {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, result in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PullRequestCollectionViewCell.self), for: indexPath) as? PullRequestCollectionViewCell else {
                    return UICollectionViewCell()
                }

                cell.setupCell(with: result)
                return cell
            }
        )
    }

    func update(with result: [PullRequestsResponse], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PullRequestsResponse>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(result, toSection: .main)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}


