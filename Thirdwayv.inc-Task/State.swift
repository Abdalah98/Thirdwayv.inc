//
//  State.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//
import Foundation

 /// State  say me what viewmodel do it do loading activityIndicator or show error 
public enum State {
    case loading
    case error
    case empty
    case populated
}
