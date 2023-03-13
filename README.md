# Finden


## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app is used to look for events/free stuff on campus.

<img src="http://g.recordit.co/P6LPTYo5js.gif">

### App Evaluation
- **Category:** Social/Shopping
- **Mobile:** Usage of map, camera, & location
- **Story:** This app would be very convenient and easy to use for UCSD students because it would put all events and free stuff near UCSD into a single app, and there's also a map for students to look at if they want to know where the events are.
- **Market:** UCSD students, and could be applied to a bigger scale in the future.
- **Habit:** Users would check often (once a day or more) to see if there are new events/free stuff. Users could also make new posts to notify others.
- **Scope:** The app started as a way to find events/free stuff on a map. It expanded to include taking images of the event or items and making your own post. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can register for an account
- [x] User can log in
- [x] User can log out
- [x] User can make a post
- [x] User can view feed
- [x] User can view posts
- [x] User can scroll through list of posts
- [x] User can tap to switch between tabs to look at list of events or items

**Optional Nice-to-have Stories**

* [x] User can search for event
* [ ] User can see distance from current location
* [ ] User can search for events on specific dates

### 2. Screen Archetypes

* Login Screen
   * User can login 
* Registration Screen
   * User can register
* Stream
    * User can view a list of items/events
    * User can view a map of locations
    * User can save events they like
* Creation Screen
    * User can take a picture of item/event
    * User can add description and title of item/event
    * User can list whether it is an item or event
    * User can post item/event, so long as the above requirements are fulfilled
* Search
    * User can search for other users
    * User can search for certain items/events

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home (List)
* Home (Tableview) 
* Map

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Home feed
   * Registration Screen
* Registration Screen
   * Home feed
* Stream Screen
    * Home feed
* Creation Screen
    * Home feed
* Search Screen
    * To the post

## Wireframes
<img src="https://imgur.com/zjSQUOe.png" width=600>

## Schema 
### Models
**Post**
| Property | Type | Description |
|---|---|---|
| objectId | String | unique id for the user post |
| author | Pointer to User | event author |
| image | File | picture of event |
| caption | String | Event caption by author|
| commentsCount | Number | number of comments on event |
| likesCount | Number | number of likes on event |
| createdAt | DateTime | date when event is created |
| updatedAt | DateTime | date when event is updated |
| location | String | location of event |
| eventDate | DateTime | date event will be held |
| tag | String | tag whether it's free stuff or event, or both |

**User**
| Property | Type | Description |
|---|---|---|
| name | String | name of user |
| level | Number/String | Shows the experience hosting events |
| image | File | Picture of user |
| eventsAttended | Button | Goes to list of events attended |
| eventsHosted | Button | Goes to list of events hosted |
| friends | Button | Goes to list of user's friends |
| recentEvents | Posts Array | List of recent events |

### Networking

- Registration Screen
    - (Create/POST) Create a new user
    ```Swift
    let user = PFUser()
    user.username = usernameField.text
    user.password = passwordField.text
        
    user.signUpInBackground { (success, error) in
        if success {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            print("Error: \(error?.localizedDescription)")
        }
    }
    ```
- Login Screen
    - (Read/GET) Query user object
    ```Swift
    let username = usernameField.text!
    let password = passwordField.text!
        
    PFUser.logInWithUsername(inBackground: username, password: password) { 
    (user, error) in
        if user != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            print("Error: \(error?.localizedDescription)")
        }
    }
    ```
- Profile Screen
    - (Read/GET) Query user object
    ```Swift
    let user = PFUser.currentUser()?
    let eventsAttended = user.objectForKey["eventsAttended"]
    let name = user.objectForKey["name"]
    let friends = user.objectForKey["friends"]
    let level = user.objectForKey["level"]
    let query = PFQuery(className: "events")
    query.whereKey("host", equalTo : user)
    query.findObjectsInBackground { (events, error) in
        if posts != nil {
        // do something
        }
    // do something with name, friends, level, events attended, events hosted
    ```
    - (Update/PUT) Update user profile image
- Tableview Screen
    - (Read/GET) Query information on a list of events 
    ```Swift
    let post = posts[indexPath.section]
    let comments = (post["Comments"] as? [PFObject]) ?? []   
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    let user = post["author"] as! PFUser
    cell.usernameLabel.text = user.username
    cell.captionLabel.text = post["caption"] as! String
    let imageFile = post["image"] as! PFFileObject
    let urlString = imageFile.url!
    let url = URL(string: urlString)!
        
    cell.photoView.af_setImage(withURL: url)
    return cell
    }else if indexPath.row <= comments.count{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let comment = comments[indexPath.row-1]
        cell.commentLabel.text = comment["text"] as? String
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username
            return cell
    }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
        return cell
    }
    // do something with name, friends, level, events attended, events hosted
            
- List Screen
    - (Read/GET) Query information on a list of events
    ```Swift
    let post = posts[indexPath.section]
    let comments = (post["Comments"] as? [PFObject]) ?? []
    if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        return cell
    }else if indexPath.row <= comments.count{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let comment = comments[indexPath.row-1]
        cell.commentLabel.text = comment["text"] as? String
        let user = comment["author"] as! PFUser
        cell.nameLabel.text = user.username
        return cell
    }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
        return cell
    }
    // do something with name, friends, level, events attended, events hosted
- Map Screen
    - (Read/GET) Query all events within map
    ```Swift
    let query = PFQuery(className: "Posts")
    query.includeKeys(["location"])
    query.limit = 10
    query.findObjectsInBackground { (posts, error) in
        if posts != nil {
            self.posts = posts!
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        } else {
            print("Error: \(error?.localizedDescription)")
        }
    }
- Creation Screen
    - (Create/POST) Create a new post
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionField.text
        post["location"] = locationField.text!
        post["eventDate"] = eventDateField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    ```
- Search Screen
    - (Read/GET) Query events that contain the search keyword
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        var query = PFQuery(className:"Posts")
            query.whereKey("author", equalto: "keyword")
            query.whereKey("caption", equalTo: "keyword")
            query.whereKey("location", equalTo: "keyword")
            query.whereKey("eventDate", equalTo: "keyword")

            query.findObjectsInBackground { (posts, error) in
        if posts != nil {
            //do something
          } 
        //do something
        }
    }
    ```
    
- Favorites Screen
    - (Read/Get) Query all liked events
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        var query = PFQuery(className:"Likes")
            query.whereKey("post", equalto: "Likes")

            query.findObjectsInBackground { (posts, error) in
        if posts != nil {
            //do something
          } 
        //do something
        }
    }
    ```
    
- Post Screen 
    - (Create/Post) Create a new like on post
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        let like = PFObject(className: "Likes")
        
        like["author"] = PFUser.current()!
        like["createdAt"] = like.createdAt
        
        like.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    ```
    - (Create/POST) Create a new comment on post
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        let comment = PFObject(className: "Comments")
        
        comment["text"] = commentField.text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        
        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }
    }
    ```
    - (Delete) Delete a like from post
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        var query = PFQuery(className:"Likes")
            query.whereKey("author", equalTo: "\(PFUser.currentUser())")
            query.whereKey("createdAt", equalTo: "like.createdAt")

            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {

                    for object in objects as! [PFUser] {

                        object.deleteInBackground()
                    }

                } else {
                    println(error)
                }
            }
        }
    }
    ```
    - (Delete) Delete a comment from post
    ```Swift
    @IBAction func onSubmitButton(_ sender: Any) {
        var query = PFQuery(className:"Comments")
            query.whereKey("author", equalTo: "\(PFUser.currentUser())")
            query.whereKey("post", equalTo: selectedPost)
            query.whereKey("text", equalTo: commentField.text)

            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {

                    for object in objects as! [PFUser] {

                        object.deleteInBackground()
                    }

                } else {
                    println(error)
                }
            }
        }
    }
    ```
