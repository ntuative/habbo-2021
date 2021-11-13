package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public /*dynamic*/ interface Element 
    {

        function get code():int;
        function get negativeCode():int;
        function get requiresFurni():int;
        function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void;
        function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void;
        function readIntParamsFromForm(_arg_1:IWindowContainer):Array;
        function readStringParamFromForm(_arg_1:IWindowContainer):String;
        function get hasSpecialInputs():Boolean;
        function get hasStateSnapshot():Boolean;
        function validate(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):String;

    }
}