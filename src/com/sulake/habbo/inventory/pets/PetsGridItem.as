package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class PetsGridItem 
    {

        private static const THUMB_COLOR_NORMAL:int = 0xCCCCCC;
        private static const THUMB_COLOR_UNSEEN:int = 10275685;

        private var _pet:PetData;
        private var _window:IWindowContainer;
        private var _assets:IAssetLibrary;
        private var _SafeStr_1277:IWindow;
        private var _SafeStr_1288:Boolean;
        private var _SafeStr_2770:PetsView;
        private var _imageDownloadId:int = -1;
        private var _SafeStr_2724:Boolean;
        private var _isUnseen:Boolean;

        public function PetsGridItem(_arg_1:PetsView, _arg_2:PetData, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:Boolean)
        {
            if (((((_arg_1 == null) || (_arg_2 == null)) || (_arg_3 == null)) || (_arg_4 == null)))
            {
                return;
            };
            _assets = _arg_4;
            _SafeStr_2770 = _arg_1;
            _pet = _arg_2;
            _isUnseen = _arg_5;
            var _local_8:XmlAsset = (_arg_4.getAssetByName("inventory_thumb_xml") as XmlAsset);
            if (((_local_8 == null) || (_local_8.content == null)))
            {
                return;
            };
            _window = (_arg_3.buildFromXML((_local_8.content as XML)) as IWindowContainer);
            _window.procedure = eventHandler;
            var _local_7:int = 64;
            var _local_11:int = 3;
            var _local_9:Boolean;
            var _local_6:String;
            if (_arg_2.typeId == 15)
            {
                _local_7 = 32;
                _local_11 = 2;
                _local_9 = true;
            }
            else
            {
                if (_arg_2.typeId == 35)
                {
                    _local_7 = 64;
                    _local_11 = 3;
                    _local_9 = true;
                }
                else
                {
                    if (((_arg_2.typeId == 26) || (_arg_2.typeId == 27)))
                    {
                        _local_7 = 32;
                        _local_11 = 3;
                        _local_9 = true;
                    }
                    else
                    {
                        if (_arg_2.typeId == 16)
                        {
                            _local_7 = 32;
                            _local_11 = 2;
                            _local_9 = true;
                            if (_arg_2.level >= 7)
                            {
                                _local_6 = "std";
                            }
                            else
                            {
                                _local_6 = ("grw" + _arg_2.level);
                            };
                        };
                    };
                };
            };
            var _local_10:BitmapData = _arg_1.getPetImage(_arg_2, _local_11, _local_9, this, _local_7, _local_6);
            setPetImage(_local_10);
            updateStatusGraphics();
        }

        public function dispose():void
        {
            _assets = null;
            _SafeStr_2770 = null;
            _pet = null;
            _SafeStr_1277 = null;
            _imageDownloadId = -1;
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
                    _SafeStr_2770.setSelectedGridItem(this);
                    _SafeStr_2724 = true;
                    return;
                case "WME_UP":
                    _SafeStr_2724 = false;
                    return;
                case "WME_OUT":
                    if (_SafeStr_2724)
                    {
                        _SafeStr_2724 = false;
                        _SafeStr_2770.placePetToRoom(_pet.id, true);
                    };
                    return;
            };
        }

        public function setPetImage(_arg_1:BitmapData):void
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

        public function get pet():PetData
        {
            return (_pet);
        }

        public function set imageDownloadId(_arg_1:int):void
        {
            _imageDownloadId = _arg_1;
        }

        public function get imageDownloadId():int
        {
            return (_imageDownloadId);
        }


    }
}

