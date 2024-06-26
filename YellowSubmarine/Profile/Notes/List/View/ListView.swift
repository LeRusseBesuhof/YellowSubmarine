import UIKit

protocol NoteViewProtocol : UIImageView {
    var noteMockData : [Note] { get set }
}

final class NoteView: UIImageView {
    
    private lazy var titleLabel : UILabel = AppUI.createLabel(
        withText: "Your notes",
        textColor: .white,
        font: .getMeriendaFont(fontType: .bold, fontSize: 32),
        alignment: .center
    )
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
        }
    }()
    
    internal var noteMockData : [Note] = []
    
    private lazy var collectionView : UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = canvasView.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        $0.isPagingEnabled = true
        $0.dataSource = self
        $0.register(NoteViewCell.self, forCellWithReuseIdentifier: NoteViewCell.reuseID)
        return $0
    }(UICollectionView(frame: canvasView.frame, collectionViewLayout: UICollectionViewLayout()))
    
//    private lazy var tableView : UITableView = {
//        .config(view: UITableView()) {
//            $0.dataSource = self
//            $0.register(UITableViewCell.self, forCellReuseIdentifier: "note")
//        }
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension NoteView {
    private func setUpView() {
        image = .backMerged
        isUserInteractionEnabled = true
        
        addSubviews(titleLabel, canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            canvasView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            canvasView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
        ])
    }
}

extension NoteView : NoteViewProtocol {
    
}

extension NoteView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = noteMockData[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteViewCell.reuseID, for: indexPath) as? NoteViewCell else { return UICollectionViewCell() }
        
        cell.setUpCell()
        return cell
    }
}

extension NoteView : UICollectionViewDelegate {
    
}

//extension NoteView : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UITableViewCell()
//    }
//    
//}
