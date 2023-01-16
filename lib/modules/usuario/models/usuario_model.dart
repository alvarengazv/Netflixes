// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  String? nome;
  String? emailTel;
  String? senha;
  int? id;

  

  UsuarioModel({
    this.nome,
    this.emailTel,
    this.senha,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'emailTel': emailTel,
      'senha': senha,
      'id': id,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      nome: map['nome'] != null ? map['nome'] as String : null,
      emailTel: map['emailTel'] != null ? map['emailTel'] as String : null,
      senha: map['senha'] != null ? map['senha'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsuarioModel(nome: $nome, emailTel: $emailTel, senha: $senha, id: $id)';
  }

  @override
  bool operator ==(covariant UsuarioModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.emailTel == emailTel &&
      other.senha == senha &&
      other.id == id;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
      emailTel.hashCode ^
      senha.hashCode ^
      id.hashCode;
  }

  bool isValid(){
    String padrao = r"^[a-zA-Z][a-zA-Z\s]{0,30}[a-zA-Z]$";
    RegExp regex = RegExp(padrao);
    if ((nome == null || nome!.isEmpty || !regex.hasMatch(nome as String)) &&
        nome!.isNotEmpty) {
      throw Exception('Digite um nome válido');
    } else if (nome == null || nome!.isEmpty) {
      throw Exception("Nome não informado.");
    }
    String padrao2 =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    String padrao3 = r"^[1-9]{2}9[7-9]{1}[0-9]{3}[0-9]{4}$";
    RegExp regex2 = RegExp(padrao2);
    RegExp regex3 = RegExp(padrao3);
    if ((emailTel == null || emailTel!.isEmpty || !regex.hasMatch(emailTel as String)) &&
        emailTel!.isNotEmpty) {
      if ((emailTel == null || emailTel!.isEmpty || !regex2.hasMatch(emailTel as String)) &&
          emailTel!.isNotEmpty) {
        throw Exception('Digite um email ou número de telefone válido');
      } 
    } else if (emailTel!.isEmpty) {
       throw Exception("Email ou telefone não informados.");
    }
    if(senha != null || senha!.isNotEmpty){
      if (senha!.length >= 6 && senha!.length <= 60) {
        
      } else {
        throw Exception("A senha deve conter entre 6 e 60 caracteres.");
      }
    } else {
       throw Exception("Senha não informada.");
    }
    return true;
  }

  UsuarioModel copyWith({
    String? nome,
    String? emailTel,
    String? senha,
    int? id,
  }) {
    return UsuarioModel(
      nome: nome ?? this.nome,
      emailTel: emailTel ?? this.emailTel,
      senha: senha ?? this.senha,
      id: id ?? this.id,
    );
  }
}
