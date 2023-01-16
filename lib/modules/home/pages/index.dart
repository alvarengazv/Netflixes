import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netflix/modules/filme/pages/index.dart';
import 'package:netflix/modules/home/controllers/netflixController.dart';
import 'package:netflix/modules/home/pages/addProfile.dart';
import 'package:netflix/modules/home/pages/editProfile.dart';
import 'package:netflix/modules/lista/pages/index.dart';
import 'package:netflix/modules/usuario/models/usuario_model.dart';
import 'package:page_transition/page_transition.dart';

bool editProfile = false;

class HomePage extends StatefulWidget {
  final UsuarioModel usuario;

  const HomePage({Key? key, required this.usuario}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class PerfilImagem extends StatefulWidget {
  final String? asset;
  final IconData? icone;
  final VoidCallback? onTap;
  final UsuarioModel usuario;

  const PerfilImagem({Key? key, this.asset, this.icone, this.onTap, required this.usuario})
      : super(key: key);

  @override
  _PerfilImagemState createState() => _PerfilImagemState();
}

class _PerfilImagemState extends State<PerfilImagem>
    with SingleTickerProviderStateMixin {
  final animationController = NetflixController();

  @override
  void initState() {
    super.initState();
    animationController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: NetflixController.clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() => animationController.scaleTransformValue =
            1 - animationController.animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (_) => animationController.shrinkButtonSize(),
        onPointerUp: (_) => animationController.restoreButtonSize,
        child: Transform.scale(
          scale: animationController.scaleTransformValue,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: IconButton(
              splashRadius: 1,
              splashColor: Colors.transparent,
              onPressed: () {
                Future.delayed(
                  const Duration(
                      milliseconds:
                          NetflixController.clickAnimationDurationMillis),
                  () => widget.onTap?.call(),
                );
                animationController.shrinkButtonSize();
                animationController.restoreButtonSize();
                editProfile == true && widget.asset != null
                    ? Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const EditProfilePage(),
                            settings: RouteSettings(
                              arguments: widget.asset,
                            ),
                            duration: const Duration(milliseconds: 400)))
                    : widget.icone != null
                        ? Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const AddProfilePage(),
                                duration: const Duration(milliseconds: 400)))
                        : Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ListaPage(usuario: widget.usuario),
                                duration: const Duration(milliseconds: 400)));
              },
              icon: widget.asset == null
                  ? Icon(
                      widget.icone,
                      size: 70,
                      color: Colors.white,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage(widget.asset as String)))),
              iconSize: 120,
            ),
          ),
        ));
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    editProfile = false;
  }

  Widget perfilNome(String nome) {
    return Text(
      nome,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), fontSize: 13),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          editProfile == false
              ? Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        editProfile = !editProfile;
                      });
                    },
                  ),
                )
              : const Padding(padding: EdgeInsets.only(right: 0.0))
        ],
        title: Row(
            mainAxisAlignment: editProfile == false
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            mainAxisSize:
                editProfile == false ? MainAxisSize.min : MainAxisSize.max,
            children: [
              editProfile == false
                  ? const Image(
                      image: AssetImage("assets/images/logo2.png"),
                      width: 100,
                    )
                  : const Text(
                      "Gerenciar Perfis",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    )
            ]),
        leading: editProfile == true
            ? BackButton(
                onPressed: () {
                  setState(() {
                    editProfile = !editProfile;
                  });
                },
              )
            : const Padding(padding: EdgeInsets.only(right: 0)),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 150, 0, 15),
              child: Text(
                "Quem está assistindo?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  PerfilImagem(
                    asset: editProfile == false
                        ? "assets/images/geralt.jpg"
                        : "assets/images/geralt1.png",
                    onTap: () {},
                    usuario: widget.usuario,
                  ),
                  perfilNome("Perfil 1")
                ]),
                Column(children: [
                  PerfilImagem(
                    asset: editProfile == false
                        ? "assets/images/professor.jpg"
                        : "assets/images/professor1.png",
                    onTap: () {},
                    usuario: widget.usuario,
                  ),
                  perfilNome("Perfil 2")
                ]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  PerfilImagem(
                    asset: editProfile == false
                        ? "assets/images/nancy.jpg"
                        : "assets/images/nancy1.png",
                    onTap: () {},
                    usuario: widget.usuario,
                  ),
                  perfilNome("Perfil 3"),
                ]),
                Column(children: [
                  PerfilImagem(
                    icone: Icons.add_circle,
                    onTap: () {},
                    usuario: widget.usuario,
                  ),
                  perfilNome("Adicionar Perfil")
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
