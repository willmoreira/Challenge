# App The Rick and Morty

# Contexto do App

O app tem a finalidade de consumir a api do desenho Rick and Morty e mostrar personagens, possibilitando consultá-los e obter mais características sobre um personagem escolhido.

# Dependências

Fazer download ou clonar o projeto, vá até a pasta do projeto e clicar no arquivo StoneChallenge.xcodeproj, ao abrir o projeto no xcode.

Verificar a lib SDWebImage, caso ela não estiver no projeto adicionar via pod ou SPM a biblioteca, essa lib faz o tratamento de imagens a partir de uma url no projeto.

# Uso

A aplicação contempla 3 telas:

TELA 1 (Listagem de personagens) - É a tela inicial da aplicação que lista os personagens, contem um botão de filtro localizado na direita da barra superior de navegação que ao ser acionado abre a tela de filtro, quando um personagem da lista e clicado abre a tela de detalhes do personagem.

![img](https://github.com/willmoreira/StoneChallenge/assets/32074474/5ea0328d-ae8c-40b3-bd9d-b5beb76cbac3)

TELA 2 (Filtro de personagens) - É a tela de filtro onde permite buscar personagens por nome e status ou somente por status, sendo o resultado mostrado na tela de listagem de personagens, contem um campo para escrever o nome do personagem, um botão de seleção com 3 opções de status (alive, dead, unknown), botão de filtrar e botão de voltar para a tela de listagem de personagens.

![img1](https://github.com/willmoreira/StoneChallenge/assets/32074474/21f86d3c-6b8f-44b5-bb01-3c9a80004d73)

TELA 3 (Detalhes do personagem) - É a tela que mostra mais informações do personagem escolhido na tela de listagem de personagens

![img2](https://github.com/willmoreira/StoneChallenge/assets/32074474/72c6dbf9-3a8a-43dc-9980-590479303589)

# Requisitos

Desenvolvi o app na versão do Xcode 13.4, recomendo usar essa versão ou superior.
O target de versão do iOS é o 15.5 ou superior.

# Considerações e observações

Desafio feito seguindo os requisitos propostos:

 - A arquitetura usada foi MVVM com coordinator para navegação. 
 - Usei sempre viewCode para criar componentes visuais
 - Implementei teste unitários e teste de UI nas camadas de View como mostra a imagem a seguir.

![img4](https://github.com/willmoreira/StoneChallenge/assets/32074474/9b930484-bff3-46ba-bdcb-905d29e9dfbd)

 - Implementei validação de internet antes da requisição mostrando para o usuário um alerta e disponibilizando o botão para fazer uma nova requisição.
 - Implementei tratamento de ao voltar da tela de filtro para a tela de listar personagens mostra a lista do início.
 - Implementei a possibilidade de fazer a requisição sem filtros usando refreshControl na tela de listagem.
 - Toque na tela de filtro que permite recolher o teclado.
 - Validei o layout nos extremos da tela, tanto no menor tamanho possível do iPhone 8 (pela versão de corte) quanto no iPad Pro.
 - Instalei SwiftLint no projeto para evidenciar possiveis atenções de erros de digitação, espaços, etc.
 - Implementei internacionalização português e inglês de strings e centralizado strings em unico arquivo para organização do projeto.
 
## Telas com detalhes de fluxo e implementação

TELA 1 (Listagem de personagens) - Feito paginação da lista, loading antes da requisição, loading quando chega ao fim da primeira requisição até obter o resultado da segunda, célula customizada com a imagem do personagem com alpha de sombreamento, disclosureIndicator habilitado indicando que há clique na célula.

No caso do retorno da tela de filtro, se a lista está vazia mostro um alerta com esse feedback para o usuário
e habilito um botão para fazer o refresh, fazendo a requisição inicial sem parâmetros.
Lembrando que refreshTableView também tem a mesma ação do botão.

TELA 2 (Filtro de personagens) - Filtro, por entender que o status era um item "obrigatório" no desafio, resolvi usar um pickerView para que status sempre tivesse um parâmetro, já o nome ser opcional.
Ao filtrar ou por status, ou por nome e status retorna a tela de lista com o resultado sendo mostrado.

TELA 3 (Detalhes do personagem) - Tentei mostrar as características do personagem fazendo uma folha de caderno mostrando a imagem e as informações escritas nesse "papel".

Agradeço a oportunidade, tenho algumas dificuldades, as reconheço, mas acredito que uma oportunidade em um local onde tenha referências técnicas, eu possa evoluir, me desenvolver e contribuir.
