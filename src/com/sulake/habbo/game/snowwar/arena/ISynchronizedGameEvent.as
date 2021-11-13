package com.sulake.habbo.game.snowwar.arena
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface ISynchronizedGameEvent extends IDisposable 
    {

        function apply(_arg_1:SynchronizedGameStage):void;

    }
}