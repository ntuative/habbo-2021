package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class HeaderController extends ContainerController implements IHeaderWindow 
    {

        private static const TAG_TITLE_ELEMENT:String = "_TITLE";
        private static const TAG_CONTROLS_ELEMENT:String = "_CONTROLS";

        public function HeaderController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x01);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function get title():ILabelWindow
        {
            return (findChildByTag("_TITLE") as ILabelWindow);
        }

        public function get controls():IItemListWindow
        {
            return (findChildByTag("_CONTROLS") as IItemListWindow);
        }

        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            try
            {
                title.text = _arg_1;
            }
            catch(e:Error)
            {
            };
        }

        override public function set color(_arg_1:uint):void
        {
            super.color = _arg_1;
            var _local_2:Array = [];
            groupChildrenWithTag("_COLORIZE", _local_2, -1);
            for each (var _local_3:IWindow in _local_2)
            {
                _local_3.color = _arg_1;
            };
        }


    }
}