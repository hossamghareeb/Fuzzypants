//
//  FoodDetailsViewController.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/5/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

enum NutritionType: Int{
    case TotalFats
    case Cholesterol
    case Sodium
    case Carbs
    case Protein
}

class FoodDetailsViewController: UIViewController {
    
    @IBOutlet weak var gramsPerServingLabel: UILabel!
    @IBOutlet weak var foodTitleLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var fiberLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    var selectedFood: Food?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = selectedFood?.title
        
        bindFoodInfoInUI()
    }
    
    
    func bindFoodInfoInUI(){
        self.foodTitleLabel.text = self.selectedFood?.title
        if let gramsPerServing = self.selectedFood?.gramsPerServing{
            self.gramsPerServingLabel.text = "Grams per serving \(gramsPerServing)"
        }
        if let calories = self.selectedFood?.nutritionFacts?.calories{
            self.caloriesLabel.text = "\(calories)"
        }
        if let protein = self.selectedFood?.nutritionFacts?.protein{
            self.proteinLabel.text = "\(protein)"
        }
        if let fiber = self.selectedFood?.nutritionFacts?.fiber{
            self.fiberLabel.text = "\(fiber)"
        }
    }
}

extension FoodDetailsViewController: UITableViewDataSource{


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let type = NutritionType(rawValue: section){
            switch type {
            case .TotalFats:
                return 2
            case .Carbs:
                return 2
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if let type = NutritionType(rawValue: indexPath.section){
            switch type {
            case .TotalFats:
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "Saturated Fat"
                    if let saturatedFats = self.selectedFood?.nutritionFacts?.saturatedFats{
                        cell?.detailTextLabel?.text = "\(saturatedFats)g"
                    }
                    
                    
                case 1:
                    cell?.textLabel?.text = "Unsaturated Fat"
                    if let unsatFats = self.selectedFood?.nutritionFacts?.unsaturatedFats{
                        cell?.detailTextLabel?.text = "\(unsatFats)g"
                    }
                    
                default:
                    return cell!
                }
            case .Carbs:
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "Dietary Fiber"
                    if let fiber = self.selectedFood?.nutritionFacts?.fiber{
                        cell?.detailTextLabel?.text = "\(fiber)g"
                    }
                    
                case 1:
                    cell?.textLabel?.text = "Sugar"
                    if let sugar = self.selectedFood?.nutritionFacts?.sugar{
                        cell?.detailTextLabel?.text = "\(sugar)g"
                    }
                    
                default:
                    return cell!
                }
            default:
                return cell!
            }
        }
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 5
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let type = NutritionType(rawValue: section){
            switch type {
            case .TotalFats:
                if let fats = self.selectedFood?.nutritionFacts?.fats{
                    return "Total Fat   (\(fats)g)"
                }
                
            case .Cholesterol:
                if let chol = self.selectedFood?.nutritionFacts?.cholesterol{
                    return "Cholesterol   (\(chol)g)"
                }
                
            case .Sodium:
                if let sodium = self.selectedFood?.nutritionFacts?.sodium{
                    return "Sodium    (\(sodium)g)"
                }
                
            case .Carbs:
                if let carbs = self.selectedFood?.nutritionFacts?.carbohydrates{
                    return "Total Carbs     (\(carbs)g)"
                }
                
            case .Protein:
                if let protein = self.selectedFood?.nutritionFacts?.protein{
                    return "Protein     (\(protein)g)"
                }
                
            }
        }
        return ""
    }
}
