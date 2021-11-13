package com.sulake.habbo.game
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;

    public /*dynamic*/ interface IHabboGameManager extends IUnknown 
    {

        function initGameDirectoryConnection():void;
        function startSnowWarGame(_arg_1:String):void;
        function startQuickSnowWarGame():void;
        function onSnowWarArenaSessionEnded():void;
        function get events():IEventDispatcher;
        function handleClickOnTile(_arg_1:RoomObjectTileMouseEvent):void;
        function handleClickOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void;
        function generateChecksumMismatch():void;
        function handleMouseOverOnHuman(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void;
        function get gameCenterEnabled():Boolean;
        function get isHotelClosed():Boolean;

    }
}