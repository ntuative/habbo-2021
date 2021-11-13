package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.iterators.ContainerIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;

    public class ContainerController extends WindowController implements IWindowContainer 
    {

        public function ContainerController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_899 = (((_background) || (testParamFlag(1))) || (!(testParamFlag(16))));
        }

        public function get iterator():IIterator
        {
            return (new ContainerIterator(this));
        }

        override public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_897))))
            {
                _SafeStr_897 = new GraphicContext((("GC {" + _name) + "}"), ((testParamFlag(16)) ? 4 : 1), rectangle);
                _SafeStr_897.visible = _SafeStr_898;
            };
            return (_SafeStr_897);
        }


    }
}

