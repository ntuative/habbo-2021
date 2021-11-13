package com.sulake.core.window.utils
{
    import flash.text.TextField;

    public /*dynamic*/ interface ITextFieldContainer 
    {

        function get textField():TextField;
        function get margins():IMargins;

    }
}