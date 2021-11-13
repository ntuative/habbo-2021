package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.utils.DefaultAttStruct;

    public /*dynamic*/ interface ISkinContainer extends IDisposable 
    {

        function getSkinRendererByTypeAndStyle(_arg_1:uint, _arg_2:uint):ISkinRenderer;
        function getDefaultAttributesByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct;
        function getTheActualState(_arg_1:uint, _arg_2:uint, _arg_3:uint):uint;

    }
}