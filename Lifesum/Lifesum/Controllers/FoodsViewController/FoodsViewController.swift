//
//  FoodsViewController.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/5/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class FoodsViewController: UIViewController {
    
    @IBOutlet weak var foodsTableView: UITableView!
    var selectedCategory: Category?
    
    lazy var foods: [Food] = {
        if let set = self.selectedCategory!.foods{
            return set.allObjects as! [Food]
        }
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.selectedCategory?.title
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardConstants.SegueIdOpenFoodDetails{
            
            let foodDetailsViewController = segue.destinationViewController as! FoodDetailsViewController
            if let indexPath = self.foodsTableView.indexPathForSelectedRow{
                let food = self.foods[indexPath.row]
                foodDetailsViewController.selectedFood = food
            }
            
        }
    }
}


// MARK: - UITableViewDataSource -
extension FoodsViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.foods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! FoodTableViewCell
        if let img = UIImage(named: "Cat\(indexPath.row % 13)"){
            cell.foodImageView.image = img
        }
        let food = self.foods[indexPath.row]
        cell.foodNameLabel.text = food.title
        return cell
    }
    
}