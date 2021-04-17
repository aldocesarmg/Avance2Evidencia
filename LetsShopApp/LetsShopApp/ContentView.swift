//
//  ContentView.swift
//  LetsShopApp
//
//  Created by user183935 on 4/16/21.
//  Copyright © 2021 aldocesarmg. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Product.entity(), sortDescriptors: []) var products: FetchedResults<Product>
    @State private var newProductName = ""
    @State private var newProductQuantity = ""
    
    var body: some View {
        VStack{
            TextField("Coloca el producto", text: self.$newProductName).multilineTextAlignment(.center)
            TextField("Coloca la cantidad", text: self.$newProductQuantity).multilineTextAlignment(.center)
            Button("Guardar") {self.save()}
            List{
            ForEach(products, id: \.self) {
                aproduct in Text("\(aproduct.quantity)  \(aproduct.name!)")
            }.onDelete{ indexSet in
                for index in indexSet {
                    self.context.delete(self.products[index])
                    try? self.context.save()
                }
                }
            }
        }
    }
    
    func save() {
        let newProduct = Product(context: self.context)
        newProduct.name = newProductName
        newProduct.quantity = Int16(newProductQuantity) ?? 0
        
        newProductName = ""
        newProductQuantity = ""
        
        try? self.context.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
