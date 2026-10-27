# Gestion des tags — US-59

La gestion est accessible depuis **Réglages → Gérer les tags**. La recherche
ignore la casse et les espaces superflus, y compris dans les anciens libellés.
Chaque tag actif affiche sa catégorie, sa provenance
préinstallée éventuelle et le nombre de jours d’utilisation.

Le compteur regroupe les instants des repas actifs par date civile dans le
fuseau local de l’appareil. Plusieurs repas du même jour comptent une fois ;
un favori seul ne compte aucun jour. Les suppressions, restaurations et
modifications des repas actualisent le flux de données. Un changement de
fuseau est pris en compte à la prochaine lecture du flux.

Le renommage conserve l’identifiant, la catégorie, la provenance système et la
date de création. Les espaces sont normalisés ; les doublons actifs sont
contrôlés sans tenir compte de la casse ni des espaces superflus. La création
depuis un sélecteur réutilise également un tag actif de même libellé normalisé.
La recherche des sélecteurs applique les mêmes règles aux anciens tags.

La confirmation de suppression indique le nombre de jours, de repas actifs et
de favoris actifs concernés. La suppression renseigne `deletedAt` et
`updatedAt`, sans supprimer les liaisons historiques. Les anciens repas,
favoris et exports PDF conservent le dernier libellé. Les sélecteurs de nouveaux
tags masquent le tag supprimé. L’ajout rapide d’un favori conserve ses autres
tags mais omet ceux qui sont supprimés dans le nouveau repas. Modifier un
ancien repas ou favori peut conserver ses liens historiques.

Les anciens tags préinstallés suivent les mêmes règles. Depuis la version 13
de la base, les nouvelles installations démarrent sans tags. La migration
masque les anciens tags système uniquement s'ils n'ont jamais été modifiés
(`createdAt == updatedAt`) et n'ont aucun lien vers un repas ou un favori.
Elle conserve les tags utilisés, personnalisés, créés par l'utilisateur et
les dates des suppressions précédentes. Un redémarrage ne réintroduit pas
les tags retirés.
Recréer explicitement un libellé supprimé produit un nouvel identifiant ;
l’ancien tag et ses liens restent dans l’historique.

La migration 13 réutilise les colonnes de suppression et de provenance
existantes, sans modifier la structure des tables. La sauvegarde JSON conserve
ces colonnes et les liaisons, y compris pour les tags supprimés.

Une opération en cours peut se terminer après la fermeture de l’écran. Le
contrôleur ne publie alors plus d’état vers cet écran fermé.

Validation sur Flutter 3.47.8 / Dart 3.13.7 : génération réussie, analyse sans
diagnostic, 52 tests ciblés et 334 tests au total réussis avec couverture.
Les tests couvrent les bornes de jours locaux, les doublons, la suppression,
le redémarrage, les sélecteurs, la confirmation, les anciens libellés espacés,
la fermeture de l’écran pendant une opération et les erreurs de stockage.
