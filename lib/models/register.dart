class Register {
  final int id;
  final String nome;
  final String genero;
  final String estCivil;
  final String idade;
  final String celular;
  final String email;
  final String senha;
  final String tratPsico;
  final String tratPsiq;
  final String buscaNoApp;

  const Register({
    required this.genero,
    required this.estCivil,
    required this.idade,
    required this.celular,
    required this.email,
    required this.senha,
    required this.tratPsico,
    required this.tratPsiq,
    required this.buscaNoApp,
    required this.id,
    required this.nome,
  });

  static const GeneroList = ["Masculino", "Feminino", "Indefinido"];
  static const EstCivilList = [
    "Solteiro(a)",
    "Casado(a)",
    "Viúvo(a)",
    "Divorciado(a)"
  ];
  static const Tratamento = ["Não", "Sim"];
}
