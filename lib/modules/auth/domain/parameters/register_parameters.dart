class RegisterParameters {
  final String email ; 
  final String firstName ; 
  final String lastName ; 
  final String userName ;
  final String password ; 

  const RegisterParameters({
    required this.firstName ,
    required this.lastName,
    required this.userName,
    required this.email , 
    required this.password});

  Map<String,dynamic> toJson() => {
    "firstName" : firstName, 
    "lastName" : lastName,
    "userName" : userName,
    "email" : email , 
    "password" : password,

  };
}