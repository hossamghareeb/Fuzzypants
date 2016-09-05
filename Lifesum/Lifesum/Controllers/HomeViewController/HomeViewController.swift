//
//  HomeViewController.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var exercisesView: UIView!
    @IBOutlet weak var foodsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleShowingViews(false)
        loadDataFromDatabase()
    }
    
    private func toggleShowingViews(toShow: Bool){
        self.exercisesView.hidden = !toShow
        self.foodsView.hidden = !toShow
    }
    
    private func loadDataFromDatabase(){
        
        DataManager.loadAllData {
            let manager = ExercisesDataLoader()
            _ = manager.allRecords() as! [Exercise]
            
            let catgoriesManager = CategoryDataLoader()
            _ = catgoriesManager.allRecords() as! [Category]
            
            self.toggleShowingViews(true)
        }
    }
    
    @IBAction func didClickOnExercises(sender: AnyObject) {
        self.performSegueWithIdentifier(StoryboardConstants.SegueIdOpenExercises, sender: self)
    }
    

    @IBAction func didClickOnFoods(sender: AnyObject) {
        self.performSegueWithIdentifier(StoryboardConstants.SegueIdOpenFoodCategories, sender: self)
    }
}
