package com.sulake.habbo.campaign.calendar
{
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Matrix;

    public class CalendarSpinnerUtil 
    {


        public static function createGradients(_arg_1:CalendarView, _arg_2:int):void
        {
            var _local_6:IBitmapWrapperWindow = (_arg_1.window.findChildByName("gradient1") as IBitmapWrapperWindow);
            var _local_7:int = Math.max(1, (_arg_1.calculateItemListWidth(_arg_2) - (_arg_1.itemList.scrollH * _arg_1.itemList.maxScrollH)));
            var _local_4:BitmapData = new BitmapData(_local_7, _arg_1.itemList.height, true, 0);
            var _local_5:Sprite = new Sprite();
            var _local_3:Matrix = new Matrix();
            _local_3.createGradientBox(_local_4.width, _local_4.height);
            _local_5.graphics.beginGradientFill("linear", [987168, 987168], [0.6, 0.2], [0, 0xFF], _local_3);
            _local_5.graphics.drawRect(0, 0, _local_4.width, _local_4.height);
            _local_4.draw(_local_5);
            _local_6.bitmap = _local_4;
            _local_6 = (_arg_1.window.findChildByName("gradient2") as IBitmapWrapperWindow);
            _local_7 = Math.max(1, (_arg_1.scrollerWidth - ((_local_7 + _arg_1.itemWidth) + _arg_1.itemGap)));
            _local_4 = new BitmapData(_local_7, _arg_1.itemList.height, true, 0);
            _local_3.createGradientBox(_local_4.width, _local_4.height);
            _local_5.graphics.clear();
            _local_5.graphics.beginGradientFill("linear", [987168, 987168], [0.2, 0.6], [0, 0xFF], _local_3);
            _local_5.graphics.drawRect(0, 0, _local_4.width, _local_4.height);
            _local_4.draw(_local_5);
            _local_6.x = (_arg_1.scrollerWidth - _local_7);
            _local_6.bitmap = _local_4;
        }


    }
}