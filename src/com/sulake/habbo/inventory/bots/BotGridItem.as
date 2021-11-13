package com.sulake.habbo.inventory.bots
{
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class BotGridItem 
    {

        private static const THUMB_COLOR_NORMAL:int = 0xCCCCCC;
        private static const THUMB_COLOR_UNSEEN:int = 10275685;

        private var _data:BotData;
        private var _window:IWindowContainer;
        private var _assets:IAssetLibrary;
        private var _SafeStr_1277:IWindow;
        private var _SafeStr_1288:Boolean;
        private var _SafeStr_570:BotsView;
        private var _SafeStr_2723:int = -1;
        private var _SafeStr_2724:Boolean;
        private var _isUnseen:Boolean;

        public function BotGridItem(_arg_1:BotsView, _arg_2:BotData, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:Boolean)
        {
            if (((((_arg_1 == null) || (_arg_2 == null)) || (_arg_3 == null)) || (_arg_4 == null)))
            {
                return;
            };
            _assets = _arg_4;
            _SafeStr_570 = _arg_1;
            _data = _arg_2;
            _isUnseen = _arg_5;
            var _local_7:XmlAsset = (_arg_4.getAssetByName("inventory_thumb_xml") as XmlAsset);
            if (((_local_7 == null) || (_local_7.content == null)))
            {
                return;
            };
            _window = (_arg_3.buildFromXML((_local_7.content as XML)) as IWindowContainer);
            _window.procedure = eventHandler;
            var _local_6:BitmapData = _arg_1.getGridItemImage(_arg_2);
            setImage(_local_6);
            updateStatusGraphics();
        }

        public function dispose():void
        {
            _assets = null;
            _SafeStr_570 = null;
            _data = null;
            _SafeStr_1277 = null;
            _SafeStr_2723 = -1;
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WME_DOWN":
                    _SafeStr_570.setSelectedGridItem(this);
                    _SafeStr_2724 = true;
                    return;
                case "WME_UP":
                    _SafeStr_2724 = false;
                    return;
                case "WME_OUT":
                    if (_SafeStr_2724)
                    {
                        _SafeStr_2724 = false;
                        _SafeStr_570.placeItemToRoom(_data.id, true);
                    };
                    return;
            };
        }

        public function setImage(_arg_1:BitmapData):void
        {
            if (!_window)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName("bitmap") as IBitmapWrapperWindow);
            var _local_2:BitmapData = new BitmapData(_local_3.width, _local_3.height);
            _local_2.fillRect(_local_2.rect, 0);
            _local_2.copyPixels(_arg_1, _arg_1.rect, new Point(((_local_2.width / 2) - (_arg_1.width / 2)), ((_local_2.height / 2) - (_arg_1.height / 2))));
            if (_local_3.bitmap)
            {
                _local_3.bitmap.dispose();
            };
            _local_3.bitmap = _local_2;
        }

        public function setUnseen(_arg_1:Boolean):void
        {
            if (_isUnseen != _arg_1)
            {
                _isUnseen = _arg_1;
                updateStatusGraphics();
            };
        }

        public function setSelected(_arg_1:Boolean):void
        {
            if (_SafeStr_1288 != _arg_1)
            {
                _SafeStr_1288 = _arg_1;
                if (((!(_window)) || (!(_SafeStr_1277))))
                {
                    return;
                };
                updateStatusGraphics();
            };
        }

        private function updateStatusGraphics():void
        {
            var _local_1:IWindow = _window.findChildByName("outline");
            if (_local_1 != null)
            {
                _local_1.visible = _SafeStr_1288;
            };
            if (!_SafeStr_1277)
            {
                _SafeStr_1277 = _window.findChildByTag("BG_COLOR");
            };
            _SafeStr_1277.color = ((_isUnseen) ? 10275685 : 0xCCCCCC);
        }

        public function get window():IWindow
        {
            return (_window);
        }

        public function get data():BotData
        {
            return (_data);
        }


    }
}

