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
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<List<String>> _uploadImagesToCloudinary(List<XFile> images) async {
    List<String> imageUrls = [];
    for (var image in images) {
      final request = http.MultipartRequest('POST', Uri.parse('https://api.cloudinary.com/v1_1/dyejedtcq/upload'));
      request.fields['upload_preset'] = 'aksesin';
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      try {
        final response = await request.send();
        print('Response status: ${response.statusCode}');
        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          final jsonResponse = json.decode(responseData);
          print('Response data: $jsonResponse');
          imageUrls.add(jsonResponse['secure_url']);
        } else {
          final responseData = await response.stream.bytesToString();
          print('Error response data: $responseData');
          throw Exception('Failed to upload image');
        }
      } catch (e) {
        print('Exception: $e');
        throw Exception('Failed to upload image: $e');
      }
    }
    return imageUrls;
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
                child: Text(
                  'Posting',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
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
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No user data found.',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            );
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
                          backgroundImage: user.photoUrl != null 
                              ? NetworkImage(user.photoUrl!) 
                              : null,
                          child: user.photoUrl == null 
                              ? Icon(Icons.account_circle, size: 40) 
                              : null,
                          radius: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _contentController,
                            decoration: InputDecoration(
                              hintText: 'Ketik di sini...',
                              hintStyle: TextStyle(fontFamily: 'Montserrat'),
                            ),
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
                    if (_isLoading)
                      CircularProgressIndicator()
                    else if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontFamily: 'Montserrat'),
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
      List<String>? imageUrls;
      if (_images != null && _images!.isNotEmpty) {
        print("MASUK SINI GA");
        setState(() {
          _isLoading = true;
        });
        imageUrls = await _uploadImagesToCloudinary(_images!);
        setState(() {
          _isLoading = false;
        });
      }

      final komunitas = Komunitas(
        id: _uuid.v4(),
        userId: user.id,
        username: user.username,
        content: content,
        createdAt: DateTime.now(),
        commentText: [],
        images: imageUrls,
        userProfileImage: user.photoUrl ?? '',
        category: user.disabilityOptions?.join(', ') ?? '',
        likedBy: [], 
      );
      await Provider.of<KomunitasProvider>(context, listen: false).addNewKomunitas(komunitas);
      context.pop('/komunitas');
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
