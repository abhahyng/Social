// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social/components/comment.dart';
import 'package:social/components/commentbtton.dart';
import 'package:social/components/deletebutton.dart';
import 'package:social/components/likebutton.dart';
import 'package:social/helper/helpermethods.dart';

class Post extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const Post({
    super.key,
    required this.message,
    required this.user,
    required this.likes,
    required this.postId,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final commentTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Comment",
              style: TextStyle(color: Colors.grey),),
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: TextField(
                controller: commentTextController,
                decoration: InputDecoration(
                  hintText: "Write a comment..",hintStyle: TextStyle(color: Colors.grey
                 ), ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    commentTextController.clear();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    addComment(commentTextController.text);
                    Navigator.pop(context);
                    commentTextController.clear();
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ));
  }
  void deletePosts(){
    showDialog(context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Post"),
      content: const Text("Are you sure you want to delete this post ?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context),
         child: const Text("Cancel",
         style: TextStyle(color: Colors.grey),),
         ),
         TextButton(onPressed: () async{
          final commentDocs = await FirebaseFirestore.instance
          .collection("User Posts")
          .doc(widget.postId)
          .collection("Comments")
          .get();

          for(var doc in commentDocs.docs){
            await FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .collection("Comments")
            .doc(doc.id)
            .delete();
          }


          FirebaseFirestore.instance
          .collection("User Posts")
          .doc(widget.postId)
          .delete()
          .then((value) => print("post deleted"))
          .catchError(
            (error) => print("failed to delete post: $error")
          );
          Navigator.pop(context);
          
         },
         child: const Text("Delete",
         style: TextStyle(color: Colors.grey),),
         ),

      ],

    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 5),
                  Text(widget.message),
                ],
              ),
              Column(
                children: [
                  Likebutton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  CommentButton(onTap: showCommentDialog),
                  const SizedBox(height: 5),
                  Text(
                    "Comments",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              //delete button
              if(widget.user == currentUser.email)
              DeleteButton(onTap: deletePosts)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData = doc.data() as Map<String, dynamic>;

                  return Comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
