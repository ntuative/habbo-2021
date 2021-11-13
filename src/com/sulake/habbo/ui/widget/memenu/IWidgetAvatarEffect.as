package com.sulake.habbo.ui.widget.memenu
{
    import flash.display.BitmapData;

    public /*dynamic*/ interface IWidgetAvatarEffect 
    {

        function get amountInInventory():int;
        function get type():int;
        function get secondsLeft():int;
        function get duration():int;
        function get isActive():Boolean;
        function get isInUse():Boolean;
        function get icon():BitmapData;

    }
}