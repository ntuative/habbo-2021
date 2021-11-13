package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IAvatarEffectListener extends IDisposable 
    {

        function avatarEffectReady(_arg_1:int):void;

    }
}