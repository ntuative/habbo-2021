package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;

    public class ButtonController extends InteractiveController implements _SafeStr_101, ITouchAwareWindow 
    {

        protected static const TEXT_FIELD_NAME:String = "_BTN_TEXT";
        protected static const CAPTION_BLEND_CHANGE:Number = 0.5;

        public function ButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x020000);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:IWindow = getChildByName("_BTN_TEXT");
            if (_local_2 != null)
            {
                _local_2.caption = caption;
            };
        }

        override public function set blend(_arg_1:Number):void
        {
            super.blend = _arg_1;
            var _local_3:IWindow = getChildByName("_BTN_TEXT");
            var _local_2:Boolean = getStateFlag(32);
            if (_local_3 != null)
            {
                _local_3.blend = ((_local_2) ? (_arg_1 / 2) : _arg_1);
            };
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_5:String;
            var _local_4:WindowEvent;
            var _local_3:Boolean;
            if ((_arg_2 is WindowEvent))
            {
                switch (_arg_2.type)
                {
                    case "WE_CHILD_RESIZED":
                        width = 0;
                        break;
                    case "WE_ENABLED":
                        try
                        {
                            getChildByName("_BTN_TEXT").blend = (getChildByName("_BTN_TEXT").blend + 0.5);
                        }
                        catch(e:Error)
                        {
                        };
                        break;
                    case "WE_DISABLED":
                        try
                        {
                            getChildByName("_BTN_TEXT").blend = (getChildByName("_BTN_TEXT").blend - 0.5);
                        }
                        catch(e:Error)
                        {
                        };
                };
            }
            else
            {
                if ((_arg_2 is WindowTouchEvent))
                {
                    _local_5 = "";
                    switch (_arg_2.type)
                    {
                        case "WTE_BEGIN":
                            _local_5 = "WME_DOWN";
                            break;
                        case "WTE_END":
                            _local_5 = "WME_UP";
                            break;
                        case "WTE_TAP":
                            _local_5 = "WME_CLICK";
                    };
                    _local_4 = WindowMouseEvent.allocate(_local_5, WindowTouchEvent(_arg_2).window, WindowTouchEvent(_arg_2).related, WindowTouchEvent(_arg_2).localX, WindowTouchEvent(_arg_2).localY, WindowTouchEvent(_arg_2).stageX, WindowTouchEvent(_arg_2).stageY, WindowTouchEvent(_arg_2).altKey, WindowTouchEvent(_arg_2).ctrlKey, WindowTouchEvent(_arg_2).shiftKey, true, 0);
                    _local_3 = super.update(_arg_1, _local_4);
                    _local_4.recycle();
                    return (_local_3);
                };
            };
            return (super.update(_arg_1, _arg_2));
        }


    }
}

