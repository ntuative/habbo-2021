package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.*;

    public class UserCountRenderer 
    {

        public static const USERCOUNT_ELEMENT_NAME:String = "usercount";

        private var _navigator:IHabboTransitionalNavigator;

        public function UserCountRenderer(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
        }

        public function dispose():void
        {
            _navigator = null;
        }

        public function refreshUserCount(_arg_1:int, _arg_2:IWindowContainer, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:int):void
        {
            var _local_9:IWindowContainer = IWindowContainer(_arg_2.findChildByName("usercount"));
            if (_local_9 == null)
            {
                _local_9 = IWindowContainer(_navigator.getXmlWindow("grs_usercount"));
                _local_9.name = "usercount";
                _local_9.x = _arg_5;
                _local_9.y = _arg_6;
                _arg_2.addChild(_local_9);
            };
            IInteractiveWindow(_local_9).toolTipCaption = _arg_4;
            var _local_7:ITextWindow = ITextWindow(_local_9.findChildByName("txt"));
            _local_7.text = ("" + _arg_3);
            var _local_8:String = this.getBgColor(_arg_1, _arg_3);
            refreshBg(_local_9, _local_8);
            _local_9.visible = true;
        }

        private function getBgColor(_arg_1:int, _arg_2:int):String
        {
            if (_arg_2 == 0)
            {
                return ("b");
            };
            if (isOverBgColorLimit(_arg_1, _arg_2, "red", 92))
            {
                return ("r");
            };
            if (isOverBgColorLimit(_arg_1, _arg_2, "orange", 80))
            {
                return ("o");
            };
            if (isOverBgColorLimit(_arg_1, _arg_2, "yellow", 50))
            {
                return ("y");
            };
            return ("g");
        }

        private function isOverBgColorLimit(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):Boolean
        {
            var _local_7:String = ("navigator.colorlimit." + _arg_3);
            var _local_6:int = _navigator.getInteger(_local_7, _arg_4);
            var _local_5:int = int(((_arg_1 * _local_6) / 100));
            return (_arg_2 >= _local_5);
        }

        private function refreshBg(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_3:String;
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("usercount_bg"));
            if (_local_4.tags[0] != _arg_2)
            {
                _local_4.tags.splice(0, _local_4.tags.length);
                _local_4.tags.push(_arg_2);
                _local_3 = ("usercount_fixed_" + _arg_2);
                _local_4.bitmap = _navigator.getButtonImage(_local_3);
                _local_4.disposesBitmap = false;
                _local_4.invalidate();
            };
        }

        private function refreshIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean):void
        {
            _navigator.refreshButton(_arg_1, _arg_2, _arg_3, null, 0);
        }


    }
}