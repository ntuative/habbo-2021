package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IGameObject extends IDisposable 
    {

        function get gameObjectId():int;
        function get isGhost():Boolean;
        function get ghostObjectId():int;

    }
}