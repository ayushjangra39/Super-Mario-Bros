--[[
    Super Mario Bros

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

-- Libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- Our own code

-- Utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- Game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

-- Entity states
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'

require 'src/states/entity/snail/SnailChasingState'
require 'src/states/entity/snail/SnailIdleState'
require 'src/states/entity/snail/SnailMovingState'

-- General game classes
require 'src/Animation'
require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Snail'
require 'src/Tile'
require 'src/TileMap'

-- Safe asset loader for sounds
local function safeNewSound(path, soundType)
    if love.filesystem.getInfo(path) then
        return love.audio.newSource(path, soundType or "static")
    else
        print('[Sound Missing] ' .. path)
        return nil
    end
end

-- Sounds
gSounds = {
    ['jump'] = safeNewSound('sounds/jump.wav'),
    ['death'] = safeNewSound('sounds/death.wav'),
    ['music'] = safeNewSound('sounds/music.wav', 'stream'), -- stream for long music
    ['powerup-reveal'] = safeNewSound('sounds/powerup-reveal.wav'),
    ['pickup'] = safeNewSound('sounds/pickup.wav'),
    ['empty-block'] = safeNewSound('sounds/empty-block.wav'),
    ['kill'] = safeNewSound('sounds/kill.wav'),
    ['kill2'] = safeNewSound('sounds/kill2.wav')
}

-- Textures
gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
    ['bushes'] = love.graphics.newImage('graphics/bushes_and_cacti.png'),
    ['jump-blocks'] = love.graphics.newImage('graphics/jump_blocks.png'),
    ['gems'] = love.graphics.newImage('graphics/gems.png'),
    ['backgrounds'] = love.graphics.newImage('graphics/backgrounds.png'),
    ['green-alien'] = love.graphics.newImage('graphics/green_alien.png'),
    ['creatures'] = love.graphics.newImage('graphics/creatures.png')
}

-- Frames from textures
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),
    ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
    ['jump-blocks'] = GenerateQuads(gTextures['jump-blocks'], 16, 16),
    ['gems'] = GenerateQuads(gTextures['gems'], 16, 16),
    ['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
    ['green-alien'] = GenerateQuads(gTextures['green-alien'], 16, 20),
    ['creatures'] = GenerateQuads(gTextures['creatures'], 16, 16)
}

-- Add tilesets and toppersets after basic frames
gFrames['tilesets'] = GenerateTileSets(
    gFrames['tiles'],
    TILE_SETS_WIDE,
    TILE_SETS_TALL,
    TILE_SET_WIDTH,
    TILE_SET_HEIGHT
)

gFrames['toppersets'] = GenerateTileSets(
    gFrames['toppers'],
    TOPPER_SETS_WIDE,
    TOPPER_SETS_TALL,
    TILE_SET_WIDTH,
    TILE_SET_HEIGHT
)

-- Fonts
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}
