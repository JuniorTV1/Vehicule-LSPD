-- ============================================================================
-- Script Logitech G HUB/LGS - Contrôle de recul amélioré
-- ============================================================================
-- Description: Compense automatiquement le recul en déplaçant la souris vers
--              le bas lorsque le bouton gauche est maintenu et le bouton 3
--              (molette) est activé comme modificateur.
-- ============================================================================

-- CONFIGURATION
local CONFIG = {
    -- Boutons
    TRIGGER_BUTTON = 3,        -- Bouton modificateur (3 = molette/bouton du milieu)
    FIRE_BUTTON = 1,           -- Bouton de tir (1 = clic gauche)
    
    -- Mouvement de la souris
    MOVEMENT_Y_PRIMARY = 2,    -- Déplacement vertical principal (en pixels)
    MOVEMENT_Y_SECONDARY = 1,  -- Déplacement vertical secondaire (en pixels)
    
    -- Délais (en millisecondes)
    DELAY_PRIMARY = 10,        -- Délai après mouvement principal
    DELAY_SECONDARY = 12,      -- Délai après mouvement secondaire
    DELAY_CHECK = 5,           -- Délai pour vérifier l'état des boutons
    
    -- Options
    ENABLE_OUTPUT = false      -- Afficher les messages de débogage
}

-- ============================================================================
-- VARIABLES GLOBALES
-- ============================================================================
local isActive = false

-- ============================================================================
-- FONCTIONS UTILITAIRES
-- ============================================================================

-- Fonction pour afficher des messages de débogage
local function log(message)
    if CONFIG.ENABLE_OUTPUT then
        OutputLogMessage("[MouseScript] %s\n", message)
    end
end

-- Fonction pour effectuer le mouvement de compensation de recul
local function performRecoilCompensation()
    -- Mouvement vers le bas avec pattern alterné pour un effet plus naturel
    MoveMouseRelative(0, CONFIG.MOVEMENT_Y_PRIMARY)
    Sleep(CONFIG.DELAY_PRIMARY)
    MoveMouseRelative(0, CONFIG.MOVEMENT_Y_SECONDARY)
    Sleep(CONFIG.DELAY_SECONDARY)
end

-- ============================================================================
-- FONCTION PRINCIPALE
-- ============================================================================

-- Active les événements pour les boutons de la souris
EnablePrimaryMouseButtonEvents(true)

-- Fonction de gestion des événements
function OnEvent(event, arg)
    -- Gestion de l'appui sur les boutons
    if event == "MOUSE_BUTTON_PRESSED" then
        
        -- Activation du mode avec le bouton modificateur
        if arg == CONFIG.TRIGGER_BUTTON then
            isActive = true
            log("Mode activé - En attente du clic gauche")
        end
        
        -- Démarrage de la compensation si le bouton de tir est pressé
        if arg == CONFIG.FIRE_BUTTON and isActive then
            log("Compensation de recul démarrée")
            
            -- Boucle de compensation tant que le bouton de tir est maintenu
            -- et que le mode est toujours actif
            while IsMouseButtonPressed(CONFIG.FIRE_BUTTON) and 
                  IsMouseButtonPressed(CONFIG.TRIGGER_BUTTON) do
                performRecoilCompensation()
            end
            
            log("Compensation de recul arrêtée")
        end
    end
    
    -- Gestion du relâchement des boutons
    if event == "MOUSE_BUTTON_RELEASED" then
        
        -- Désactivation du mode
        if arg == CONFIG.TRIGGER_BUTTON then
            isActive = false
            log("Mode désactivé")
        end
    end
end

-- ============================================================================
-- NOTES D'UTILISATION
-- ============================================================================
--[[
    UTILISATION :
    1. Maintenir le bouton 3 (molette) pour activer le mode
    2. Cliquer et maintenir le bouton gauche pour tirer
    3. La souris se déplacera automatiquement vers le bas pour compenser le recul
    4. Relâcher le bouton 3 pour désactiver le mode
    
    PERSONNALISATION :
    - Ajustez MOVEMENT_Y_PRIMARY et MOVEMENT_Y_SECONDARY pour contrôler l'intensité
    - Ajustez DELAY_PRIMARY et DELAY_SECONDARY pour contrôler la vitesse
    - Changez TRIGGER_BUTTON pour utiliser un autre bouton modificateur
    - Activez ENABLE_OUTPUT pour voir les logs de débogage
    
    AMÉLIORATION PAR RAPPORT À L'ORIGINAL :
    ✓ Gestion correcte des événements MOUSE_BUTTON_PRESSED/RELEASED
    ✓ État actif/inactif pour éviter les activations non désirées
    ✓ Configuration centralisée et facilement modifiable
    ✓ Code commenté et organisé
    ✓ Fonction de logging pour le débogage
    ✓ Vérification double (bouton tir ET bouton modificateur) dans la boucle
    ✓ Meilleure gestion de la charge CPU
    ✓ Code plus maintenable et extensible
]]
