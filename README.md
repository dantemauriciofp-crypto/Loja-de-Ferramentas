# Loja de instrumentos

Aplicativo Flutter da P3 de Tecnologia de Construção de Software I, versão 03.

## Executar no Android Studio no Windows

1. Instale o Flutter SDK estável. O projeto usa a configuração Android gerada pelo **Flutter 3.50.1**. Se extrair o SDK em `C:\src\flutter`, adicione `C:\src\flutter\bin` à variável `Path` do usuário. Reabra o Android Studio e o terminal após a alteração. [Instalação oficial do Flutter](https://docs.flutter.dev/install/manual)
2. Em **File → Settings → Plugins → Marketplace**, instale **Flutter**, confirme a instalação do plugin **Dart** e reinicie o Android Studio. [Configuração do Android Studio](https://docs.flutter.dev/tools/android-studio)
3. Em **SDK Manager**, instale **Android SDK Platform 36**. Na aba **SDK Tools**, instale **Android SDK Build-Tools**, **Android SDK Platform-Tools**, **Android SDK Command-line Tools (latest)** e **Android Emulator**. [Configuração do SDK Android](https://docs.flutter.dev/platform-integration/android/setup)
4. Em **File → Open**, selecione a pasta `loja_instrumentos`, que contém `pubspec.yaml`. Se o Android Studio pedir **Flutter SDK path**, indique a pasta do Flutter SDK, como `C:\src\flutter`.
5. Abra o terminal do projeto, confira o SDK e baixe as dependências com os comandos abaixo. Se as licenças do Android ainda estiverem pendentes, revise-as com `flutter doctor --android-licenses`.

   ```powershell
   flutter doctor
   flutter pub get
   ```

6. Em **Tools → Device Manager**, inicie um emulador Android. Se ainda precisar criar um, clique em **+ → Create Virtual Device**, escolha um modelo e instale a imagem do sistema. Na barra superior, selecione o dispositivo Android e clique em **Run ▶**. O ponto de entrada é `lib/main.dart`.

## Testar o aplicativo

1. Abra **Novo instrumento** e cadastre **Violão**, **Yamaha** e **C40**.
2. Selecione o item na lista, altere o modelo para **C70** e salve. A lista deve mostrar um único registro atualizado.
3. Abra um novo cadastro e tente salvar com campos vazios ou preenchidos só com espaços. O formulário deve indicar os campos obrigatórios.
4. Volte à lista e toque na lixeira do instrumento para excluí-lo.

Os dados ficam em uma lista em memória durante a execução. A tela principal usa `StatefulWidget` e `setState` para atualizar a listagem. O formulário é compartilhado entre cadastro e edição.
