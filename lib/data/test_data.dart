import 'package:intl/intl.dart';
import 'package:psicoapp/models/action_history.dart';

import '../models/therapist.dart';

var fm = DateFormat("dd/MM/yyyy");

/*
const testData = [
  Psychoeducation(
      id: 1,
      title: 'Título 1 Psychoeducation',
      folder: 'Pasta 1',
      text:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 1',
      hasQuestions: false),
  Psychoeducation(
      id: 2,
      title: 'Título 2',
      folder: 'Pasta 2',
      text: 'Texto 2',
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 2',
      hasQuestions: false),
  Psychoeducation(
      id: 3,
      title: 'Título 3',
      folder: 'Pasta 3',
      text: 'Texto 3',
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 3',
      hasQuestions: false),
  Psychoeducation(
      id: 4,
      title: 'Título 4',
      folder: 'Pasta 4',
      text: 'Texto 4',
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 4',
      hasQuestions: false),
  Psychoeducation(
      id: 5,
      title: 'Título 5',
      folder: 'Pasta 5',
      text: 'Texto 5',
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 5',
      hasQuestions: false),
  Psychoeducation(
      id: 6,
      title: 'Título 6',
      folder: 'Pasta 6',
      text: 'Texto 6',
      images: 'lib/images/addActionIcon.jpeg',
      reference: 'Referência 6',
      hasQuestions: false),
];

final testData2 = [
  ActionM(
    id: 1,
    title: 'Registro de Pensamentos',
    folder: 'Pasta 1',
    text: 'Texto 1',
    images: 'lib/images/addActionIcon.jpeg',
    reference: 'Referência 1',
    hasQuestions: false,
    pageToGo:
        "${AppRoutes.ACTIONS_HISTORY}#1", //1 - ID PRA USAR SE CASO DER PRA REAPROVIETAR A MESMA PÁGINA, SE NÃO USAR ENTÃO EXCLUIR E TIRAR LÓGICA PRA DIVIDIR E LER ISSO
  ),
  ActionM(
    id: 2,
    title: 'Verificação de Humor',
    folder: 'Pasta 2',
    text: 'Texto 2',
    images: 'lib/images/actionMoodIcon.png',
    reference: 'Referência 2',
    hasQuestions: false,
    pageToGo: "${AppRoutes.MOOD}",
  ),
];
*/
List<ActionHistory> testData3 = [
  ActionHistory(
    id: 1,
    date: fm.format(DateTime.now()),
    situation: 'Discuti com meu irmão',
    thoughts: 'Dizer o que sentia',
    mood: '4',
    emotion: ['Me sentir menor deprimido'],
    behaviors: '',
    reactions: '',
  ),
  ActionHistory(
    id: 2,
    date: fm.format(DateTime.now()),
    situation: 'Ganhei um pet',
    thoughts: 'Sonho realizado',
    mood: '10',
    emotion: ['Me sentir mais feliz, Diminuir minha ansiedade'],
    behaviors: '',
    reactions: '',
  ),
  ActionHistory(
    id: 3,
    date: fm.format(DateTime.now()),
    situation: 'Doei sangue',
    thoughts: 'Senti que podia ajudar',
    mood: '8',
    emotion: ['Melhorar minhas relações sociais'],
    behaviors: 'Comportamentos 3',
    reactions: 'Reação Fisiológica 3',
  ),
  ActionHistory(
    id: 4,
    date: fm.format(DateTime.now()),
    situation: 'Fui demitido',
    thoughts: 'Injustiça',
    mood: '1',
    emotion: ['Encontrar esperança'],
    behaviors: '',
    reactions: '',
  ),
  ActionHistory(
    id: 5,
    date: fm.format(DateTime.now()),
    situation: 'Fui viajar',
    thoughts: 'Precisava de férias',
    mood: '9',
    emotion: ['Me sentir mais feliz, Me sentir menos deprimido'],
    behaviors: '',
    reactions: '',
  ),
  ActionHistory(
    id: 6,
    date: fm.format(DateTime.now()),
    situation: 'Aprendi a dançar',
    thoughts: 'Um hobbie que gosto muito',
    mood: '8',
    emotion: ['Me sentir menos deprimido'],
    behaviors: '',
    reactions: '',
  ),
];

const testData4 = [
  "sentimento 1",
  "sentimento 2",
  "sentimento 3",
  "sentimento 4",
  "sentimento 5",
  "sentimento 6",
  "sentimento 7",
  "sentimento 8",
  "sentimento 9",
  "sentimento 10",
  "sentimento 11",
];

const buscaNoAppList = [
  "Me sentir mais feliz",
  "Diminuir minha ansiedade",
  "Me sentir menos deprimido",
  "Construir confiança e autoestima",
  "Melhorar minhas relações sociais",
  "Praticar meditação",
  "Ser mais saudável",
  "Encontrar Esperança",
  "Desenvolver autoconhecimento",
  "Outros"
];

final scale = [
  "Sentir-se nervoso(a), ansioso(a) ou tenso(a)",
  "Preocupações excessivas",
  "Dificuldade para relaxar",
  "Inquietação ou agitação",
  "Ficar facilmente com raiva ou irritado(a)",
  "Medo de que o pior aconteça",
  "Sensação de falta de ar ou aceleração do coração",
  "Falta de interesse ou prazer por atividades",
  "Sentiu para baixo, deprimido(a) ou sem perspectiva",
  "Dormir pouco ou mais do que de costume",
  "Sentir-se cansado(a) ou sem energia",
  "Falta de apetite ou comer demais",
  "Dificuldade de se concentrar",
  "Sentimento de Culpa ou Vergonha",
  "Pensou em se ferir ou que seria melhor estar morto(a)?",
];

final avatarTitles = [
  "Cabelo",
  "Cor do cabelo",
  "Barba",
  "Cor da barba",
  "Roupa",
  "Cor da roupa",
  "Olhos",
  "Sombrancelha",
  "Boca",
  "Cor da pele",
  "Óculos",
];

final moodFeelingList = [
  "triste/deprimido@sadIcon.png",
  "alegre/feliz@happyIcon.png",
  "raiva/ódio@angryIcon.png",
  "medo/ansiedade@fearIcon.png",
  "nojo/aversão@disgustedIcon.png",
  "amor/afeto@loveIcon.jpg",
  "culpa/vergonha@guiltyIcon.jpg",
  "ciúme/inveja@stressIcon.jpg",
  "outros/ @moreIcon.png",
];

final moodMoreList = [
  "estresse",
  "solidão",
  "frustração",
  "decepção",
  "rejeição",
  "mágoa",
  "paixão",
  "angústia",
  "timidez",
  "tensão",
  "desespero",
  "impotência",
  "admiração",
  "nostalgia",
  "gratidão",
  "injustiça",
  "revolta",
  "ódio",
  "indiferença",
  "apatia",
  "surpresa",
  "calma",
  "orgulho",
  "excitação",
  "constrangimento",
  "confiança",
  "esperança",
  "desconforto",
  "desânimo",
  "interesse",
  "compaixão",
  "arrependimento",
  "ressentimento",
  "ADICIONAR...",
];

final moodHistory = [
  "1/3",
  "2/10",
  "3/5",
  "4/3",
  "5/4",
  "6/6",
  "7/2",
  "8/9",
  "9/3",
  "10/10",
  "11/0",
  "12/4",
  "13/4",
  "14/4",
  "15/4",
  "16/3",
  "17/2",
  "18/5",
  "19/3",
  "20/4",
  "21/3",
  "22/3",
  "23/3",
  "24/3",
  "25/3",
  "26/4",
  "27/4",
  "28/4",
  "29/4",
  "30/4",
  "31/4",
];

const actionFeelingList = [
  "Me sentir mais feliz",
  "Diminuir minha ansiedade",
  "Me sentir menos deprimido",
  "Construir confiança e autoestima",
  "Melhorar minhas relações sociais",
  "Praticar meditação",
  "Ser mais saudável",
  "Encontrar Esperança",
  "Desenvolver autoconhecimento",
  "Outros"
];

const barChartTestList = [
  "1/2",
  "2/5",
  "3/10",
  "4/3",
  "5/2",
  "6/8",
  "7/14",
  "8/20",
  "9/21",
];

const tableChartTestList = [
  "01/04/2023*3*4",
  "02/04/2023*10*2",
  "03/04/2023*5*6",
  "04/04/2023*3*0",
  "05/04/2023*4*7",
  "06/04/2023*6*2",
  "07/04/2023*2*2",
  "08/04/2023*9*5",
  "09/04/2023*3*4",
  "10/04/2023*10*1",
  "11/04/2023*0*5",
  "12/04/2023*4*1",
  "13/04/2023*4*2",
  "14/04/2023*4*6",
  "15/04/2023*4*4",
  "16/04/2023*3*0",
  "17/04/2023*2*1",
  "18/04/2023*5*2",
  "19/04/2023*3*4",
  "20/04/2023*4*1",
  "21/04/2023*3*3",
  "22/04/2023*3*2",
  "23/04/2023*3*1",
  "24/04/2023*3*5",
  "25/04/2023*3*4",
  "26/04/2023*4*7",
  "27/04/2023*4*1",
  "28/04/2023*4*0",
  "29/04/2023*4*3",
  "30/04/2023*4*4",
  "31/04/2023*4*1",
];

List<Therapist> therapistListData = [
  Therapist(
      id: 1,
      name: "Kevin Cunha",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 2,
      name: "Sophie Martins",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "0",
      state: "Rio de Janeiro",
      approach: "Abordagem 2"),
  Therapist(
      id: 3,
      name: "Guilherme Teixeira",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: false,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 4,
      name: "Sophie Duarte",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 5,
      name: "Luiz Otávio da Mota",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "Rio de Janeiro",
      approach: "Abordagem 1"),
  Therapist(
      id: 6,
      name: "Sr. Igor Moura",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: false,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 2"),
  Therapist(
      id: 7,
      name: "João Miguel Viana",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: false,
      type: "0",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 8,
      name: "Maria Fernanda Gomes",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "0",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 9,
      name: "Luna Rocha",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "Amazonas",
      approach: "Abordagem 3"),
  Therapist(
      id: 10,
      name: "Ana Carolina da Cunha",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "0",
      state: "São Paulo",
      approach: "Abordagem 3"),
  Therapist(
      id: 11,
      name: "Marcela Porto",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "Amazonas",
      approach: "Abordagem 1"),
  Therapist(
      id: 12,
      name: "Fernando Ramos",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "Rio de Janeiro",
      approach: "Abordagem 2"),
  Therapist(
      id: 13,
      name: "João Alves",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 14,
      name: "Maria Luiza Pires",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: false,
      type: "0",
      state: "Espírito Santo",
      approach: "Abordagem 2"),
  Therapist(
      id: 15,
      name: "João Guilherme Fernandes",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "São Paulo",
      approach: "Abordagem 1"),
  Therapist(
      id: 16,
      name: "Dr. Lucas Gabriel Azevedo",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "0",
      state: "Rio de Janeiro",
      approach: "Abordagem 1"),
  Therapist(
      id: 17,
      name: "Diogo Moura",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "0",
      state: "Espírito Santo",
      approach: "Abordagem 1"),
  Therapist(
      id: 18,
      name: "Dr. Luiz Fernando Nascimento",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: true,
      type: "1",
      state: "Amazonas",
      approach: "Abordagem 3"),
  Therapist(
      id: 19,
      name: "Dr. Gustavo Henrique da Mota",
      photo: "lib/images/",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      isAvailable: false,
      type: "1",
      state: "Rio de Janeiro",
      approach: "Abordagem 2"),
];

const therapistFilterState = [
  "São Paulo",
  "Rio de Janeiro",
  "Espírito Santo",
  "Amazonas",
  "Sergipe",
];

const therapistFilterApproach = [
  "Abordagem 1",
  "Abordagem 2",
  "Abordagem 3",
];
