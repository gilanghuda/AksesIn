import 'package:aksesin/data/models/user_model.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/komunitas_provider.dart';
import '../../../domain/entities/komunitas.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';

class PostKomunitasScreen extends StatefulWidget {
  @override
  _PostKomunitasScreenState createState() => _PostKomunitasScreenState();
}

class _PostKomunitasScreenState extends State<PostKomunitasScreen> {
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _images;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  final Uuid _uuid = Uuid();

  void _pickImages() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() {
      _images = pickedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _contentController.text.isEmpty
                    ? null
                    : () async {
                        UserModel user = await authProvider.getCurrentUserProfile();
                        _postKomunitas(user);
                      },
                child: Text('Posting'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: _contentController.text.isEmpty ? Colors.grey : Colors.blue,
                ),
              ),
            ),
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<UserModel>(
        future: authProvider.getCurrentUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data found.'));
          } else {
            UserModel user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl!),
                          radius: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _contentController,
                            decoration: InputDecoration(hintText: 'Ketik di sini...'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Konten tidak boleh kosong';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _images != null
                        ? Wrap(
                            spacing: 10,
                            children: _images!.map((image) => Image.file(File(image.path), width: 100, height: 100)).toList(),
                          )
                        : Container(),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: _pickImages,
                    ),
                    Spacer(),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _postKomunitas(UserModel user) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final content = _contentController.text;

    try {
      final komunitas = Komunitas(
        id: _uuid.v4(),
        userId: user.id,
        username: user.username,
        content: content,
        createdAt: DateTime.now(),
        commentText: [],
        images: _images?.map((image) => image.path).toList(),
        userProfileImage: user.photoUrl,
        category: user.disabilityOptions.join(', '),
        likedBy: [], 
      );

      await Provider.of<KomunitasProvider>(context, listen: false).addNewKomunitas(komunitas);
      context.pop('/komunitas') ;
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
