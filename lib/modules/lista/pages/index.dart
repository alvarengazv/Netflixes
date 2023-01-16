import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/modules/lista/controllers/listaController.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:netflix/modules/usuario/pages/register2.dart';

class ListaPage extends StatefulWidget {
  final UsuarioModel usuario;

  const ListaPage({Key? key, required this.usuario}) : super(key: key);

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final _controller = ListaPageController();
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    _controller.carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LISTA DE USUÁRIOS"),
        ),
        body: ValueListenableBuilder(
            valueListenable: _controller.usuarioDataSourceNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                      itemCount: _controller.usuarioDataSource.length,
                      itemBuilder: (context, indice) {
                        final usuario = _controller.usuarioDataSource[indice];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onTap: () {
                              showDialog(
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Text('Perfil', style: TextStyle(color: Colors.red,  fontWeight: FontWeight.bold),),
                                    content: 
                                        Text('Nome: ${usuario.nome} \nEmail: ${usuario.emailTel}', style: TextStyle(color: Colors.red)),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          surfaceTintColor: Color.fromARGB(255, 218, 145, 139)
                                        ),
                                        onPressed: () => Navigator.pop(context), 
                                        child: Text('OK', style: TextStyle(color: Colors.red))
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            leading: Icon(Icons.person),
                            iconColor: Colors.white,
                            tileColor: Color.fromARGB(255, 255, 13, 0),
                            title: Text(
                              usuario.nome ?? 'Sem Nome',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              usuario.emailTel ?? "Sem Email",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () async{
                                        await Navigator.push(context, MaterialPageRoute(
                                          builder: ((context) => Register2Page(usuario: usuario,)),
                                          settings: RouteSettings(
                                    arguments: usuario.emailTel,
                                  ),
                                          ));
                                        _controller.carregaDados();
                                      }, 
                                      icon: Icon(Icons.edit, color: Colors.yellow,)
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        _controller.excluiUsuario(usuario, (){
                                          _controller.carregaDados();
                                        }, (){

                                        });
                                      }, 
                                      icon: Icon(Icons.delete)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            }));
  }
}
