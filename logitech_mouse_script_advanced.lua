-- ============================================================================
-- Script Logitech G HUB/LGS - Version avancée avec patterns multiples
-- ============================================================================
-- Description: Version avancée avec plusieurs modes de compensation de recul
-- ============================================================================

-- CONFIGURATION
local CONFIG = {
    -- Boutons
    TRIGGER_BUTTON = 3,        -- Bouton modificateur (molette)
    FIRE_BUTTON = 1,           -- Bouton de tir (clic gauche)
    TOGGLE_MODE_BUTTON = 4,    -- Bouton pour changer de mode (bouton latéral)
    
    -- Modes de recul (facile à personnaliser pour différentes armes)
    MODES = {
        {
            name = "Léger",
            moves = {
                {x = 0, y = 1, delay = 15},
                {x = 0, y = 1, delay = 15},
            }
        },
        {
            name = "Moyen",
            moves = {
                {x = 0, y = 2, delay = 10},
                {x = 0, y = 1, delay = 12},
            }
        },
        {
            name = "Fort",
            moves = {
                {x = 0, y = 3, delay = 8},
                {x = 0, y = 2, delay = 10},
            }
        },
        {
            name = "Très Fort",
            moves = {
                {x = 0, y = 4, delay = 7},
                {x = 0, y = 3, delay = 9},
            }
        },
        {
            name = "Spray Pattern",
            moves = {
                {x = 0, y = 2, delay = 10},
                {x = -1, y = 2, delay = 10},  -- Légère déviation gauche
                {x = 1, y = 1, delay = 12},   -- Correction droite
                {x = 0, y = 2, delay = 10},
            }
        }
    },
    
    -- Options
    ENABLE_OUTPUT = true,      -- Afficher les messages
    DEFAULT_MODE = 2,          -- Mode par défaut (1-5)
}

-- ============================================================================
-- VARIABLES GLOBALES
-- ============================================================================
local isActive = false
local currentMode = CONFIG.DEFAULT_MODE
local moveIndex = 1

-- ============================================================================
-- FONCTIONS UTILITAIRES
-- ============================================================================

local function log(message)
    if CONFIG.ENABLE_OUTPUT then
        OutputLogMessage("[MouseScript] %s\n", message)
    end
end

local function getCurrentModeName()
    return CONFIG.MODES[currentMode].name
end

local function changeMode()
    currentMode = currentMode + 1
    if currentMode > #CONFIG.MODES then
        currentMode = 1
    end
    log("Mode changé: " .. getCurrentModeName())
    
    -- Feedback visuel optionnel (clignotement LED si disponible)
    -- SetBacklightColor(255, 100, 0, 200)
    -- Sleep(200)
    -- SetBacklightColor(0, 0, 0, 0)
end

local function performRecoilCompensation()
    local mode = CONFIG.MODES[currentMode]
    local move = mode.moves[moveIndex]
    
    -- Effectuer le mouvement
    MoveMouseRelative(move.x, move.y)
    Sleep(move.delay)
    
    -- Passer au mouvement suivant (pattern circulaire)
    moveIndex = moveIndex + 1
    if moveIndex > #mode.moves then
        moveIndex = 1
    end
end

local function resetMoveIndex()
    moveIndex = 1
end

-- ============================================================================
-- FONCTION PRINCIPALE
-- ============================================================================

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if event == "MOUSE_BUTTON_PRESSED" then
        
        -- Changement de mode
        if arg == CONFIG.TOGGLE_MODE_BUTTON then
            changeMode()
            return
        end
        
        -- Activation du système
        if arg == CONFIG.TRIGGER_BUTTON then
            isActive = true
            log("Activé - Mode: " .. getCurrentModeName())
            resetMoveIndex()
        end
        
        -- Compensation active
        if arg == CONFIG.FIRE_BUTTON and isActive then
            log("Tir détecté - Compensation en cours...")
            
            while IsMouseButtonPressed(CONFIG.FIRE_BUTTON) and 
                  IsMouseButtonPressed(CONFIG.TRIGGER_BUTTON) do
                performRecoilCompensation()
            end
            
            log("Tir terminé")
            resetMoveIndex()
        end
    end
    
    if event == "MOUSE_BUTTON_RELEASED" then
        if arg == CONFIG.TRIGGER_BUTTON then
            isActive = false
            log("Désactivé")
            resetMoveIndex()
        end
    end
end

-- ============================================================================
-- NOTES
-- ============================================================================
--[[
    NOUVELLES FONCTIONNALITÉS :
    
    ✓ 5 modes de recul prédéfinis (léger à très fort)
    ✓ Mode "Spray Pattern" avec corrections horizontales
    ✓ Changement de mode avec le bouton 4 (latéral)
    ✓ Pattern de mouvement cyclique pour chaque mode
    ✓ Réinitialisation automatique du pattern
    ✓ Facilement extensible pour ajouter de nouveaux modes
    
    UTILISATION :
    1. Appuyer sur bouton 4 pour changer de mode
    2. Maintenir bouton 3 (molette) pour activer
    3. Tirer avec le clic gauche pour compenser le recul
    
    PERSONNALISATION PAR ARME :
    Ajoutez vos propres modes dans CONFIG.MODES :
    {
        name = "AK-47",
        moves = {
            {x = 0, y = 3, delay = 8},   -- Premier tir
            {x = -1, y = 3, delay = 9},  -- Déviation gauche
            {x = 2, y = 2, delay = 10},  -- Correction droite
            -- etc...
        }
    }
]]
