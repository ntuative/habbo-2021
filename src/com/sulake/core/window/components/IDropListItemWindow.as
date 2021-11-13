package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;

    public /*dynamic*/ interface IDropListItemWindow extends _SafeStr_101 
    {

        function get menu():IDropMenuWindow;
        function get value():IWindow;
        function set value(_arg_1:IWindow):void;

    }
}

