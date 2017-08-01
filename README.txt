Préparation: 
  

Le projet nécessite la version 3.0.12 de SWIG (ou possiblement plus). 

Si vous utilisez la version 3.0.12, vous devez copier le dossier csharp situé dans le dépôt sous 'swig/csharp' et le fusionner avec [répertoire SWIG]\Lib\csharp. 

Il s'agit de quelques fonctionnalités qui ne sont pas encore intégrées dans la version officielle. 

Pour compiler le projet, penser à utiliser le script swig-build dans le dossier script. La solution Visual Studio est déjà paramétrée pour l'utiliser. 


Structure: 

Le projet génère 2 DLLs, une C/C++, une autre C#.


1. LibLogicalAccessNet.win32: 
 
Contient le code C généré par SWIG à partir des interfaces (fichiers .i). 

On retrouve 10 interfaces : 

- liblogicalaccess.i: interface principale, qui est inclue dans chacune des autres. On y retrouve les includes nécessaires à tous, la définition de quelques %ignore redondant, la définition des classes qui seront des shared_ptr (plus de détails plus bas), la gestion de l'héritage multiple pour les classes où cela est possible, en transformant les classes en interface, la gestion des exceptions C++ à travers le C# afin de conserver le bon nom d'exception et le bon message du côté C# (plus de détails plus bas) 

- liblogicalaccess_exception.i : interface d'inclusions des fichiers contenant des classes d'exceptions. De même, ces classes sont définies comme pouvant être shared_ptr à la main dans ce même fichier. 

- liblogicalaccess_data.i : interface de wrapping autour des classes de data. On retrouve également la majorité des mappings de type. Cette interface sert en effet à définir, à la main ou nom, tout mapping de type non pris en compte par défaut par SWIG. 

- liblogicalaccess_core.i : interface de wrapping du cœur des éléments de la lib, notamment toutes les classes dont vont dériver tous les plugins. Il s'agit des classes de la plus haute couche d'abstraction qui sont wrappées ici. On  y retrouve aussi quelques typemaps, et principalement le mapping des types en sortie côté C#, lorsque le type est un pointeur sur un haut niveau d'abstraction d'une hiérarchie, ce pointeur ne peut plus être downcasté perd le polymorphisme en passant à travers le C#. Il faut donc recréer la classe fille à la main, côté C#, puis la remettre dans une classe plus abstraite. Pour chaque famille, on retrouve alors une factory d'objet qui se base sur un simple caractéristiques de l'objet pour recréer la bonne classe.  

- liblogicalaccess_iks.i: interface de wrapping et de mapping de type autour de l'IKS. 

- liblogicalaccess_card.i: interface de wrapping autour de tous les plugins cartes. On y retrouve l'inclusion de toutes les classes des cartes. 

- liblogicalaccess_reader.i: idem mais pour les lecteurs. 

- liblogicalaccess_library.i: interface simple pour l'inclusion puis le wrapping des classes de la librairie dynamique. 

- liblogicalaccess_cardservice.i: interface pour l'inclusion des services de cartes. Ne compile pas. 

- liblogicalaccess_readerservice.i: interface pour l'inclusion des services de lecteurs. Ne compile pas. 



2. LibLogicalAccessNet: 

Cette DLL C# va contenir tous les fichiers C# générés SWIG. Une référence à la DLL C++ est requise. On y retrouve également les fichiers PInvoke, un pour chaque interface ayant compilé, qui va servir de passerelle entre les deux langages. 


Scripts: 

On retrouve 5 scripts différents dans le dossier scripts. 

Les 3 premiers, en Python, vont servir à adapter dynamiquement les interfaces lorsque cela est possible. 

- autoComplete.py: ce script - a ne pas lancer trop souvent car extrêmement gourmand en temps, ne le lancer que lorsque des changements majeurs dans la lib ont été effectués - va servir à ajouter automatiquement les fichiers à inclure lorsqu'ils s'agit de plugins notamment, ainsi qu'ajouter les directives %shared_ptr() automatiquement pour chaque classe dans l'interface liblogicalaccess.i 

- createExceptionClass.py: ce script regarde dans les fichiers de la lib qui contiennent des classes pour les générer en C#. La liste des fichiers n'est pas dynamique, donc si un fichier avec une nouvelle classe est ajouté dans la lib, il faudra rajouter son emplacement dans le script à la main. 

- adaptExceptionClass.py: a lancer juste après le précédant pour adapter la classe générée automatiquement. 

- callScriptPython.bat: sert simplement à appeler un script python à travers une commande .bat. Utile pour appeler le script depuis Visual Studio, en évènement post-build ou pré-build. Pour l'instant, ce script n'a jamais vraiment été utilisé. 

- swig-build.ps1: script Powershell pour compiler les interfaces et optimiser l'utilisation de la mémoire et du processeur. 


Tests Unitaires: 

Les tests unitaires ne sont pas finis et ne tourne pas pour la plupart car ils ne sont qu'un simple recopiage des tests C++ et ne s'adapte pas du tout aux quelques changements opérés pour la version C#, notamment les différences de hiérarchie. 


Avancement du projet:

Le projet est quasiment fonctionnelle, à ce jour il ne fonctionne pas encore à cause de l'heritage multiple. SWIG ne propose pas encore de solution qui marche dans tous les cas. La solution trouvée est donc de se débarasser de l'héritage multiple/héritage virtuel dans la librairie C++ et de le remplacer par des classes englobés sous forme de bridge à travers les classes qui étaient leurs filles par avant, pour conserver les méthodes et champs. Cependant, le polymorphisme est perdu. Tous les autres points sensibles sont fonctionnels, à savoir les exceptions, les shared_ptr, le slicing des objets entre les langages (même lorsque c'est un pointeur) qui est réglé avec toutes les factory, etc.

La documentation de SWIG est relativement complète et permet de comprendre mon travail. Il faut savoir que le doc C# n'est pas aussi complète que la doc pour le Java, alors que presque toutes les fonctionnalités sont similaires. Je recommande de la lire également, conjointement à la doc générale et la doc C#.

De plus, la communauté SWIG est relativement active, sur GitHub, StackOverflow et sur la mailing list SWIG, ce qui est extrement pratique pour ne pas perdre trop de temps lors d'un problème.


Installer:

Une ébauche d'installer a été faite. Elle permet de chainer l'installation avec une autre, en utilisant les properties des paramètres d'installation. De plus, les DLLs ont été organisés en 2 features, une pour les 64 bits, l'autre pour les 32, afin d'installer automatiquement les bonnes en fonction de la machine. (https://stackoverflow.com/questions/44827196/chained-packages-in-advanced-installer)

Dépôt dans lesquels des changements ont été opérés:

- liblogicalaccess: github: schullq/liblogicalaccess branch:develop
- liblogicalaccess-libnfc: github: schullq/liblogicalaccess-libnfc branch:develop
- liblogicalaccess-private : nouvelle branche sur le repos principal -> develop_stagiaire
- LibLogicalAccessWinForms : liblogicalaccesscs branch: v2
- ReadCard: readcard branch:v2


Liens utiles:

- Pull request en attente: https://github.com/swig/swig/pull/989 // pull request de std_list.i et std_vector.i
- Issue toujours ouverte: https://github.com/swig/swig/issues/1022 // Issue à propos de l'heritage virtuel non géré
- Question sans reponse sur SO: https://stackoverflow.com/questions/45352707/how-to-use-interface-with-a-templated-class, 
// Question à propos du couplage des directive %template et %interface