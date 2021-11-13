package com.sulake.habbo.avatar
{
    import flash.display.BitmapData;

    public /*dynamic*/ interface IHabboAvatarEditorAvatarEffect 
    {

        function get amountInInventory():int;
        function get type():int;
        function get subType():int;
        function get secondsLeft():int;
        function get duration():int;
        function get isPermanent():Boolean;
        function get isActive():Boolean;
        function get isInUse():Boolean;
        function get icon():BitmapData;
        function set iconImage(_arg_1:BitmapData):void;
        function get iconImage():BitmapData;
        function set isSelected(_arg_1:Boolean):void;
        function get isSelected():Boolean;

    }
}