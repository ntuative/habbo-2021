package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IRadioButtonSelectionWindow extends IWindowContainer 
    {

        function get selected():IRadioButtonWindow;
        function radioButtonSelection(_arg_1:IRadioButtonWindow):void;

    }
}