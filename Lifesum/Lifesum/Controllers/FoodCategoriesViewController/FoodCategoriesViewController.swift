//
//  FoodCategoriesViewController.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/4/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class FoodCategoriesViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var categories = [Category](){
        didSet{
            categoriesCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        self.title = "Categories"
        self.categories = CategoryDataLoader().allRecords() as! [Category]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryboardConstants.SegueIdOpenFoods {
            
            if let indexPath = self.categoriesCollectionView.indexPathsForSelectedItems()?.first{
                let category = self.categories[indexPath.item]
                let foodsViewController = segue.destinationViewController as! FoodsViewController
                foodsViewController.selectedCategory = category
            }
            
        }
    }

}

extension FoodCategoriesViewController: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FoodCategoryCollectionCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.blueColor()
        let category = self.categories[indexPath.item]
        cell.categoryLabel.text = category.title
        if let count = category.foods?.count{
            cell.recipesCountLabel.text = "\(count) recipes"
        }
        if let img = UIImage(named: "Cat\(indexPath.item % 13)"){
            cell.categoryImageView.image = img
        }
        
        return cell
    }
}

extension FoodCategoriesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let numberOfItemsPerRow = 3
        let spacingBetweenRows: CGFloat = 5.0
        let width = CGRectGetWidth(collectionView.frame) - CGFloat(numberOfItemsPerRow + 1) * spacingBetweenRows
        let cellWidth = width / CGFloat(numberOfItemsPerRow)
        return CGSizeMake(cellWidth, cellWidth)
    }
}
