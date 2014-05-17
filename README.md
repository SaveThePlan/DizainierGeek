DizainierGeek
=============

MOOC iOS FUN : exercice 3 DizainierGeek

## Énoncé #

Reprendre l'exercice Dizainier, mais avec les interfaces en mode « programmatique ».


Application universelle permettant de saisir un nombre *de 0 à 99* de diverse manières:

- via un stepper : +1 ou -1
- via un slider
- via deux segmented : 
    - le premier pour les dizaines
    - le second pour les unités


Le nouveau nombre est répercuté sur chacun des éléments de l'interface.

Si le nombre est 42, il doit s'afficher dans une couleur différente


Un switch "mode geek" permet de convertir l'affichage en hexadecimal.


## Version produite #

Le mode geek provoque l'affichage de deux segmented supplémentaires qui permettent de saisir un nombre en hexadecimal, il correspondent respectivement aux rangs 1 et 2 du nombre saisi.  
De plus, l'affichage du résultat est dupliqué, une première fois en décimal, une seconde fois en hexadécimal.  
L'application est donc un mini convertisseur
