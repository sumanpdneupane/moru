import 'dart:io';
import 'package:universal_io/io.dart' as universal;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileManger {
  static String NO_SELECTED = "Image/file is not selected.";

  static Future<String> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // used getImage() instead of deprecated pickImage

    if (pickedFile == null) {
      return NO_SELECTED;
    } else {
      return pickedFile.path;
    }
  }

  static Future<String?> openFileSystem({
    FileType? fileType,
    required bool allowExtensions,
    List<String>? allowedExtensions,
  }) async {
    if (fileType == null) {
      fileType = FileType.custom;
    }

    if (allowedExtensions == null || allowedExtensions.length < 1) {
      allowedExtensions = ['jpg', 'png', 'pdf', 'doc'];
    }
    FilePickerResult? result;
    if (allowExtensions) {
      result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
      );
    } else {
      result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: ['jpg', 'png'],
      );
    }

    if (result == null) {
      return NO_SELECTED;
    }
    return result.files.single.path;
  }

  // static Future<void> openWebCamera(){
  //
  // }

  static Future<File> compressFile(File file) async {
    if (getFileExtensionFromFile(file) == FileSystemType.IMAGE) {
      final dirPath = await getExternalStorageDirectory();
      print("compressFile--------> " + dirPath!.path);

      //check file size
      //4288630
      //142913
      int quality = 80;
      int fileSize = file.readAsBytesSync().lengthInBytes; //file.lengthSync();
      double fileInMB = 0.0;
      if (fileSize > 0) {
        fileInMB = fileSize / (1024 * 1024);
      }

      final _filename = path.basename(file.path);
      final _outPath = "${dirPath.path}/compressed_${fileSize}_$_filename";
      print("compressFile--------> " + _outPath);

      if (fileInMB > 15.0) {
        quality = 55;
      } else if (fileInMB > 8.0) {
        quality = 60;
      } else if (fileInMB > 5.0) {
        quality = 75;
      }
      print("quality= $quality");

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        _outPath,
        quality: quality,
      );

      print("compressFile--------> " + result!.path);
      print(fileSize);
      print(result.readAsBytesSync().lengthInBytes);
      print(fileInMB);
      print("quality= $quality");

      return result;
    } else {
      return file;
    }
  }

  static String _getFileType(String extension) {
    if (extension == "png" ||
        extension == "PNG" ||
        extension == "jpg" ||
        extension == "JPG" ||
        extension == "jpeg" ||
        extension == "JPEG") {
      return FileSystemType.IMAGE;
    }
    return FileSystemType.FILE;
  }

  static String getFileExtensionFromFile(File file) {
    final _filename = path.basename(file.path);
    final _nameWithoutExtension = path.basenameWithoutExtension(file.path);
    final _extenion = path.extension(file.path);
    //print('Filename: $_filename');
    //print('Filename without extension: $_nameWithoutExtension');
    //print('Extension: $_extenion');

    String ext = _extenion.split(".")[1];
    String fileType = _getFileType(ext);

    //print("Extension Type: $fileType");
    return fileType;
  }

  static String getFileExtensionFromUrl(String fileUrl) {
    final File _file = new File(fileUrl);
    final _filename = path.basename(_file.path);
    final _nameWithoutExtension = path.basenameWithoutExtension(_file.path);
    final _extenion = path.extension(_file.path);
    //print('Filename: $_filename');
    //print('Filename without extension: $_nameWithoutExtension');
    //print('Extension: $_extenion');

    String ext = _extenion.split(".")[1];
    String fileType = _getFileType(ext);

    //print("Extension Type: $fileType");
    return fileType;
  }

  static String getFileName(String fileUrl) {
    final File _file = new File(fileUrl);
    final _filename = path.basename(_file.path);
    final _extenion = path.extension(_file.path);
    //print('Filename: $_filename');
    //print('Extension: $_extenion');
    return _filename + _extenion;
  }

  static String getFromFileName(File file) {
    final _filename = path.basename(file.path);
    final _extenion = path.extension(file.path);
    //print('Filename: $_filename');
    //print('Extension: $_extenion');
    return _filename;
  }

  static Widget loadImageFile({
    required File file,
    required double height,
    required double width,
    BoxFit fit = BoxFit.fill,
  }) {
    return _ImageViewer(
      file: file,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class FileSystemType {
  static final String IMAGE = "IMAGE";
  static final String FILE = "FILE";
}

class _ImageViewer extends StatefulWidget {
  final File file;
  final double height;
  final double width;
  BoxFit fit;

  _ImageViewer({
    Key? key,
    required this.file,
    required this.height,
    required this.width,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  State<_ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<_ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: universal.Platform.isAndroid || universal.Platform.isIOS
          ? Image.file(
              widget.file,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
            )
          : Image.network(
              widget.file.path,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
            ),
    );
  }
}
