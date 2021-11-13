package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class RadioButtonController extends SelectableController implements IRadioButtonWindow 
    {

        protected static const TEXT_FIELD_NAME:String = "_CAPTION_TEXT";

        public function RadioButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x01);
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

        override public function setRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            super.setRectangle(_arg_1, _arg_2, _arg_3, _arg_4);
            var _local_5:ITextWindow = (getChildByName("_CAPTION_TEXT") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.width = _arg_3;
            };
        }


    }
}