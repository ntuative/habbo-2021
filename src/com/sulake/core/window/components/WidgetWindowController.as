package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.IWidgetFactory;
    import com.sulake.core.window.IWidget;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;

    public class WidgetWindowController extends WindowController implements IWidgetWindow
    {

        private var _SafeStr_959:IWidgetFactory;
        private var _SafeStr_960:String = "";
        private var _widget:IWidget;

        public function WidgetWindowController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _SafeStr_959 = _arg_5.getWidgetFactory();
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_widget != null)
                {
                    _widget.dispose();
                    _widget = null;
                };
                _SafeStr_959 = null;
                super.dispose();
            };
        }

        override public function get properties():Array
        {
            var _local_1:Array = ((_widget != null) ? _widget.properties : []);
            _local_1.unshift(createProperty("widget_type", _SafeStr_960));
            return (super.properties.concat(_local_1));
        }

        override public function set properties(_arg_1:Array):void
        {
            var _local_3:String;
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                if (_local_2.key == "widget_type")
                {
                    _local_3 = String(_local_2.value);
                    if (_SafeStr_960 != _local_3)
                    {
                        if (_widget != null)
                        {
                            removeChildAt(0);
                            _widget.dispose();
                        };
                        _widget = _SafeStr_959.createWidget(String(_local_2.value), this);
                        _SafeStr_960 = _local_3;
                    };
                    break;
                };
            };
            if (_widget != null)
            {
                _widget.properties = _arg_1;
            };
            super.properties = _arg_1;
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

        public function get iterator():IIterator
        {
            return ((_widget != null) ? _widget.iterator : EmptyIterator.INSTANCE);
        }

        public function get widget():IWidget
        {
            return (_widget);
        }

        public function get rootWindow():IWindow
        {
            return (getChildAt(0));
        }

        public function set rootWindow(_arg_1:IWindow):void
        {
            removeChildAt(0);
            if (_arg_1 == null)
            {
                return;
            };
            addChild(_arg_1);
            if (_arg_1.tags.indexOf("_EXCLUDE") < 0)
            {
                _arg_1.tags.push("_EXCLUDE");
            };
        }


    }
}