import 'package:gofriendsgo/utils/constants/paths.dart';

extension GetAttachmentImage on String {
  String getAttachmentTypeImage() {
    if (endsWith('.doc')) {
      return AppImages.docAttachment;
    } else if (endsWith('.csv')) {
      return AppImages.csvAttachment;
    } else if (endsWith('.docx')) {
      return AppImages.docxAttachment;
    } else if (endsWith('.ppt')) {
      return AppImages.pptAttachment;
    } else if (endsWith('.pptx')) {
      return AppImages.pptxAttachment;
    } else if (endsWith('.rar')) {
      return AppImages.rarAttachment;
    } else if (endsWith('.txt')) {
      return AppImages.txtAttachment;
    } else if (endsWith('.xls')) {
      return AppImages.xlsAttachment;
    } else if (endsWith('.xlsx')) {
      return AppImages.xlsxAttachment;
    } else if (endsWith('.zip')) {
      return AppImages.zipAttachment;
    } else {
      return AppImages.pdfAttachment;
    }
  }
}
