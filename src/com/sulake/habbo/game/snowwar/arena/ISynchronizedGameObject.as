package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface ISynchronizedGameObject extends IGameObject, IDisposable 
    {

        function get isActive():Boolean;
        function set isActive(_arg_1:Boolean):void;
        function get numberOfVariables():int;
        function getVariable(_arg_1:int):int;
        function subturn(_arg_1:SynchronizedGameStage):void;
        function onRemove():void;

    }
}