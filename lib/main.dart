// O import pelo SDK dá suporte às versões anteriores do Flutter.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

void main() {
  runApp(const LojaInstrumentosApp());
}

class Instrumento {
  const Instrumento({
    required this.nome,
    required this.marca,
    required this.modelo,
  });

  final String nome;
  final String marca;
  final String modelo;
}

class LojaInstrumentosApp extends StatelessWidget {
  const LojaInstrumentosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja de instrumentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF17645C)),
        useMaterial3: true,
      ),
      home: const TelaInstrumentos(),
    );
  }
}

class TelaInstrumentos extends StatefulWidget {
  const TelaInstrumentos({super.key});

  @override
  State<TelaInstrumentos> createState() => _TelaInstrumentosState();
}

class _TelaInstrumentosState extends State<TelaInstrumentos> {
  final List<Instrumento> _instrumentos = [];

  Future<void> _abrirFormulario({int? indice}) async {
    final resultado = await Navigator.of(context).push<Instrumento>(
      MaterialPageRoute(
        builder: (context) => FormularioInstrumento(
          instrumento: indice == null ? null : _instrumentos[indice],
        ),
      ),
    );

    if (!mounted || resultado == null) return;

    setState(() {
      if (indice == null) {
        _instrumentos.add(resultado);
      } else {
        _instrumentos[indice] = resultado;
      }
    });
  }

  void _excluir(int indice) {
    setState(() {
      _instrumentos.removeAt(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loja de instrumentos')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      onPressed: () => _abrirFormulario(),
                      icon: const Icon(Icons.add),
                      label: const Text('Novo instrumento'),
                    ),
                  ),
                ),
                Expanded(
                  child: _instrumentos.isEmpty
                      ? const Center(
                          child: Text('Nenhum instrumento cadastrado.'),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: _instrumentos.length,
                          separatorBuilder: (context, indice) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, indice) {
                            final instrumento = _instrumentos[indice];
                            return Card(
                              margin: EdgeInsets.zero,
                              child: ListTile(
                                title: Text(instrumento.nome),
                                subtitle: Text(
                                  '${instrumento.marca} · ${instrumento.modelo}',
                                ),
                                onTap: () => _abrirFormulario(indice: indice),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      tooltip: 'Editar instrumento',
                                      onPressed: () =>
                                          _abrirFormulario(indice: indice),
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    IconButton(
                                      tooltip: 'Excluir instrumento',
                                      onPressed: () => _excluir(indice),
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioInstrumento extends StatefulWidget {
  const FormularioInstrumento({super.key, this.instrumento});

  final Instrumento? instrumento;

  @override
  State<FormularioInstrumento> createState() => _FormularioInstrumentoState();
}

class _FormularioInstrumentoState extends State<FormularioInstrumento> {
  final _chaveFormulario = GlobalKey<FormState>();

  late final _nome = TextEditingController(text: widget.instrumento?.nome);
  late final _marca = TextEditingController(text: widget.instrumento?.marca);
  late final _modelo = TextEditingController(text: widget.instrumento?.modelo);

  String? _validarCampo(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Preencha este campo.';
    }
    return null;
  }

  void _salvar() {
    if (!_chaveFormulario.currentState!.validate()) return;

    Navigator.of(context).pop(
      Instrumento(
        nome: _nome.text.trim(),
        marca: _marca.text.trim(),
        modelo: _modelo.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _nome.dispose();
    _marca.dispose();
    _modelo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.instrumento == null
              ? 'Cadastrar instrumento'
              : 'Editar instrumento',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _chaveFormulario,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    controller: _nome,
                    decoration: const InputDecoration(
                      labelText: 'Instrumento',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _validarCampo,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _marca,
                    decoration: const InputDecoration(
                      labelText: 'Marca',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _validarCampo,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _modelo,
                    decoration: const InputDecoration(
                      labelText: 'Modelo',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: _validarCampo,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(onPressed: _salvar, child: const Text('Salvar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
