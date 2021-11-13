package com.sulake.habbo.friendbar
{
    import com.sulake.core.runtime.IUnknown;

    public /*dynamic*/ interface IHabboLandingView extends IUnknown 
    {

        function activate():void;
        function disable():void;

    }
}