//
//  Post.swift
//  Fitness
//
//  Created by Namrata Akash on 24/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import Foundation
class Postmodel
{
var post_id:Int?
var post_title:String?
var post_description:String?
var category:String?
var date_time:String?
var image_list:String?
var video_list:String?
var post_fovourite:Int?
var post_like:Int?
var posted_id:Int?


    init(post_id:Int,post_title:String,post_description:String,category:String,date_time:String,image_list:String,video_list:String,posted_id:Int,post_favourite:Int,post_like:Int)
{
    self.post_id = post_id
    self.post_title = post_title
    self.post_description = post_description
    self.date_time = date_time
    self.category = category
    self.image_list = image_list
    self.posted_id = posted_id
    self.video_list = video_list
        self.post_fovourite = post_favourite
        self.post_like = post_like
}
    init(data:String) {
        self.image_list = data
    }
}
