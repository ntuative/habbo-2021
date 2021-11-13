package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IGameArenaExtension extends IDisposable 
    {

        function createGameStage():IGameStage;
        function set gameArena(_arg_1:SynchronizedGameArena):void;
        function pulse():void;
        function getPulseInterval():int;
        function getNumberOfSubTurns():int;

    }
}