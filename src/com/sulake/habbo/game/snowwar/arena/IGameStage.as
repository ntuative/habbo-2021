package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;

    public /*dynamic*/ interface IGameStage extends IDisposable 
    {

        function initialize(_arg_1:SynchronizedGameArena, _arg_2:GameLevelData):void;
        function get gameArena():SynchronizedGameArena;
        function get roomType():String;

    }
}