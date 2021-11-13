package com.sulake.habbo.freeflowchat.history.visualization.entry
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public /*dynamic*/ interface IChatHistoryEntryBitmap 
    {

        function get bitmap():BitmapData;
        function get overlap():Rectangle;
        function get userId():int;
        function get roomId():int;
        function get canIgnore():Boolean;
        function get userName():String;

    }
}