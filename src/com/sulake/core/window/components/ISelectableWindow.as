package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;

    public /*dynamic*/ interface ISelectableWindow extends IWindow 
    {

        function get selector():ISelectorWindow;
        function get isSelected():Boolean;
        function set isSelected(_arg_1:Boolean):void;
        function select():Boolean;
        function unselect():Boolean;

    }
}