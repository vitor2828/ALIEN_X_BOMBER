# ALIEN_X_BOMBER

##### Por João Vítor Lima, Eduardo Sankievicz e Danilo Lins



#### Alien_X_Bomber é um jogo inspirado em Bomberman, mas com claras referências à série de filmes Alien. Foi feito 100% em Assembly Risc-V, com ajuda do [RARS](https://github.com/TheThirdOne/rars) e [FPGRARS](https://github.com/LeoRiether/FPGRARS), para execução, e suas respectivas ferramentas de entrada e de saída de dados.

![Alt](./BOMBER_X_ALIEN/sprites/tela_inicio.bmp)

## COMO RODAR O JOGO:

#### Abra o terminal na pasta "BOMBER_X_ALIEN". Lá, execute um dos comandos a seguir...

#### ./fpgrars_linux -h 480 -w 640 main.s -port 0 (LINUX)
#### fpgrars_windows.exe -h 480 -w 640 main.s (WINDOWS)

##### Obs: ao utilizar uma distro linux, é provável que o áudio não saia corretamente na primeira vez. Para corrigir isso, siga o [tutorial do criador do FPGRARS](https://leoriether.github.io/FPGRARS/midi/).



## COMANDOS BÁSICOS:

#### w - a - s - d (movimentação do jogador);
#### j (coloca a bomba);

##### DICA: leia o README dentro do .rar do jogo para descobrir funcionalidades extras.

##### Obs: Após a apresentação do projeto (graças a Deus), surgiu um bug que afeta a movimentação dos inimigos. No entanto, resolvê-lo não está entre nossas prioridades atuais.

