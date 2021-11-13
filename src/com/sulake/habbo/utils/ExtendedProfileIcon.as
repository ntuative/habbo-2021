package com.sulake.habbo.utils
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class ExtendedProfileIcon 
    {


        public static function setup(_arg_1:IWindowContainer, _arg_2:Function):void
        {
            var _local_3:IWindow = _arg_1.findChildByName("user_info_region");
            _local_3.addEventListener("WME_OVER", onUserInfoMouseOver);
            _local_3.addEventListener("WME_OUT", onUserInfoMouseOut);
            _local_3.addEventListener("WME_CLICK", _arg_2);
        }

        private static function onUserInfoMouseOver(_arg_1:WindowEvent):void
        {
            var _local_2:IRegionWindow = IRegionWindow(_arg_1.target);
            setUserInfoState(true, _local_2);
        }

        private static function onUserInfoMouseOut(_arg_1:WindowEvent):void
        {
            var _local_2:IRegionWindow = IRegionWindow(_arg_1.target);
            setUserInfoState(false, _local_2);
        }

        public static function setUserInfoState(_arg_1:Boolean, _arg_2:IWindowContainer):void
        {
            _arg_2.findChildByName("icon_eye_off").visible = (!(_arg_1));
            _arg_2.findChildByName("icon_eye_over").visible = _arg_1;
        }

        public static function onEntry(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_OVER")
            {
                ExtendedProfileIcon.setUserInfoState(true, IWindowContainer(_arg_2.parent));
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    ExtendedProfileIcon.setUserInfoState(false, IWindowContainer(_arg_2.parent));
                };
            };
        }


    }
}