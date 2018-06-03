//
//  ViewController.swift
//  MemoryGame

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var imgs : [UIImage] = [
        UIImage(named: "X")!,
        UIImage(named: "fish")!,
        UIImage(named: "human")!,
        UIImage(named: "Smiley")!,
        UIImage(named: "O")!,
        UIImage(named: "apple")!,
        UIImage(named: "monkey")!,
        UIImage(named: "orange")!,
        UIImage(named: "dolphin")!
    ]
   
    func setButtonTag(){
        buttons[0].tag = 1
        buttons[1].tag = 2
        buttons[2].tag = 3
        buttons[3].tag = 4
        buttons[4].tag = 5
        buttons[5].tag = 6
        buttons[6].tag = 7
        buttons[7].tag = 8
        buttons[8].tag = 1
        buttons[9].tag = 2
        buttons[10].tag = 3
        buttons[11].tag = 4
        buttons[12].tag = 5
        buttons[13].tag = 6
        buttons[14].tag = 7
        buttons[15].tag = 8
    }
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func resetBoard(_ sender: UIButton) {
        
        score.text = "0"
        
        //generate an array of nums with values from zero to number of buttons
        var nums = Array(0..<buttons.count)
        
        //loop on the array as long as it still has some numbers to choose from
        while nums.count > 0 {
            
            //choose two random numbers - these will be indices for numbers in the num array
            var i = Int(arc4random_uniform(UInt32(nums.count)))
            var j = Int(arc4random_uniform(UInt32(nums.count)))
            
            //these numbers need to be different
            if i != j {
                
                //remove them from the nums array - so we do not get them again
                if i > j {
                    i = nums.remove(at: i)
                    j = nums.remove(at: j)
                    
                } else {
                    j = nums.remove(at : j)
                    i = nums.remove(at : i)
                }
                
                //get a random number for the tag to be used to reset the images
                let random  = Int(arc4random_uniform(UInt32(imgs.count - 1)) + 1)
                
                //set both buttons to the same random
                buttons[i].setImage(imgs[0], for: .normal)
                buttons[i].setImage(imgs[0], for: .normal)
            }
        }
        
        setButtonTag()
    }
    
    
   var lastButton : UIButton?
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        
        if sender.tag == -1 {return}
        
        sender.setImage(imgs[sender.tag], for: .normal)
        
        //first touch
        if lastButton == nil {
            lastButton = sender
        }
        //match found
        else if lastButton != nil && sender.tag == lastButton!.tag {
            score.text = "\(Int(score.text!)! + 1)"
            
            sender.tag = -1
            lastButton!.tag = -1
            lastButton = nil
        }
        else{
            sender.setImage(imgs[0], for: .normal)
            lastButton!.setImage(imgs[0], for: .normal)
            lastButton = nil
        }
    }
    
}

