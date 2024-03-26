import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'Share ur moment',
          'title_error': 'Oops, Looks like there\'s a problem',
          'subtitle_error': 'Wait a minute, we are trying to fix.',
          'title_setting': 'Language',
          'subtitle_setting': 'Change languange, Enable for ID',
          'post_btn': 'Post Image',
          'title_post': 'Post ur Moment',
          'logout': 'Logout',
          'hint_desc': 'Description',
          'btn_gallery': 'Gallery',
          'btn_camera': 'Camera'
        },
        'id_ID': {
          'title': 'Bagikan momen kamu',
          'title_error': 'Ups, Sepertinya sedang ada kendala.',
          'subtitle_error':
              'Tunggu ya, kami sedang berusaha untuk memperbaikinya',
          'title_setting': 'Bahasa',
          'subtitle_setting': 'Ubah bahasa, Aktif untuk ID',
          'post_btn': 'Unggah foto',
          'title_post': 'Unggah Momen kamu',
          'logout': 'Keluar',
          'hint_desc': 'Deskripsi',
          'btn_gallery': 'Galeri',
          'btn_camera': 'Kamera'
        }
      };
}
