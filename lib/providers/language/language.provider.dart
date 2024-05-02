import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Language {
  String language;
  String Company;
  String Student;
  String TitleHomePage_1;
  String TitleHomePage_2;
  String TitleHomePage_3;
  String DescriptionHomePage;
  String TitleLogin;
  String DescriptionLogin;
  String UsernameLogin;
  String PassWordLogin;
  String RememberLogin;
  String ForgotLogin;
  String SignIn;
  String TextLogin_1;
  String TextLogin_2;
  String SuccessToast_1;
  String SuccessToast_2;
  String ErrorToast_1;
  String ErrorToast_2;
  String Register;
  String Profiles;
  String Setting;
  String ChangPass;
  String Logout;
  String Descriptionchangepass;
  String oldPass;
  String newPass;
  String TitleStudentProfile;
  String DescriptionStudentProfile;
  String Fullname;
  String EnterFullname;
  String Techstack;
  String Skillset;
  String SelectSkillset;
  String Education;
  String Next;
  String CreateLang;
  String EditLang;
  String Level;
  String textLanguage;
  String textLevel;
  String cancel;
  String save;
  String edit;
  String empty;
  String Createeducation;
  String school;
  String schoolyear;
  String Endschoolyear;
  String textSchool;
  String textSchoolyear;
  String textEndSchoolyear;
  String Editeducation;
  String Experiences;
  String DescriptionEx;
  String Projects;
  String CreaProject;
  String Title;
  String Description;
  String Stime;
  String Etime;
  String textTitle;
  String textDescription;
  String textSTime;
  String textETime;
  String EditProject;
  String CV;
  String Resume;
  String Transcript;
  String Choosefile;

  Language({
    required this.language,
    required this.Company,
    required this.Student,
    required this.TitleHomePage_1,
    required this.TitleHomePage_2,
    required this.TitleHomePage_3,
    required this.DescriptionHomePage,
    required this.TitleLogin,
    required this.DescriptionLogin,
    required this.ForgotLogin,
    required this.PassWordLogin,
    required this.RememberLogin,
    required this.SignIn,
    required this.TextLogin_1,
    required this.TextLogin_2,
    required this.ErrorToast_1,
    required this.ErrorToast_2,
    required this.SuccessToast_1,
    required this.SuccessToast_2,
    required this.UsernameLogin,
    required this.Register,
    required this.ChangPass,
    required this.Logout,
    required this.Profiles,
    required this.Setting,
    required this.Descriptionchangepass,
    required this.newPass,
    required this.oldPass,
    required this.DescriptionStudentProfile,
    required this.Education,
    required this.EnterFullname,
    required this.Fullname,
    required this.Next,
    required this.SelectSkillset,
    required this.Skillset,
    required this.Techstack,
    required this.TitleStudentProfile,
    required this.CreateLang,
    required this.Level,
    required this.textLanguage,
    required this.textLevel,
    required this.cancel,
    required this.save,
    required this.edit,
    required this.empty,
    required this.EditLang,
    required this.Createeducation,
    required this.Endschoolyear,
    required this.school,
    required this.schoolyear,
    required this.textEndSchoolyear,
    required this.textSchool,
    required this.textSchoolyear,
    required this.Editeducation,
    required this.CreaProject,
    required this.Description,
    required this.DescriptionEx,
    required this.Etime,
    required this.Experiences,
    required this.Projects,
    required this.Stime,
    required this.Title,
    required this.textDescription,
    required this.textETime,
    required this.textSTime,
    required this.textTitle,
    required this.EditProject,
    required this.CV,
    required this.Resume,
    required this.Transcript,
    required this.Choosefile,
  });

  get LanguageChange => null;
}

class _Language extends StateNotifier<Language> {
  _Language()
      : super(Language(
          language: 'Language',
          Company: 'Company',
          Student: 'Student',
          TitleHomePage_1: 'Build your product with ',
          TitleHomePage_2: 'high-skilled',
          TitleHomePage_3: ' student',
          DescriptionHomePage: 'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects. StudentHub is university market place to connect high-skilled student and company on a real-world project',
          TitleLogin: 'Let\'s Get Started!',
          DescriptionLogin: 'Please fill the below details to Sign In your account',
          UsernameLogin: 'Username or email',
          PassWordLogin: 'Password',
          RememberLogin: 'Remember Me',
          ForgotLogin: 'Forgot Password',
          SignIn: 'Sign In',
          TextLogin_1: 'Or continue with',
          TextLogin_2: 'Don\'t have an account?',
          SuccessToast_1: 'Success',
          SuccessToast_2: 'Login successfully',
          ErrorToast_1: 'Error',
          ErrorToast_2: 'Warning',
          Register: 'Register',
          Profiles: 'Profiles',
          Setting: 'Setting',
          ChangPass: 'Change password',
          Logout: 'LogOut',
          Descriptionchangepass: 'Please fill the below details',
          oldPass: 'Enter your old password',
          newPass: 'Enter your new password',
          TitleStudentProfile: 'Student profile',
          DescriptionStudentProfile: 'Tell us about yourself and you will be your way connect with real-world project',
          Education: 'Education',
          EnterFullname: 'Enter your fullname',
          Techstack: 'Techstack',
          Next: 'Next',
          SelectSkillset: 'Select Skillset',
          Skillset: 'Skillset',
          Fullname: 'Fullname',
          CreateLang: 'Create languages',
          Level: 'Level',
          textLanguage: 'Enter your languages',
          textLevel: 'Enter your level',
          cancel: 'Cancel',
          save: 'Save',
          edit: 'Edit',
          empty: 'Empty',
          EditLang: 'Edit languages',
          Createeducation: 'Create education',
          Endschoolyear: 'End school year',
          school: 'School name',
          schoolyear: 'Start school year',
          textSchool: 'Enter your school name',
          textEndSchoolyear: 'Enter your end school year',
          textSchoolyear: 'Enter your start school year',
          Editeducation: 'Edit education',
          CreaProject: 'Create project',
          Title: 'Title',
          Description: 'Description',
          Stime: 'Start time',
          Etime: 'End time',
          Experiences: 'Experiences',
          DescriptionEx: 'Tell us about your self and you will be your way connect with real-world project',
          Projects: 'Projects',
          textDescription: 'Enter your project\'s title',
          textTitle: 'Enter your project\'s description',
          textSTime: 'Enter start time',
          textETime: 'Enter end time',
          EditProject: 'Edit project',
          CV: 'CV & Transcript',
          Resume: 'Resume/CV',
          Transcript: 'Transcript',
          Choosefile: 'Choose files to Url',
        ));
  var LanguageChange = false;

  void setEngLanguage() {
    LanguageChange = false;
    setLanguageEng();
  }

  void setVNLanguage() {
    LanguageChange = true;
    setLanguageVN();
  }

  void setLanguageEng() {
    Language tmp = Language(
      language: 'Language',
      Company: 'Company',
      Student: 'Student',
      TitleHomePage_1: 'Build your product with ',
      TitleHomePage_2: 'high-skilled',
      TitleHomePage_3: ' student',
      DescriptionHomePage: 'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects. StudentHub is university market place to connect high-skilled student and company on a real-world project',
      TitleLogin: 'Let\'s Get Started!',
      DescriptionLogin: 'Please fill the below details to Sign In your account',
      UsernameLogin: 'Username or email',
      PassWordLogin: 'Password',
      RememberLogin: 'Remember Me',
      ForgotLogin: 'Forgot Password',
      SignIn: 'Sign In',
      TextLogin_1: 'Or continue with',
      TextLogin_2: 'Don\'t have an account?',
      SuccessToast_1: 'Success',
      SuccessToast_2: 'Login successfully',
      ErrorToast_1: 'Error',
      ErrorToast_2: 'Warning',
      Register: 'Register',
      Profiles: 'Profiles',
      Setting: 'Setting',
      ChangPass: 'Change password',
      Logout: 'LogOut',
      Descriptionchangepass: 'Please fill the below details',
      oldPass: 'Enter your old password',
      newPass: 'Enter your new password',
      TitleStudentProfile: 'Student profile',
      DescriptionStudentProfile: 'Tell us about yourself and you will be your way connect with real-world project',
      Education: 'Education',
      EnterFullname: 'Enter your fullname',
      Techstack: 'Techstack',
      Next: 'Next',
      SelectSkillset: 'Select Skillset',
      Skillset: 'Skillset',
      Fullname: 'Fullname',
      CreateLang: 'Create languages',
      Level: 'Level',
      textLanguage: 'Enter your languages',
      textLevel: 'Enter your level',
      cancel: 'Cancel',
      save: 'Save',
      edit: 'Edit',
      empty: 'Empty',
      EditLang: 'Edit languages',
      Createeducation: 'Create education',
      Endschoolyear: 'End school year',
      school: 'School name',
      schoolyear: 'Start school year',
      textSchool: 'Enter your school name',
      textEndSchoolyear: 'Enter your end school year',
      textSchoolyear: 'Enter your start school year',
      Editeducation: 'Edit education',
      CreaProject: 'Create project',
      Title: 'Title',
      Description: 'Description',
      Stime: 'Start time',
      Etime: 'End time',
      Experiences: 'Experiences',
      DescriptionEx: 'Tell us about your self and you will be your way connect with real-world project',
      Projects: 'Projects',
      textDescription: 'Enter your project\'s title',
      textTitle: 'Enter your project\'s description',
      textSTime: 'Enter start time',
      textETime: 'Enter end time',
      EditProject: 'Edit project',
      CV: 'CV & Transcript',
      Resume: 'Resume/CV',
      Transcript: 'Transcript',
      Choosefile: 'Choose files to Url',
    );
    state = tmp;
  }

  void setLanguageVN() {
    Language tmp = Language(
      language: 'Ngôn ngữ',
      Company: 'Công Ty',
      Student: 'Sinh viên',
      TitleHomePage_1: 'Xây dựng sản phẩm cùng sinh viên ',
      TitleHomePage_2: 'trình độ cao',
      TitleHomePage_3: '',
      DescriptionHomePage: 'Tìm và tiếp nhận sinh viên có kỹ năng tốt nhất cho sản phẩm của bạn. Sinh viên làm việc để tích lũy kinh nghiệm và kỹ năng từ các dự án thực tế. StudentHub là thị trường của trường đại học để kết nối sinh viên có kỹ năng cao và doanh nghiệp trên các dự án thực tế',
      TitleLogin: 'Bắt đầu thôi!',
      DescriptionLogin: 'Vui lòng điền các thông tin dưới đây để Đăng nhập vào tài khoản của bạn',
      UsernameLogin: 'Tên người dùng hoặc email',
      PassWordLogin: 'Mật khẩu',
      RememberLogin: 'Ghi nhớ',
      ForgotLogin: 'Quên mật khẩu',
      SignIn: 'Đăng nhập',
      TextLogin_1: 'Hoặc tiếp tục với',
      TextLogin_2: 'Chưa có tài khoản?',
      Register: 'Đăng kí',
      SuccessToast_1: 'Thành công',
      SuccessToast_2: 'Đăng nhập hoàn tất',
      ErrorToast_1: 'Lỗi',
      ErrorToast_2: 'Cảnh báo',
      Profiles: 'Hồ sơ',
      Setting: 'Cài đặt',
      ChangPass: 'Đổi mật khẩu',
      Logout: 'Đăng xuất',
      Descriptionchangepass: 'Vui lòng điền thông tin chi tiết bên dưới',
      oldPass: 'Nhập mật khẩu cũ của bạn',
      newPass: 'Nhập mật khẩu mới của bạn',
      TitleStudentProfile: 'Hồ sơ sinh viên',
      DescriptionStudentProfile: 'Kể về bản thân bạn và cách bạn kết nối với dự án thực tế của mình',
      Education: 'Học vấn',
      EnterFullname: 'Nhập họ tên của bạn',
      Techstack: 'Công nghệ',
      Next: 'Tiếp tục',
      SelectSkillset: 'Chọn kỹ năng',
      Skillset: 'Kỹ năng',
      Fullname: 'Họ và tên',
      CreateLang: 'Tạo ngôn ngữ',
      Level: 'Trình độ',
      textLanguage: 'Nhập tên ngôn ngữ',
      textLevel: 'Trình độ ngôn ngữ',
      cancel: 'Hủy',
      save: 'Lưu',
      edit: 'Sửa',
      empty: 'Trống',
      EditLang: 'Chỉnh sửa ngôn ngữ',
      Endschoolyear: 'Năm học cuối',
      school: 'Tên trường học',
      schoolyear: 'Năm học đầu',
      textSchool: 'Nhập tên trường học',
      textEndSchoolyear: 'Nhập năm học cuối của bạn',
      textSchoolyear: 'Nhập năm học đầu của bạn',
      Createeducation: 'Tạo học vấn',
      Editeducation: 'Chỉnh sửa học vấn',
      CreaProject: 'Tạo dự án',
      Title: 'Tiêu đề',
      Description: 'Mô tả',
      Stime: 'Bắt đầu',
      Etime: '   Kết thúc',
      Experiences: 'Kinh nghiệm',
      DescriptionEx: 'Kể về bản thân bạn và cách bạn kết nối với dự án thực tế của mình',
      Projects: 'Dự án',
      textDescription: 'Nhập tiêu đề của dự án',
      textTitle: 'Nhập mô tả của dự án',
      textSTime: 'Bắt đầu',
      textETime: 'Kết thúc',
      EditProject: 'Chỉnh sửa dự án',
      CV: 'Sơ yếu lý lịch và bảng điểm',
      Resume: 'Sơ yếu lý lịch',
      Transcript: 'Bảng điểm',
      Choosefile: 'Chọn tài liệu trong thư viện',
    );
    state = tmp;
  }
}

final LanguageProvider = StateNotifierProvider<_Language, Language>((ref) => _Language());
