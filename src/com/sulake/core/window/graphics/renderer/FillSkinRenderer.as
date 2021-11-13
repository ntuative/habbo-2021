package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class FillSkinRenderer extends SkinRenderer 
    {

        public function FillSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
        }

        override public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            _arg_2.fillRect(_arg_3, _arg_1.color);
        }


    }
}