package com.sulake.core.window.components
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class RegionController extends ContainerController implements IRegionWindow 
    {

        protected static const KEY_TOOLTIP_CAPTION:String = "tool_tip_caption";
        protected static const DEF_TOOLTIP_CAPTION:String = "";
        protected static const KEY_TOOLTIP_DELAY:String = "tool_tip_delay";
        protected static const DEF_TOOLTIP_DELAY:uint = 500;

        protected var _SafeStr_915:uint = 500;
        protected var _toolTipCaption:String = "";
        protected var _SafeStr_916:Boolean = false;
        protected var _SafeStr_917:Map;

        public function RegionController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x01);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        public function set toolTipCaption(_arg_1:String):void
        {
            _toolTipCaption = ((_arg_1 == null) ? "" : _arg_1);
        }

        public function get toolTipCaption():String
        {
            return (_toolTipCaption);
        }

        public function set toolTipDelay(_arg_1:uint):void
        {
            _SafeStr_915 = _arg_1;
        }

        public function get toolTipDelay():uint
        {
            return (_SafeStr_915);
        }

        public function showToolTip(_arg_1:IToolTipWindow):void
        {
        }

        public function hideToolTip():void
        {
        }

        public function setMouseCursorForState(_arg_1:uint, _arg_2:uint):uint
        {
            if (!_SafeStr_917)
            {
                _SafeStr_917 = new Map();
            };
            var _local_3:uint = _SafeStr_917[_arg_1];
            if (((_arg_2 == 0) || (_arg_2 == -1)))
            {
                _SafeStr_917.remove(_arg_1);
            }
            else
            {
                _SafeStr_917[_arg_1] = _arg_2;
            };
            return (_local_3);
        }

        public function getMouseCursorByState(_arg_1:uint):uint
        {
            if (testStateFlag(32))
            {
                return (1);
            };
            if (!_SafeStr_917)
            {
                return (0);
            };
            return (_SafeStr_917.getValue(_arg_1));
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (_arg_1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, _arg_2);
            };
            return (_local_3);
        }

        override public function get properties():Array
        {
            return (InteractiveController.writeInteractiveWindowProperties(this, super.properties));
        }

        override public function set properties(_arg_1:Array):void
        {
            InteractiveController.readInteractiveWindowProperties(this, _arg_1);
            super.properties = _arg_1;
        }

        public function set toolTipIsDynamic(_arg_1:Boolean):void
        {
            _SafeStr_916 = _arg_1;
        }

        public function get toolTipIsDynamic():Boolean
        {
            return (_SafeStr_916);
        }


    }
}

