package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public /*dynamic*/ interface ElementTypeHolder 
    {

        function getElementByCode(_arg_1:int):Element;
        function getKey():String;
        function acceptTriggerable(_arg_1:Triggerable):Boolean;

    }
}