package com.sulake.habbo.inventory
{
    public /*dynamic*/ interface IAvatarEffect 
    {

        function get type():int;
        function get subType():int;
        function get secondsLeft():int;
        function get duration():int;
        function get isActive():Boolean;
        function get isSelected():Boolean;

    }
}