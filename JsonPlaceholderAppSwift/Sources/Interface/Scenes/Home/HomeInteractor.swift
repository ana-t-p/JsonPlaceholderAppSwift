//
//  HomeInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic
{
  func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore
{
  //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Home.Something.Request)
  {
    worker = HomeWorker()
    worker?.doSomeWork()
    
    let response = Home.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
