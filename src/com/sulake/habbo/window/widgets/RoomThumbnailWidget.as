package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IIterator;

    public class RoomThumbnailWidget implements IRoomThumbnailWidget 
    {

        public static const TYPE:String = "room_thumbnail";

        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;

        public function RoomThumbnailWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("room_thumbnail_xml").content as XML)) as IWindowContainer);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_1165.width = _SafeStr_4407.width;
            _SafeStr_1165.height = _SafeStr_4407.height;
        }

        public function reset():void
        {
        }

        public function set flatId(_arg_1:int):void
        {
        }

        public function get properties():Array
        {
            return (null);
        }

        public function set properties(_arg_1:Array):void
        {
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function get iterator():IIterator
        {
            return (null);
        }


    }
}

