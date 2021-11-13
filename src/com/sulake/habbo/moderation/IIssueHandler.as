package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IIssueHandler extends IDisposable 
    {

        function updateIssuesAndMessages():void;
        function showDefaultSanction(_arg_1:int, _arg_2:String):void;

    }
}