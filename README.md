# ***Dashboard***

## **Introduction**
Bienvenue sur le projet AREA. Ce projet de fin de 3ème année à EPITECH consiste à créer une suite de services reposant sur un front web et mobile et un serveur applicatif en backend réalisable dans des langages aux choix. L'intêret du projet résidait dans la création d'une architecture intégrant plusieurs "briques" logiciels différentes. Ce projet à été réalisé par Neil Cauet, Colin Martinage, Baptiste Daffiniet, Grasset Alexandre et Paul Bryche.
 
## **Sommaire**
 ### [**Le projet**](#le-projet-1)
 ### [**Lancement du projet**](#lancement-du-projet-1)
 ### [**Services et action/réaction**](#services-et-action/réaction-1)
 ### [**Dépannage**](#dépannage-1)
 ### [**Explication rapide du code**](#explication-rapide-du-code-1)
 ### [**Explication plus détaillée du code**](#explication-plus-détaillée-du-code-1)
 
 
## **Le projet**
Pour ce projet, nous avons décidé d'utiliser le langage php ainsi que le framework
symfony en version 5 pour le site web, Javascript pour le serveur applicatif, et Flutter pour l'application mobile. Nous avons utilisé symfony car ce framework offre une très grosse mobilité pour le code et permet aussi d'utiliser beaucoup d'outils intégrés par la communauté ou les 
développeurs pour les appels d'api par exemple ou pour utiliser le [système d'annotations](https://symfony.com/doc/current/routing.html)
 de symfony. Pour la partie mobile, Flutter nous a semblé un bon choix car de nombreux package sont disponible, permettant ainsi de développer rapidement et de manière complète une appli mobile grâce à son interface utilisateur. L'API quand à elle a été développée en Node.js car la documentation était plus complète et plus accessible que d'autre langages, dans le cadre de développement d'une API. Nous avons trouvé ce projet très enrichissant car il nous a permis d'approfondir
 nos connaissances en web et plus particulièrement dans le php qui est l'un des languages les
 plus utilisés aujourd'hui dans le domaine du développement web. De plus concevoir une API étant nouveau pour nous, cela nous a permis d'en apprendre plus sur ces dernières et plus particulièrement sur leur utilisation.
 
## **Lancement du projet**
 Pour lancer le projet veuillez suivre ces instructions :
 * clonez-le repository en question.
 * rendez-vous à la racine du projet. Vous devriez voir un dossier API, , MobileApp, WebClient et un fichier
 docker-compose.yaml.
 * vérifiez que vous possédez la dernière version de docker-compose et lancez la commande
  `docker-compose build && docker-compose up`
 * vous devriez voir les dockers se lancer un à un. Veuillez attendre quelques instants le temps
 que tous les dockers soient correctement installés.
 * Lorsque vous arrivez à la fin, vous devriez voir aucune activité du côté du terminal dans 
 lequel vous avez lancé les dockers.
 * Vous pouvez accéder au lien [localhost:8080](http://localhost:8080)
 * vous arriverez sur la page de connexion du site, il ne vous reste plus qu'à vous connecter
 ou à créer un compte. 
 * Pour arrêter le projet et les dockers, commencez par kill le processus dans le terminal, vous pouvez ensuite lancer la commande
 `sudo docker container rm (sudo docker container ls -a -q)` pour les utilisateurs fish ou `sudo docker container rm $(sudo docker container ls -a -q)`
 pour les utilisateurs bash
 * Pour vous connecter, il existe déjà un compte pré-configurés. Les identifiants du compte sont : email -> cauetneil@gamil.com; password -> 123456.
 * Pour créer un compte il vous suffit de vous rendre dans le formulaire d'inscription depuis le menu de connexion est de renseigner les informations suivantes: name, email, password, puis de validé.
 
 ## **Services et action/réaction**
 Pour ce projet nous avons décidé d'implémenter 6 action/réaction de 3 services différents. Voici les différents services avec leurs action/réaction :
 * ##### *Service Weather*
 
## **Dépannage**
Au cas où vous auriez des soucis au lancement du projet, veuillez vous référer à cette section pour voir si votre souci
peut être résolu.
* erreur au lancement des scripts avec des permissions non mises : tentez de lancer le projet avec les droits sudo `sudo docker-compose build && sudo docker-compose up`
* erreur lors du build du DockerFile sur composer. Cela veux dire que l'installation de composer ne s'est pas correctement faites.
Pour résoudre cette erreur suivez ces instructions.
    * vérifiez que vous possédez `composer` d'installé sur votre machine. Si ce n'est pas le cas, installez le.
    * quand vous avez installé `composer`, vérifiez que vous êtes bien sur une version supérieure à ^2.0.0. (`composer -v` pour la vérification de version)
    * rendez-vous dans le dossier dashboard du projet, dans ce dossier lancez la commande `composer install`. Cela aura
    pour but d'installer toutes les dépendances requises pour le bon fonctionnement du projet. (il se peut que vous ayez besoins de lancer avec les droits root `sudo composer install`)
    * attendez que toute l'installation soit terminée. Lorsque c'est le cas rendez-vous à la racine du projet. Vous devez avoir
    les dossiers dashboard, docker et un fichier docker-compose.yaml. Re-suivez le tutoriel de lancement de projet [ici](#lancement-du-projet-1)
* erreur au lancement de docker mais ne concernant pas les droits sudo : vérifiez que le service docker est bien lancé. Pour ce faire
exécutez la commande `sudo systemctl start docker` cela aura pour but de démarrer le service docker. Lancez ensuite `sudo systemctl enable docker`
. Cela permettra d'avoir docker qui s'execute au lancement de votre machine.
* erreur lors de l'installation de unzip et/ou libzip-dev : pour résoudre ce souci, ajoutez au fichier `/etc/resolv.conf` la ligne
`nameserver 8.8.8.8`. Relancez ensuite le service docker et retentez l'installation en ayant au préalable supprimé les anciens containers.

## **Explication rapide du code**
L'AREA est un projet composé de différente partie: une API, un client Web, une appli Mobile et un docker compose. Chaque partie du code sera expliqué brièvement ci-après dans différentes parties.
Pour les personnes souhaitant une explication plus détaillée du code et du fonctionnement du projet, 
veuillez vous rendre dans la section [Explication plus détaillée du projet](#explication-plus-détaillée-du-code-1).

* ##### *API*
Au lancement du projet, l'API va éxécuter le fichier index.js à la racine du dossier API. Ce fichier initialise viens require le fichier firebase.js afin d'inclure les différentes clé API utilisé sur les services de l'AREA. Une fois ce fichier chargé, l'index.js initialise les différentes requêtes proposé par l'API de l'AREA, ces requêtes peuvent être de type POST ou GET et permettent pour chaque service de: s'abonné/se désabonné d'un service, savoir si un user est déjà abonné à un service, executé les divers action/réaction proposées par l'AREA. Chaque requête appelé renvoie un json nommé data contenant les informations de la requête, un status contenant le message de la requête et un code contenant un code de la requête.

* ##### *Client Web*
Lors du lancement du projet, symfony va d'abord se référer à la page index.php dans le dossier public du projet. Cette page 
va appeler le Kernel du projet qui va ensuite s'occuper d'appeler les bonnes fonctions en fonction du lien qui est appelé, etc.
L'appel des fonctions par rapports au lien est géré grâce aux annotations. Ce bundle permet de gérer plus efficacement les liens de chaque page.
Avec les annotations il n'y a plus qu'à coder la fonction et à retourner une page internet de cette fonction pour qu'elle soit affichée.
Il faut aussi savoir que les fonctions sont organisées en Controller. Un Controller est un peu comme une armoire et chaque fonction
et donc page internet qui lui sont reliées est un tiroir de cette armoire. Un Controller va regrouper des fonctions d'un ensemble de pages parlant de la même chose.
Par exemple nous allons créer un Controller pour l'administration et 1 autre Controller pour tout ce qui est en rapport avec les produits et les détails des produits.

* ##### *Appli Mobile*
Au lancement, l'application mobile affiche les pages selon les actions de l'utilisateur. Une fois lancée va amener vers une page de connexion qui elle meme amène à un menu général
avec les différents services et tables d'action/réactions. C'est dernier nécessites une souscription de la part de l'utilisateur depuis le menu des paramètres.
L'affichage des différents widgets d'action/réactions se réalise ensuite grace à un call à l'API pour chaque widget qui permet de savoir si l'utilisateur y est inscrit.
Les pages du menu se contruisent donc en fonction des options souscrites par l'utilisateur grace à des call à l'api puis l'application génère les pages.
L'utilisateur peut gérer ses souscriptions aux services et actions liées qui elles meme sont répartie sur les différentes pages du menu.
Les pages se génèrent donc selon les choix de l'utilisateur grace à un lien au service de l'api qui permet ainsi d'obtenir les informations nécessaires.

* ##### *Docker compose*
Le docker permet bien de se connecter sur l'API et le serveur Web respectivement sur les ports 8080 et 8081. Mais une erreur apparait au moment de se connecter ce qui veut dire que le docker ne crée pas correctement le lien entre le client web et l'API

## **Explication plus détaillée du code**

* ##### *API*

* ##### *Client Web*
Pour ce projet je me suis très rapidement orienté sur le système de notations de symfony. Ce bundle
permet notamment d'utiliser des routes grâce à des annotations dans le code plutôt que de devoir
remplir le fichier route.yaml dans le dossier configuration. Voici un exemple d'annotation
```php
/**
* @Route("/login", name="login")
**/
public function foo()
{
/**
* some code
**/
}
```

Dans ce code, nous pouvons voir que grâce au système d'annotations, symfony va comprendre que si l'utilisateur cherche à accéder au
lien /login, ca sera la fonction foo qui sera lancée et qui gérera l'action par rapport à cette route. Le `name="login"` dans la seconde 
partie de l'annotation `@Route` permet dans le code de redirigé facilement vers une nouvelle page. Pour appeler par exemple cette page nous pourrions
avoir ce code
```php
/**
* @return \Symfony\Component\HttpFoundation\RedirectResponse
**/
public function bar()
{
return $this->redirectToRoute('login');
}
```

Ce code redirigera la personne vers la page /login et donc vers la fonction foo().

Un autre avantage d'utiliser symfony a été pour le rendu des pages html. Pour ça nous avons utilisé [twig](https://twig.symfony.com/).
Twig est un moteur de templates qui permet de faire du code au sein meme du code php. Cela permet notamment 
de faire des boucles, de créer des variables ou de faire beaucoup d'autres choses. Il permet aussi de faire
de l'héritage par rapport aux fichiers. C'est-à-dire que nous pouvons créer un fichier de base qui possédera des block.
Ces block pourrons ensuite être réutilisés dans les fichiers fils qui auront hérités du code du fichier père. Exemple :
```twig
{# base.html.twig #}
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>{% block title %}Title{% endblock %}</title>
    {% block stylesheets %}
    {% endblock %}
</head>
<body>
{% block body %}{% endblock %}
{% block javascripts %}{% endblock %}
</body>
</html>
```
Dans ce fichier nous pouvons voir que nous avons créés plusieurs block représentant chacun une partie de balise ou une balise html.
Pour modifier le contenu des balises dans un fichier fils il n'y a plus qu'à appeler la balise en question et écrire dedans de cette façon :
```twig
{# fils.html.twig #}
{% extends 'base.html.twig' %}
{% block body %}
bonjour je suis dans le body
{% endblock %}
```

Lorsque nous appellerons notre page fils.html.twig nous aurons affiché à l'écran le contenu du body sans avoir eu à réécrire tout le code html de la page.
Bien sûr de cette façon nous écrasons tout ce qui peut être écrit dans le fichier parent. Pour résoudre ce problème il
suffit d'ajouter la balise `{{ parent() }}` après avoir appelé le block en question.

Avec symfony, nous pouvons lier le code à une base de donnée qu'elle soit en locale ou en ligne. Pour chaque table existant
dans une base de données il faut créer une entity. Cette entity va permettre de faire le lien justement entre le code lorsque l'on va
créer des formulaires par exemple pour ajouter des données ou pour en supprimer. Ces entity sont accessible grâce à un
repository. Le repository est une classe étendue de ServiceEntityRepository et va permettre d'utiliser l'entity grâce à des 
`@methods` implémentées dans les annotations de la classe. Il existe des méthodes par default comme find, findby...

Exemple d'un Controller : 
```php
<?php

namespace App\Controller;

use LogicException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class SecurityController extends AbstractController
{
    /**
     * @Route("/", name="landing")
     * @param AuthenticationUtils $authenticationUtils
     * @return Response
     */
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
         if ($this->getUser()) {
             return $this->redirectToRoute('widgets');
         }

        $error = $authenticationUtils->getLastAuthenticationError();
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('security/login.html.twig', ['last_username' => $lastUsername, 'error' => $error]);
    }

    /**
     * @Route("/logout", name="app_logout")
     */
    public function logout()
    {
        throw new LogicException('This method can be blank - it will be intercepted by the logout key on your firewall.');
    }
}
```

Pour utiliser le framework symfony, il est conseillé d'utiliser `composer`. Cet outil est un gestionnaire de paquet
spécialisé pour un projet php avec symfony. Lorsque l'on va utiliser un projet, il faut lancer la commande `composer install`
qui va aller chercher dans le fichier composer.json toutes les dépendances requises pour le projet.  

* ##### *Appli Mobile*

Pour l'application mobile, j'ai fais le choix d'utiliser flutter qui permet de mettre en place rapidement une interface utilisateur agréable grace aux nombreux widgets disponibles.
Cela permet donc de mettre en place la partie visuelle sur laquel on vient greffer les différents éléments selon les actions requise.
Ainsi le menu de connexion est mis en place puis une fois la connexion réaliser l'utilisateur accède au menu principal qui lui permettra de gérer ses options d'utilisation.

Ce menu permet donc d'acéder aux différentes pages de services dans lesquelles viennent se loger les différents composants dépendant des souscriptions de l'utilisateur.
Le code ci-dessous présente donc le menu qui permet un accès aux différentes pages en un "swipe" à droite ou à gauche.

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(length: 6, child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: new Icon(Icons.home), onPressed: () {}),
          title: Text('Home', style: TextStyle(color: Colors.white),),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF673AB7),
                    const Color(0xFF3F51B5),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.8, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              tabs: [
                Tab(icon: new Icon(FontAwesomeIcons.google),),
                Tab(icon: new Icon(FontAwesomeIcons.twitter),),
                Tab(icon: new Icon(FontAwesomeIcons.youtube),),
                Tab(icon: new Icon(FontAwesomeIcons.instagram),),
                Tab(icon: new Icon(Icons.filter_drama),),
                Tab(icon: new Icon(Icons.person),),
              ]
          ),
        ),
        body: TabBarView(children: [
          GoogleMap(),
          Twitter(),
          Youtube(),
          Instagram(),
          OpenWeather(),
          Params(),
        ]),
      )),
    );
  }
}

Les widgets se construisent ensuite dans les pages selon les options choisies précédemment par l'utilisateur et lui permettent d'accéder aux différents actions et réactions de manière indépendante.

Les conditional_map_builder et conditional_city_map_builder se construisent donc selon le retour de l'API concernant les choix de souscription de l'utilisateur.

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SingleChildScrollView(
        child: Container(color: Colors.lightBlue[100],
          child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Conditional_Map_Builder(map_statu),
                  Conditional_City_Map_Builder(city_map_statu),
                ]
              ),
            ),
          ),
        ),
      );
  }
}


* ##### *Docker compose*