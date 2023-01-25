//
//  ViewController.swift
//  Tragaperras
//
//  Created by Usuario on 17/01/2023.
//  Copyright © 2023 IvanMulero. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var iv1: UIImageView!
    @IBOutlet weak var iv2: UIImageView!
    @IBOutlet weak var iv3: UIImageView!
    var fichas:Int = 100
    @IBOutlet weak var lblfichas: UILabel!
    
    @IBAction func InsertFicha(_ sender: UIButton) {
    }
    var ivdados:[UIImageView]!
    var player : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        lblfichas.text = "\(fichas)"
        loadAnimation()
        loadSound()
    }

    @IBAction func InsertaFichas(_ sender: UIButton) {
        fichas += 100
         lblfichas.text = "\(fichas)"
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
      
        iv1.startAnimating()
               iv2.startAnimating()
               iv3.startAnimating()
               player.play()
               DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                   self.iv1.stopAnimating()
                    self.iv2.stopAnimating()
                    self.iv3.stopAnimating()
                   self.inventaypinta()
                   self.player.stop()

           })
        if fichas > 0 {
            sender.isEnabled = true
        }
        if fichas <= 0 {
          sender.isEnabled = false
        }
    }
    func loadAnimation() {
        iv1.animationImages = [UIImage]()
         iv2.animationImages = [UIImage]()
         iv3.animationImages = [UIImage]()
        for index in 0 ..< 6 {
            let frameName = "\(index)"
            iv1.animationImages?.append(UIImage(named: frameName)!)
            iv2.animationImages?.append(UIImage(named: frameName)!)
            iv3.animationImages?.append(UIImage(named: frameName)!)
        }
        iv1.animationDuration = 0.5
    }
    func loadSound() {
           do {
               // desenvolviendo una variable (unwrapping var)
               if let fileURL = Bundle.main.path(forResource: "maquina", ofType:"mp3") {
                   player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
               } else {
                   print("No existe fichero de sonido")
               }
           } catch let error {
               print("Error en la carga del sonido \(error.localizedDescription)")
           }
           
       }
    func inventaypinta() {
        let n = Int(arc4random() % 6);
         let n1 = Int(arc4random() % 6);
         let n2 = Int(arc4random() % 6);
        
        let image = UIImage(named: "\(n)")
          let image1 = UIImage(named: "\(n1)")
          let image2 = UIImage(named: "\(n2)")
        
        if n == n1 && n == n2 && n1 == n2 {
            let alert = UIAlertController(title: "Fin", message:
                "Has ganado 10 fichas", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default,handler: nil))
            self.present(alert, animated: true, completion: nil)

            fichas += 10
            lblfichas.text = "\(fichas)"
        }else{
            if fichas > 0 {
                fichas -= 10
                lblfichas.text = "\(fichas)"
            }
           
            if fichas == 0 {
              let alert = UIAlertController(title: "Fin", message:
                    "Has perdido inserta mas monedas", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default,handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        
    }
        iv1.image=image
        iv2.image=image1
        iv3.image=image2
    }
}

