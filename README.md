# 🚀 Challenge: Rick and Morty App

Aplicativo desenvolvido como parte de um processo seletivo, com o objetivo de consumir a API do universo **Rick and Morty**, exibindo os personagens e suas informações detalhadas.

---

## 📱 Funcionalidades

- Listagem paginada de personagens
- Filtro por **nome** e **status**
- Tela de detalhes com informações completas do personagem
- Validação de internet com alerta e opção de nova tentativa
- Suporte a **refresh** e **feedback de lista vazia**
- **Internacionalização** (Português e Inglês)
- Compatibilidade com diferentes tamanhos de tela (iPhone 8 até iPad Pro)

---

## 🧱 Arquitetura

O projeto foi estruturado seguindo os princípios de:

- **MVVM (Model-View-ViewModel)**
- **Coordinator Pattern** para controle de navegação
- **ViewCode** para construção de interfaces sem Storyboards
- Organização modular e separação clara de responsabilidades

---

## 🧪 Testes

- **Testes de UI** com `XCTest`
- **Testes unitários** cobrindo lógica da camada de `ViewModel`
- Validação com `SwiftLint` para manter o padrão de código

---

## 🛠 Tecnologias e Dependências

- **Swift 5**
- **Xcode 13.4+**
- **iOS 15.5+**
- **[SDWebImage](https://github.com/SDWebImage/SDWebImage)** para carregamento eficiente de imagens por URL
- **SwiftLint** para linting do projeto

> 📦 Caso a dependência `SDWebImage` não esteja instalada, adicione via CocoaPods ou Swift Package Manager.

---

## 🧭 Telas e Fluxo de Navegação

### 1. 🔍 Lista de Personagens

- Paginação com loading no scroll
- Botão de filtro no topo direito
- Ação ao tocar no personagem → abre detalhes

![Tela 1](https://github.com/willmoreira/Challenge/assets/32074474/5ea0328d-ae8c-40b3-bd9d-b5beb76cbac3)

---

### 2. 🧪 Filtro de Personagens

- Busca por nome (opcional)
- Picker para selecionar status (`Alive`, `Dead`, `Unknown`)
- Botões de filtrar e voltar

![Tela 2](https://github.com/willmoreira/Challenge/assets/32074474/21f86d3c-6b8f-44b5-bb01-3c9a80004d73)

---

### 3. 📄 Detalhes do Personagem

- Design inspirado em uma folha de caderno
- Exibe nome, espécie, status, gênero, local de origem e imagem

![Tela 3](https://github.com/willmoreira/Challenge/assets/32074474/72c6dbf9-3a8a-43dc-9980-590479303589)

---

## 📂 Estrutura do Projeto

```
Challenge
├── Coordinator/
├── Models/
├── Network/
├── Scenes/
│   ├── ListCharacters/
│   ├── FilterCharacter/
│   └── DetailCharacter/
├── Resources/
├── Utilities/
└── Tests/
```

---

## 💡 Extras e Diferenciais

- Alertas e feedback para o usuário em diversas situações
- Layout responsivo com testes em múltiplos dispositivos
- Teclado recolhido com toque na tela
- Strings centralizadas em um arquivo de strings para facilitar manutenção e tradução

---

## 🙏 Considerações Finais

Agradeço pela oportunidade de participar do desafio! Tenho consciência de que sempre há espaço para melhorar, e estou pronto para evoluir tecnicamente. Busco um ambiente colaborativo com boas referências técnicas para crescer e contribuir cada vez mais com a equipe. 🚀
