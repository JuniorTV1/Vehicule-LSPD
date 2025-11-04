# 🖱️ Guide des Scripts Logitech Améliorés

## 📋 Résumé des Améliorations

### ❌ Problèmes du Script Original

```lua
EnablePrimaryMouseButtonEvents(true)
function OnEvent(event, arg)
    if IsMouseButtonPressed(3) then
        repeat
            if IsMouseButtonPressed(1) then
                repeat
                    MoveMouseRelative(0, 2)
                    Sleep(10)
                    MoveMouseRelative(0, 1)
                    Sleep(12)
                until not IsMouseButtonPressed(1)
            end
            Sleep(1)
        until not IsMouseButtonPressed(3)
    end
end
```

**Problèmes identifiés :**
1. ❌ La fonction `OnEvent` ne traite pas les événements correctement
2. ❌ Boucle infinie avec `Sleep(1)` → Charge CPU élevée
3. ❌ Pas de gestion propre des événements `MOUSE_BUTTON_PRESSED`/`RELEASED`
4. ❌ Logique de vérification constante même quand inactif
5. ❌ Pas de configuration centralisée
6. ❌ Aucun commentaire ou documentation
7. ❌ Difficile à maintenir et personnaliser

---

## 📁 Fichiers Disponibles

### 1. `logitech_mouse_script_improved.lua` - Version Améliorée ⭐

**Pour qui ?** Utilisateurs cherchant une version stable et optimisée du script original.

**Améliorations :**
- ✅ Gestion correcte des événements souris
- ✅ État actif/inactif pour éviter les déclenchements non désirés
- ✅ Configuration centralisée facile à modifier
- ✅ Code bien commenté et organisé
- ✅ Système de logging pour le débogage
- ✅ Meilleure performance CPU
- ✅ Vérification double (tir + modificateur) dans la boucle

**Utilisation :**
```
1. Maintenir le bouton 3 (molette) → Active le mode
2. Cliquer sur le bouton gauche → Compensation automatique
3. Relâcher le bouton 3 → Désactive le mode
```

---

### 2. `logitech_mouse_script_advanced.lua` - Version Avancée 🚀

**Pour qui ?** Joueurs avancés voulant plusieurs profils de compensation pour différentes armes.

**Fonctionnalités additionnelles :**
- ✅ 5 modes de recul prédéfinis (Léger → Très Fort)
- ✅ Mode "Spray Pattern" avec corrections horizontales
- ✅ Changement de mode à la volée avec le bouton 4
- ✅ Patterns de mouvement cycliques
- ✅ Facilement extensible pour ajouter vos propres patterns

**Modes disponibles :**
1. **Léger** - Pour pistolets/armes précises
2. **Moyen** - Usage général (par défaut)
3. **Fort** - Pour fusils d'assaut
4. **Très Fort** - Pour armes à fort recul
5. **Spray Pattern** - Compensation avec ajustements horizontaux

**Utilisation :**
```
1. Appuyer sur le bouton 4 → Changer de mode
2. Maintenir le bouton 3 → Activer
3. Tirer avec le clic gauche → Compensation active
```

---

## 🔧 Installation

### Logitech G HUB (Recommandé)

1. Ouvrir **Logitech G HUB**
2. Sélectionner votre souris
3. Aller dans **Affectations** → **Scripts**
4. Créer un nouveau script
5. Copier-coller le contenu du fichier choisi
6. Sauvegarder et activer le profil

### Logitech Gaming Software (Ancien)

1. Ouvrir **LGS**
2. Sélectionner votre souris
3. Cliquer sur **Personnaliser les boutons**
4. Sélectionner un profil
5. Cliquer sur **Script** (icône d'engrenage)
6. Copier-coller le contenu du fichier choisi
7. Sauvegarder

---

## ⚙️ Personnalisation

### Configuration de Base (Version Améliorée)

```lua
local CONFIG = {
    TRIGGER_BUTTON = 3,        -- Changer le bouton modificateur
    FIRE_BUTTON = 1,           -- Bouton de tir
    MOVEMENT_Y_PRIMARY = 2,    -- Intensité du mouvement (↑ = plus fort)
    MOVEMENT_Y_SECONDARY = 1,  -- Mouvement secondaire
    DELAY_PRIMARY = 10,        -- Délai (↓ = plus rapide)
    DELAY_SECONDARY = 12,
    ENABLE_OUTPUT = false      -- true pour voir les logs
}
```

### Ajouter un Mode Personnalisé (Version Avancée)

```lua
-- Exemple pour une arme spécifique
{
    name = "Mon AK-47",
    moves = {
        {x = 0,  y = 3, delay = 8},   -- Premier tir vers le bas
        {x = -1, y = 3, delay = 9},   -- Légère correction gauche
        {x = 2,  y = 2, delay = 10},  -- Correction droite
        {x = 0,  y = 2, delay = 11},  -- Stabilisation
    }
}
```

**Comment trouver les bonnes valeurs ?**
1. Activez `ENABLE_OUTPUT = true`
2. Testez avec des valeurs moyennes
3. Ajustez progressivement :
   - `y` trop faible → La visée monte
   - `y` trop fort → La visée descend
   - Ajustez `x` pour les déviations horizontales
   - `delay` contrôle la vitesse de compensation

---

## 🎮 Numéros des Boutons Souris

```
1 = Clic gauche
2 = Clic droit
3 = Clic molette (bouton du milieu)
4 = Bouton latéral arrière
5 = Bouton latéral avant
6+ = Boutons supplémentaires (selon votre souris)
```

---

## 🐛 Débogage

### Le script ne fonctionne pas ?

1. **Vérifier que le script est actif** dans G HUB/LGS
2. **Activer les logs** : `ENABLE_OUTPUT = true`
3. **Vérifier les numéros de boutons** : Certaines souris ont des numéros différents
4. **Tester chaque bouton** individuellement

### La compensation est trop forte/faible ?

- **Trop forte** : Diminuez `MOVEMENT_Y_PRIMARY` et `MOVEMENT_Y_SECONDARY`
- **Trop faible** : Augmentez ces valeurs
- **Trop rapide** : Augmentez les `DELAY`
- **Trop lente** : Diminuez les `DELAY`

### Charge CPU élevée ?

- Augmentez les valeurs de `DELAY` (minimum recommandé : 5ms)
- Vérifiez que vous utilisez bien les versions améliorées

---

## 📊 Comparaison des Versions

| Caractéristique | Original | Amélioré | Avancé |
|----------------|----------|----------|--------|
| Gestion événements | ❌ | ✅ | ✅ |
| Performance CPU | ❌ | ✅ | ✅ |
| Configuration | ❌ | ✅ | ✅ |
| Documentation | ❌ | ✅ | ✅ |
| Modes multiples | ❌ | ❌ | ✅ |
| Spray patterns | ❌ | ❌ | ✅ |
| Facilité d'utilisation | ⚠️ | ✅ | ⚠️ |

**Recommandations :**
- 🎯 **Débutants** → Version Améliorée
- 🎮 **Joueurs réguliers** → Version Améliorée
- 🏆 **Joueurs avancés** → Version Avancée

---

## ⚠️ Avertissements

1. **Usage dans les jeux compétitifs** : Vérifiez les règles du jeu. Certains considèrent ces scripts comme de la triche.
2. **Anti-cheat** : Certains anti-cheats peuvent détecter les macros souris.
3. **Responsabilité** : Utilisez ces scripts à vos propres risques.
4. **Sanction possible** : Vous pourriez être banni dans certains jeux.

---

## 📝 Changelog

### Version Améliorée
- ✅ Refonte complète de la gestion des événements
- ✅ Ajout d'un système de configuration centralisé
- ✅ Optimisation des performances
- ✅ Documentation complète

### Version Avancée
- ✅ Système multi-modes
- ✅ Patterns de compensation personnalisables
- ✅ Changement de mode dynamique
- ✅ Support des spray patterns

---

## 🤝 Support

Pour toute question ou problème :
1. Vérifiez la section **Débogage** ci-dessus
2. Activez les logs pour voir ce qui se passe
3. Testez les valeurs progressivement

---

## 📜 Licence

Ces scripts sont fournis "tels quels", sans garantie d'aucune sorte.
Utilisez-les de manière responsable et éthique.

---

**Bon jeu ! 🎮**
