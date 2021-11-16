import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lost_found_pet_prototype/api/abstract_post_api.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/util/logger.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class PostApi implements AbstractPostApi {
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  static const defaultLimit = 7;

  Reference get _imageRef => _storage.ref().child('images');

  CollectionReference get postsRef => _fireStore.collection('posts');

  @override
  Future<Post> create(Post post, List<Asset> images) async {
    Logger.printInfo(StackTrace.current);

    await Future.forEach<Asset>(images, (asset) async {
      String downloadUrl = await _saveImage(asset);
      post.imageUrl.add(downloadUrl);
    });
    final postRef = postsRef.doc();
    post.id = postRef.id;
    post.createdAt = DateTime.now();
    await postRef.set(post.toJson());
    final _postSnapshot = await postRef.get();
    return Post.fromDocumentSnapshot(_postSnapshot);
  }

  @override
  Future<Post> fetchById(String id) async {
    Logger.printInfo(StackTrace.current);

    final _postSnapshot = await postsRef.doc(id).get();
    return Post.fromDocumentSnapshot(_postSnapshot);
  }

  @override
  Future<List<DocumentSnapshot>> fetchByTypeRaw(
      PostType postType, DocumentSnapshot lastDocument,
      [limit = defaultLimit]) async {
    Logger.printInfo(StackTrace.current);

    final _postType = Post.postTypeToJson(postType);

    Query query = postsRef
        .where('postType', isEqualTo: _postType)
        .orderBy('dateTimeLost', descending: true);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    query = query.limit(limit);

    final snapshots = await query.get();

    await Future.delayed(Duration(milliseconds: 500));

    return snapshots.docs;
  }

  @override
  Future<List<DocumentSnapshot>> fetchByUidRaw(
      String uid, DocumentSnapshot lastDocument,
      [limit = defaultLimit]) async {
    Logger.printInfo(StackTrace.current);

    Query query = postsRef
        .where('uid', isEqualTo: uid)
        .orderBy('dateTimeLost', descending: true);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    query = query.limit(limit);

    final snapshots = await query.get();

    await Future.delayed(Duration(milliseconds: 500));

    return snapshots.docs;
  }

  @override
  Future<String> delete(String id) async {
    Logger.printInfo(StackTrace.current);

    await postsRef.doc(id).delete();
    return id;
  }

  @override
  Future<Post> update(String id, Post post) async {
    Logger.printInfo(StackTrace.current);

    await postsRef.doc(id).set(post.toJson());
    return post;
  }

  Future<dynamic> _saveImage(Asset asset) async {
    Logger.printInfo(StackTrace.current);

    String imageName =
        '${DateTime.now().millisecondsSinceEpoch.toString()}_${asset.name}';

    ByteData byteData = await asset.requestThumbnail(1024, 768, quality: 70);
    List<int> imageData = byteData.buffer.asUint8List();
    UploadTask uploadTask =
        _imageRef.child(imageName).putData(imageData);

    return (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  }
}
