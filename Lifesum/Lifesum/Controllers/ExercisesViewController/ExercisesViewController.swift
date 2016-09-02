//
//  ExercisesViewController.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController {
    
    @IBOutlet weak var exercisesSearchBar: UISearchBar!
    @IBOutlet weak var exercisesTableView: UITableView!
    var exercises = [Exercise](){
        didSet{
            self.exercisesTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Exercises"
        self.exercises = ExercisesDataLoader().allRecords() as! [Exercise]
    }

    func filterExercisesWithKeyword(keyword: String){
        self.exercises = ExercisesDataLoader().exercisesWithKeyword(keyword) as! [Exercise]
    }
}


// MARK: - UITableViewDataSource -
extension ExercisesViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ExerciseTableViewCell
        if let img = UIImage(named: "Exercise\(indexPath.row % 4)"){
            cell.exerciseImageView.image = img
        }
        let exercise = exercises[indexPath.row]
        cell.exerciseNameLabel.text = exercise.title
        return cell
    }
    
}

// MARK: - UIScrollViewDelegate -

extension ExercisesViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension ExercisesViewController: UISearchBarDelegate{
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterExercisesWithKeyword(searchText)
    }
}

