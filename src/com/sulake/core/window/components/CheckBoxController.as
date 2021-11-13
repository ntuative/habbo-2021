package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class CheckBoxController extends SelectableController implements _SafeStr_108 
    {

        protected static const TEXT_FIELD_NAME:String = "_CAPTION_TEXT";

        public function CheckBoxController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:IWindow = getChildByName("_CAPTION_TEXT");
            if (_local_2 != null)
            {
                _local_2.caption = caption;
            };
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_1 == this)
            {
                switch (_arg_2.type)
                {
                    case "WME_UP":
                        if (isSelected)
                        {
                            unselect();
                        }
                        else
                        {
                            select();
                        };
                };
            };
            return (super.update(_arg_1, _arg_2));
        }


    }
}

