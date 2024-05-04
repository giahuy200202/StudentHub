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
  String Continue;
  String CompanyProfile;
  String CompanyDes;
  String PeopleCompany;
  String People_1;
  String People_2;
  String People_3;
  String People_4;
  String People_5;
  String Companyname;
  String Web;
  String Message;
  String Alert;
  String Dashboard;
  String DesRegister;
  String RegisterCompany;
  String RegisterStudent;
  String CreateAccount;
  String TextRegister;
  String Login;
  String DesRegister_2;
  String TextRegister_step2;
  String Email_2;
  String Pass_Register;
  String RulestRegister_step2;
  String CreateAccount_step2;
  String ApplyStudent;
  String textEmail;
  String reset_pass;
  String Time;
  String Proposals;
  String Time_1;
  String Time_2;
  String Time_3;
  String Time_4;
  String StudentNeed;
  String Createat;

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
    required this.Continue,
    required this.CompanyDes,
    required this.CompanyProfile,
    required this.PeopleCompany,
    required this.People_1,
    required this.People_2,
    required this.People_3,
    required this.People_4,
    required this.People_5,
    required this.Companyname,
    required this.Web,
    required this.Alert,
    required this.Dashboard,
    required this.Message,
    required this.CreateAccount,
    required this.DesRegister,
    required this.RegisterCompany,
    required this.RegisterStudent,
    required this.TextRegister,
    required this.Login,
    required this.ApplyStudent,
    required this.CreateAccount_step2,
    required this.DesRegister_2,
    required this.Email_2,
    required this.Pass_Register,
    required this.RulestRegister_step2,
    required this.TextRegister_step2,
    required this.textEmail,
    required this.reset_pass,
    required this.Time,
    required this.Proposals,
    required this.Time_1,
    required this.Time_2,
    required this.Time_3,
    required this.Time_4,
    required this.StudentNeed,
    required this.Createat,
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
          Continue: 'Continue',
          CompanyDes: 'Tell us about your company and you will be your way connect with real-world project',
          CompanyProfile: 'Company profile',
          PeopleCompany: 'How many people in company?',
          People_1: 'It\'s just me',
          People_2: '2-9 employees',
          People_3: '10-99 employees',
          People_4: '100-1000 employees',
          People_5: 'More than 1000 employees',
          Companyname: 'Compant name',
          Web: 'Website',
          Alert: 'Alert',
          Message: 'Message',
          Dashboard: 'Dashboard',
          DesRegister: 'Join as company or student',
          TextRegister: 'Already have an account?',
          CreateAccount: 'Create account',
          RegisterCompany: 'I am a company, find engineers for project',
          RegisterStudent: 'I am a student, research for project',
          Login: 'Login',
          ApplyStudent: 'Apply as student',
          DesRegister_2: 'Please fill the below details',
          Email_2: 'Email address',
          Pass_Register: 'Password (8 or more characters)',
          TextRegister_step2: 'Looking for a project?',
          RulestRegister_step2: 'Yes, i understand and agree to StudentHub',
          CreateAccount_step2: 'Create my account',
          textEmail: 'Enter your email',
          reset_pass: 'Reset password',
          Time: 'Time',
          Proposals: 'Proposals',
          Time_1: 'Less than 1 month',
          Time_2: '1-3 months',
          Time_3: '3-6 months',
          Time_4: 'More than 6 months',
          StudentNeed: 'students needed',
          Createat: 'Created at',
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
      Continue: 'Continue',
      CompanyDes: 'Tell us about your company and you will be your way connect with real-world project',
      CompanyProfile: 'Company profile',
      PeopleCompany: 'How many people in company?',
      People_1: 'It\'s just me',
      People_2: '2-9 employees',
      People_3: '10-99 employees',
      People_4: '100-1000 employees',
      People_5: 'More than 1000 employees',
      Companyname: 'Compant name',
      Web: 'Website',
      Alert: 'Alert',
      Message: 'Message',
      Dashboard: 'Dashboard',
      DesRegister: 'Join as company or student',
      TextRegister: 'Already have an account?',
      CreateAccount: 'Create account',
      RegisterCompany: 'I am a company, find engineers for project',
      RegisterStudent: 'I am a student, research for project',
      Login: 'Login',
      ApplyStudent: 'Apply as student',
      DesRegister_2: 'Please fill the below details',
      Email_2: 'Email address',
      Pass_Register: 'Password (8 or more characters)',
      TextRegister_step2: 'Looking for a project?',
      RulestRegister_step2: 'Yes, i understand and agree to StudentHub',
      CreateAccount_step2: 'Create my account',
      textEmail: 'Enter your email',
      reset_pass: 'Reset password',
      Time: 'Time',
      Proposals: 'Proposals',
      Time_1: 'Less than 1 month',
      Time_2: '1-3 months',
      Time_3: '3-6 months',
      Time_4: 'More than 6 months',
      StudentNeed: 'students needed',
      Createat: 'Created at',
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
      Continue: 'Tiếp tục',
      CompanyDes: 'Kể về công ty bạn và cách bạn kết nối với dự án thực tế của mình',
      CompanyProfile: 'Hồ sơ công ty',
      PeopleCompany: 'Công ty có bao nhiêu nhân sự?',
      People_1: 'Chỉ mình tôi',
      People_2: '2-9 nhân viên',
      People_3: '10-99 nhân viên',
      People_4: '100-1000 nhân viên',
      People_5: 'Hơn 1000 nhân viên',
      Companyname: 'Tên công ty',
      Web: 'Website',
      Alert: 'Thông báo',
      Message: 'Tin Nhắn',
      Dashboard: 'Trang Chủ',
      DesRegister: 'Tham gia với tư cách là sinh viên hoặc công ty',
      TextRegister: 'Đã có tài khoản?',
      CreateAccount: 'Tạo tài khoản',
      RegisterCompany: 'Tôi là công ty, tìm kỹ sư cho dự án',
      RegisterStudent: 'Tôi là sinh viên, nghiên cứu dự án',
      Login: 'Đăng nhập',
      ApplyStudent: 'Tiếp tục với sinh viên',
      DesRegister_2: 'Vui lòng điền thông tin chi tiết bên dưới',
      Email_2: 'địa chỉ email',
      Pass_Register: 'Mật khẩu (từ 8 kí tự trở lên)',
      TextRegister_step2: 'Đang tìm kiếm một dự án',
      RulestRegister_step2: 'Có, tôi hiểu và đồng ý với StudentHub',
      CreateAccount_step2: 'Tạo tài khoản của tôi',
      textEmail: 'Nhập email của bạn',
      reset_pass: 'Tạo lại mật khẩu',
      Time: 'Thời gian',
      Proposals: 'Đề nghị',
      Time_1: 'dưới 1 tháng',
      Time_2: '1-3 tháng',
      Time_3: '3-6 tháng',
      Time_4: 'hơn 6 tháng',
      StudentNeed: 'sinh viên',
      Createat: 'Tạo lúc:',
    );
    state = tmp;
  }
}

final LanguageProvider = StateNotifierProvider<_Language, Language>((ref) => _Language());
